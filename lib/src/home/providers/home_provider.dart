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

  List<ArrayData> eventMapArray = [];
  List<ArrayData> eventArray ;


  var jsonArray = [];
  var promo ;

  Future<List<HomeModel>> getHomeContents(BuildContext context) async {
    Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken();
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
          bannerMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          bannerArray = bannerMapArray.where((i) => i.data.categoryId == 4).toList();

          print("IMAGE PROMO: ${bannerMapArray[i].imageUrl}");
          print("Banner ARRAY LEGHT: ${bannerArray.length}");

        } else if(promo.categoryId == 11) {

          print("PROMOID PIN ${promo.categoryId}");
          pinMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          pinArray = pinMapArray.where((i) => i.data.categoryId == 11).toList();
          print("IMAGE PIN: ${pinMapArray[i].imageUrl}");
          print("PIN ARRAY LEGHT: ${pinArray.length}");

        } else if(promo.categoryId == 10){

          print("PROMOID EVENT ${promo.categoryId}");
          eventMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
          eventArray = eventMapArray.where((i) => i.data.categoryId == 10).toList();
          print("IMAGE EVENT: ${eventMapArray[i].imageUrl}");
          print("EVENT ARRAY LENGHT: ${eventArray.length}");

        }


      }
      notifyListeners();

    }
  }







}