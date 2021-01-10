import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/home/models/home_model.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeProvider extends ChangeNotifier {



  List<ArrayData> mapArray = [];
  List<ArrayData> lr ;
  String imagePromo = "";
  List<Data> myData = [];
  //List<String> imageUrl = [];
  List<ArrayData> bannerArray ;
  var jsonArray = [];
  var promo ;
  var rekomendasiArray = [] ;
  int bannerLenght = 0;
  int pinId = 11 ;
  Future<List<HomeModel>> getHomeContents(BuildContext context) async {
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

      for (int i = 0; i < jsonArray.length; i++) {
        promo = Data.fromJson(jsonArray[i]['data']);
        if(promo.categoryId == 4){
          print("PROMOID ${promo.categoryId}");
          mapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          bannerArray = mapArray.where((i) => i.data.categoryId == 4).toList();
          bannerLenght = bannerArray.length ;
          print("IMAGE PROMO: ${mapArray[i].imageUrl}");
          print(" Banner ARRAY LEGHT: $bannerLenght");

        } else if(promo.categoryId == 11) {
          print("PROMOID PIN ${promo.categoryId}");
          mapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          bannerArray = mapArray.where((i) => i.data.categoryId == 11).toList();
          print("IMAGE PIN: ${mapArray[i].imageUrl}");
          bannerLenght = bannerArray.length;
        }


      }
      notifyListeners();

    }
  }







}