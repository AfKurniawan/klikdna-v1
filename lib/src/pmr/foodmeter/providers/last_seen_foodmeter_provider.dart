import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/detail_food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/food_meter_last_seen_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/favourite_food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LastSeenFoodMeterProvider with ChangeNotifier {
  bool isLoadingLastSeen ;
  List<DataArray> dataArray = [] ;
  List<DataArray> lastSeenFood = [];

  Future<FoodMeterLastSeenModel> getLastSeenFood(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);

    String accessToken = prov.accessToken;
    isLoadingLastSeen = true ;

    var url = AppConstants.LAST_SEEN_FOOD_URL + "${prefs.getInt('userid')}" ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final response = await http.get(url, headers: ndas);
    final responseJson = FoodMeterLastSeenModel.fromJson(json.decode(response.body));

    print("[LAST SEEN PROVIDER] getLastSeenFood Response Body ==> ${response.body}");
    print("[LAST SEEN PROVIDER] getLastSeenFood Response Status Code ==> ${response.statusCode}");

    if(response.statusCode == 200){

      var responseJson = json.decode(response.body);
      var myArray = responseJson['data']['data'] as List;
      dataArray = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      isLoadingLastSeen = false;

      lastSeenFood = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      lastSeenFood.removeWhere((value) => value.product == null);

      print("[LAST SEEN PROVIDER] getLastSeenFood productlist length ==> ${lastSeenFood.length}");


      for(int i = 0 ; i < lastSeenFood.length; i++){

        var productArray =  responseJson['data']['data'][i]['product'] ;

        if(lastSeenFood.length == 0){

           print('[LAST SEEN PROVIDER] getLastSeenFood productArray $productArray');

        } else {

          Provider.of<FoodMeterProvider>(context, listen: false).getSpecificFoodMeter(context, lastSeenFood[i].product.id);

        }
      }



    } else {

      print("Error receiving data");
    }

    notifyListeners();

    return null ;

  }


  void clearLastSeen(){
    lastSeenFood.clear();
    notifyListeners();
  }


}