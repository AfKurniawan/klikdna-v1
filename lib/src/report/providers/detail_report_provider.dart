import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailReportProvider extends ChangeNotifier {
  bool isLoading;

  List<ReportDetail> reportDetail = [];
  List<ReportDetail> searchResult = [];
  List<Rekomendasi> listRecomendasi = [];
  List<PenjelasanIlmiah> penjelasanIlmiah = [];
  List<PenjelasanDetail> penjelasanDetail = [];

  String link ;

  var reportdetailArray = [];
  var rekomendasiArray = [] ;
  var penjelasanIlmiahArray = [];
  var penjelasanDetailArray = [];

  Future<List<ReportDetail>> getDetailReport(BuildContext context, String reportId) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String person = prefs.getString("personId");
    var url = AppConstants.GET_REPORT_DETAIL_URL;
    final prov = Provider.of<TokenProvider>(context, listen: false);
    // prov.getApiToken(context);
    print("PERSON ID: $person");

    String accessToken = prov.accessToken;
    print("AKSES TOKEN: $accessToken");
    print("REPORT ID====: $reportId");
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

        rekomendasiArray = reportdetailArray[0]['rekomendasi'] as List;
        penjelasanIlmiahArray = reportdetailArray[1]['penjelasan_ilmiah'] as List;
        penjelasanDetailArray = penjelasanIlmiahArray[1]['penjelasan_detail'];

        reportDetail = reportdetailArray.map((p) => ReportDetail.fromJson(p)).toList();
        listRecomendasi = rekomendasiArray.map((p) => Rekomendasi.fromJson(p)).toList();
        penjelasanIlmiah = penjelasanIlmiahArray.map((p) => PenjelasanIlmiah.fromJson(p)).toList();
        //penjelasanDetail = penjelasanDetailArray.map((p) => PenjelasanDetail.fromJson(p)).toList();
      }



      print("PANJANG REPORT DETAIL ------------- ${reportDetail.length}");

      link = reportResponse.data.linkPdf;
      print("LINK PDF: $link");
      notifyListeners();

    } else if (request.statusCode == 404) {
      print("REPORT Not Found");
      isLoading = false;
      notifyListeners();
    } else if (request.statusCode == 500) {
      print("REPORT ERROR 500");
    } else if (reportDetail == []) {

    }

    return reportDetail;
  }

  onCheckedValue(String text) async {
    searchResult.clear();

    print("CHECKED VALUE: $text");
    if (text.isEmpty) {
      return;
    }

    reportDetail.forEach((item) {
      if (item.hasilKamu.contains(text)) searchResult.add(item);

    });

  }


}