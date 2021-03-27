import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'dart:async';


class DetailReportProvider extends ChangeNotifier {
  bool isLoading;

  List<ReportDetail> reportDetail = [];
  List<ReportDetail> searchResult = [];
  List<Rekomendasi> listRecomendasi = [];

  List<Rekomendasi> searchRecomendasi = [];

  List<PenjelasanIlmiah> penjelasanIlmiah = [];
 // List<PenjelasanDetail> penjelasanDetail = [];

  String link ;

  var reportdetailArray = [];
  var rekomendasiArray = [] ;
  var penjelasanIlmiahArray = [];
  var penjelasanDetailArray = [];
  String tahu ;
  String name = "";

  Future<List<Rekomendasi>> getDetailReport(BuildContext context, String reportId) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String person = prefs.getString("personId");
    var url = AppConstants.GET_REPORT_DETAIL_URL;
    final prov = Provider.of<TokenProvider>(context, listen: false);
    prov.getApiToken();

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

    if (request.statusCode == 200) {
      isLoading = false;
      final reportResponse = DetailReportModel.fromJson(json.decode(request.body));

      var responseJson = json.decode(request.body);

      var dataArray = responseJson['data'];
      reportdetailArray = dataArray['report_detail'] as List;
      if(reportdetailArray.length == 0){
        reportDetail =  [] ;
        listRecomendasi = [];
        penjelasanIlmiah = [] ;


      } else {




        reportDetail = reportdetailArray.map((p) => ReportDetail.fromJson(p)).toList();



       // penjelasanIlmiahArray = reportdetailArray[1]['penjelasan_ilmiah'] as List;

        // penjelasanDetailArray = penjelasanIlmiahArray[1]['penjelasan_detail'];
        //
        // penjelasanIlmiah = penjelasanIlmiahArray.map((p) => PenjelasanIlmiah.fromJson(p)).toList();


        rekomendasiArray = reportdetailArray[0]['rekomendasi'] as List;
        listRecomendasi = rekomendasiArray.map((p) => Rekomendasi.fromJson(p)).toList();

        for (int i = 0; i < rekomendasiArray.length; i++) {

          getImageSize(listRecomendasi[0].gambarRekomendasi);

          notifyListeners();

        }

        notifyListeners();
      }


      link = reportResponse.data.linkPdf;
      notifyListeners();

    } else if (request.statusCode == 404) {
      isLoading = false;
      notifyListeners();
    } else if (request.statusCode == 500) {

    } else if (reportDetail == []) {

    }

    return listRecomendasi;
  }


  double imgWidth = 0.0 ;
  double imgHeight = 0.0 ;


  Future<ui.Image> getImageSize(String url) async {
    final Completer<ui.Image> completer = Completer<ui.Image>();
    Image image = url == null || url == "" ? Image.asset("assets/images/no_image.png") : Image.network(url);
    image.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool isSync) {
      completer.complete(info.image);
        imgWidth = info.image.width.toDouble();
        imgHeight = info.image.height.toDouble();

    }));

    return completer.future;
  }


  void resizeImage(){

  }


  List<Rekomendasi> lr ;
  bool kosong ;
  getRecomendasi(String text) async {
    if (text.isEmpty) {
      notifyListeners();
      return;
    }
    reportDetail.forEach((item) {
      if (item.namaModul.contains(text)) {
        rekomendasiArray.add(item);
        if(item.rekomendasi == null){
          kosong = true;

        } else {
          kosong = false;
          lr = item.rekomendasi;
          getImageSize(lr[0].gambarRekomendasi);
          }

        }



    });

  }

  onCheckedValuexxx(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    reportDetail.forEach((item) {
      if (item.hasilKamu.contains(text)) searchResult.add(item);

    });

  }


}