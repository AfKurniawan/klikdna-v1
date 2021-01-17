import 'dart:convert';
import 'dart:io';

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/widgets/bottom_sheet_item_widget.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportProvider extends ChangeNotifier {
  List<ReportData> listSample = [];
  List<Detail> listDetail = [];
  List<Detail> listDetail2 = [];
  bool isLoading;


  Future<List<ReportModel>> getSample(BuildContext context, String personId) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = AppConstants.GET_SAMPLE_URL + '$personId';
    final prov = Provider.of<TokenProvider>(context, listen: false);

    print("Person ID: $personId");

    String accessToken = prov.accessToken;

    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.get(url, headers: ndas);
    print("SAMPLE RESPONSE CODE: ${request.body}");

    if (request.statusCode == 200) {
      isLoading = false;
      var allArray = json.decode(request.body);

      var dataArray = allArray['data'] as List;
      listSample = dataArray.map<ReportData>((j) => ReportData.fromJson(j)).toList();

      var detailArray = dataArray[0]['detail'] as List;
      listDetail = detailArray.map<Detail>((j) => Detail.fromJson(j)).toList();

      var detail2Array = allArray['data'][1]['detail'] as List;
      listDetail2 = detail2Array.map<Detail>((j) => Detail.fromJson(j)).toList();

      print("LST DETAAIL @___$listDetail2");

      prefs.remove('tempPersonId');

      notifyListeners();
    } else if (request.statusCode == 404) {
      print("REPORT Not Found");
      listSample = [];
      isLoading = false;
      notifyListeners();
      listDetail.clear();
    } else if (request.statusCode == 500) {
      listSample = [];
      isLoading = false;
      notifyListeners();
      listDetail.clear();
    }

    return null;
  }


  String linkPdf ;
  String filename ;
  Future<ReportData> getLinkPdf(BuildContext context, String reportId) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String person = prefs.getString("personId");
    var url = AppConstants.GET_REPORT_DETAIL_URL;
    final prov = Provider.of<TokenProvider>(context, listen: false);
    print("PERSON ID: $person");

    String accessToken = prov.accessToken;
    print("AKSES TOKEN: $accessToken");
    print("REPORT ID: $reportId");
    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var body = {
      "person_id": "$person",
      "report_id": "$reportId"
    };

    final request = await http.post(url, headers: ndas, body: body);
    print("DETAIL REPORT RESPONSE CODE: ${request.statusCode}");

    if(request.statusCode == 200) {
      final reportResponse = DetailReportModel.fromJson(json.decode(request.body));
      linkPdf = reportResponse.data.linkPdf;
      filename = reportResponse.data.reportId + reportResponse.data.reportId;
      notifyListeners();

      print("LINK PDF $linkPdf");

      _downloadFile(context, linkPdf, filename);

    } else {

    }


    return null ;

  }



  double _progress = 0;
  get downloadProgress => _progress;
  bool downloadState = false;


  Future<File> _downloadFile(BuildContext context, String linkPdf, String filename) async {
    _progress = null;
    //downloadState = true;
    notifyListeners();

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    //String filename = "Hello.pdf";
    //var url = "https://dnaku.id/kdm/report/export-pdf-lifestyle/USER-2OYILU/WLS_DLHEA1-2665";

    Map<String, String> ndas = {
      "Accept": "application/json",
      "app_key": "kdm2020!",
      "shared_key": "8d8105c406649d5c438b1e1eb41118c57282e0fab3f43c5b21712fb7a3955ad3"
    };

    final response = await http.get(linkPdf, headers: ndas);
    print("CONTENT LENGTH: ${response.contentLength}");
    print("BODY BYTES LENGHT: ${response.bodyBytes.length}");


    final contentLength = response.contentLength;
    final downloadedLength = response.bodyBytes.length;

    _progress = downloadedLength / contentLength * 100;

    notifyListeners();

    print("PROGRESS: $_progress");


    var path;
    if (Platform.isIOS) {
      Navigator.of(context).pop();
      Directory docDirectory = await getApplicationDocumentsDirectory();
      final dir = Directory(docDirectory.path + "/report");
      await dir.create().then((value) {
        File file = new File('${value.path}/REPORT-$filename.pdf');
        file.writeAsBytes(response.bodyBytes);
        print("FINISH DOWNLOAD");
        //myDialog(context);
        showToast(context, filename);
        return file;
      });
    } else {
      path = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
      File file = new File('$path/REPORT-$filename.pdf');
      await file.writeAsBytes(response.bodyBytes);
      print("FINISH DOWNLOAD");
      //myDialog(context);
      showToast(context, filename);
      return file;
    }

    return null ;

  }

  showToast(BuildContext context, String filename){
      bool isCircle = true;
      AchievementView(
        context,
        title: "Download Selesai",
        alignment: Alignment.topCenter,
        color: MyColors.dnaGreen,
        subTitle: "$filename berhasil didownload",
        isCircle: isCircle,
        listener: (status) {
          print(status);
          if(status == AchievementState.closed){
            Navigator.of(context).pop();
          }
        },
      )..show();

  }


  Future<Flushbar> myDialog(BuildContext ctx){
    Flushbar(
      margin: EdgeInsets.all(8),
      duration: Duration(seconds: 4),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [MyColors.dnaGreen, Colors.lightBlueAccent],
        stops: [0.3, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      flushbarPosition: FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Sukses...',
      message: 'File berhasil di download',
    )
      ..onStatusChanged = (FlushbarStatus status) {
        switch (status) {
          case FlushbarStatus.SHOWING:
            {
              break;
            }
          case FlushbarStatus.IS_APPEARING:
            {
              print("FLUSHBAR IS APPEARING");

              break;
            }
          case FlushbarStatus.IS_HIDING:
            {
              print("FLUSHBAR IS HIDING");

              break;
            }
          case FlushbarStatus.DISMISSED:
            {
              print("FLUSHBAR IS DISMISSED");
              break;
            }
        }
      }
      ..show(ctx);

    return null ;
  }

  void showProgressDownload(BuildContext ctx){
    showDialog(
        context: ctx,
        //barrierDismissible: false,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: (Platform.isIOS ? CupertinoActivityIndicator(radius: 12) : CircularProgressIndicator(strokeWidth: 2)),
                  ),
                ),
              ],
            ),
          );
        });
  }



  void showModalDownload(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                ),

                downloadState == true ?
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: (CupertinoActivityIndicator()),
                    ),
                  ),
                ):

                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: listDetail.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return BottomSheetItemWidget(
                                    model: listDetail[index]);
                              }),

                        ],
                      )
                  ),
                ),
              ],
            ),
          );
        });
  }
}