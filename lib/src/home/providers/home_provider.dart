import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/home/models/home_model.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeProvider extends ChangeNotifier {


  List<ArrayData> bannerMapArray = [];
  List<ArrayData> bannerArray ;

  List<ArrayData> pinMapArray = [];
  List<ArrayData> pinArray ;

  List<ArrayData> allEventMapArray = [];
  List<ArrayData> allEventArray = [] ;

  List<ArrayData> trainingEventMapArray = [];
  List<ArrayData> trainingEventArray = [] ;

  List<ArrayData> healthEventMapArray = [];
  List<ArrayData> healthEventArray = [] ;




  var jsonArray = [];
  var promo ;
  bool isLoading ;

  Future<List<HomeModel>> getHomeContents(BuildContext context) async {
    isLoading = true ;
    var url = AppConstants.GET_HOME_ARTIKEL;
    final prov = Provider.of<CmsTokenProvider>(context, listen: false);
    String accessToken = prov.cmsAccessToken;
    print("CMS TOKEN IN HOME+++++ :$accessToken");
    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    final response = await http.get(url, headers: ndas);
    if(response.statusCode == 200){
      var responseJson = json.decode(response.body);
      jsonArray = responseJson['data'] as List;
      isLoading = false ;

      print("RESPONE STATUS CODE ====== ${response.statusCode}");



      for (int i = 0; i < jsonArray.length; i++) {
        promo = Data.fromJson(jsonArray[i]['data']);
        if(promo.categoryId == 4){

          //print("PROMOID ${promo.categoryId}");
          bannerMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          bannerArray = bannerMapArray.where((i) => i.data.categoryId == 4).toList();

          // print("IMAGE PROMO: ${bannerMapArray[i].imageUrl}");
          // print("Banner ARRAY LEGHT: ${bannerArray.length}");
          // print("DO DATE ${bannerMapArray[i].data.doDate}");

        } else if(promo.categoryId == 11) {

          //print("PROMOID PIN ${promo.categoryId}");
          pinMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          pinArray = pinMapArray.where((i) => i.data.categoryId == 11).toList();

          //print("IMAGE PIN: ${pinMapArray[i].imageUrl}");
          // print("PIN ARRAY LEGHT: ${pinArray.length}");
          // print("DO DATE ${pinMapArray[i].data.doDate}");

        } else if(promo.categoryId == 10  || promo.categoryId == 13){

          var now = new DateTime.now();
          var sekarang = now.subtract(Duration(days: 0));
          allEventMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          allEventArray = allEventMapArray.where((i) => i.data.categoryId == 13 || i.data.categoryId == 10).toList();
          allEventArray.removeWhere((el) => DateTime.parse(el.data.doDate).isBefore(sekarang));
          allEventArray.sort((a, b) => a.data.createdAt.compareTo(b.data.createdAt));

          trainingEventMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          trainingEventArray = trainingEventMapArray.where((i) => i.data.categoryId == 10).toList();
          trainingEventArray.removeWhere((el) => DateTime.parse(el.data.doDate).isBefore(sekarang));
          trainingEventArray.sort((a, b) => a.data.createdAt.compareTo(b.data.createdAt));

          healthEventMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          healthEventArray = healthEventMapArray.where((i) => i.data.categoryId == 13).toList();
          healthEventArray.removeWhere((el) => DateTime.parse(el.data.doDate).isBefore(sekarang));
          healthEventArray.sort((a, b) => a.data.createdAt.compareTo(b.data.createdAt));

        }


      }
      notifyListeners();

    }
  }







}