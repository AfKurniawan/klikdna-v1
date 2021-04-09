import 'dart:convert';
import 'dart:io';

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:ext_storage/ext_storage.dart';
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
  List<ReportData> reportMapArray = [];
  List<Detail> listDetail1 = [];
  List<Detail> listDetail2 = [];
  List<Detail> listDetail3 = [];
  bool isLoading;
  bool notfound = false;


  // FIXING
  var dataArray = [];

  var kitArray = [];

  int listLength = 0 ;


  Future<List<ReportModel>> getSamplexx(BuildContext context, String personId) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefPersonId = prefs.getString("personId");
    String paramPersonId = "" ;
    if(personId == "" || personId == null) {
      paramPersonId = prefPersonId;
      notifyListeners();
    } else {
      paramPersonId = personId;
      notifyListeners();
    }
    var url = AppConstants.GET_SAMPLE_URL + '$paramPersonId';

    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final response = await http.get(url, headers: ndas);

    ///  NOTE
    /// "verifykdm_access_report": 1, jika nila 1 bisa liat report, klo nilai != 1 keluar text harap menghubungi (Seperti android)

    if (response.statusCode == 200) {
      isLoading = false;
      notfound = false ;
     // print("REPORT RESPONSE BODY ===> ${response.body}");

      var responseJson = json.decode(response.body);

      dataArray = responseJson['data'] as List;
      print("DATA ARRAY --> ${dataArray.length}");


      if(dataArray.length > 1){
        for(int i = 1 ; i < dataArray.length; i++) {
          var detail1Array = dataArray[0]['detail'] as List;
          var detail2Array = dataArray[i]['detail'] as List;
          print("DETAIL ARRAY $i --> $detail2Array");
          var combined = detail1Array..addAll(detail2Array);
          listDetail2 = combined.map<Detail>((j) => Detail.fromJson(j)).toList();
          notifyListeners();
        }
      } else {
        for(int i = 0 ; i < dataArray.length; i++) {
          //var detail1Array = dataArray[0]['detail'] as List;
          var detail2Array = dataArray[i]['detail'] as List;
          print("DETAIL ARRAY $i --> $detail2Array");
          //var combined = detail1Array..addAll(detail2Array);
          listDetail2 = detail2Array.map<Detail>((j) => Detail.fromJson(j)).toList();
          notifyListeners();
        }
      }



      // if (dataArray.length <= 3 ) {
      //   listDetail2 = detail1Array.map<Detail>((j) => Detail.fromJson(j)).toList();
      //   notifyListeners();
      // } else {
      //
      //   for(int i = 0 ; i < dataArray.length; i++) {
      //     var detail2Array = dataArray[i]['detail'] as List;
      //     print("DETAIL ARRAY 2 --> $detail2Array");
      //     var combined = detail1Array + detail2Array;
      //     listDetail2 = combined.map<Detail>((j) => Detail.fromJson(j)).toList();
      //     notifyListeners();
      //   }
      //
      //
      // }












      // for(int i = 0 ; i < dataArray.length; i++){
      //
      //   detail1Array.addAll(detail2Array);
      //
      //   print("DETAIL ARRAY 1 --> ${detail1Array}");
      //
      //   print("DETAIL ARRAY 2 --> ${detail2Array}");
      // }




      notifyListeners();
    } else if (response.statusCode == 404) {
      listDetail1 = [];
      listDetail2 = [];
      isLoading = false;
      notfound = true ;
      notifyListeners();
      listDetail1.clear();
      listDetail2.clear();
    } else if (response.statusCode == 500) {
      listDetail1 = [];
      listDetail2 = [];
      isLoading = false;
      notfound = true ;
      notifyListeners();
      listDetail1.clear();
      listDetail2.clear();
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
    String accessToken = prov.accessToken;
    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var body = {
      "person_id": "$person",
      "report_id": "$reportId"
    };

    final request = await http.post(url, headers: ndas, body: body);

    if(request.statusCode == 200) {
      final reportResponse = DetailReportModel.fromJson(json.decode(request.body));
      linkPdf = reportResponse.data.linkPdf;
      filename = reportResponse.data.reportId + reportResponse.data.reportId;
      notifyListeners();

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
    notifyListeners();

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    Map<String, String> ndas = {
      "Accept": "application/json",
      "app_key": "kdm2020!",
      "shared_key": "8d8105c406649d5c438b1e1eb41118c57282e0fab3f43c5b21712fb7a3955ad3"
    };

    final response = await http.get(linkPdf, headers: ndas);


    final contentLength = response.contentLength;
    final downloadedLength = response.bodyBytes.length;

    _progress = downloadedLength / contentLength * 100;

    notifyListeners();


    var path;
    if (Platform.isIOS) {
      Navigator.of(context).pop();
      Directory docDirectory = await getApplicationDocumentsDirectory();
      final dir = Directory(docDirectory.path + "/report");
      await dir.create().then((value) {
        File file = new File('${value.path}/REPORT-$filename.pdf');
        file.writeAsBytes(response.bodyBytes);
        showToast(context, filename);
        return file;
      });
    } else {
      path = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
      File file = new File('$path/REPORT-$filename.pdf');
      await file.writeAsBytes(response.bodyBytes);
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
          if(status == AchievementState.closed){
            Navigator.of(context).pop();
          }
        },
      )..show();

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
                              itemCount: listDetail2.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return BottomSheetItemWidget(
                                    model: listDetail2[index]);
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