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
  List<DataArray> dataArray ;
  var myArray = [];
  List<DataArray> lastSeenFood = [];

  Future<FoodMeterLastSeenModel> getLastSeenFood(BuildContext context) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);
    var id = Provider.of<MitraProvider>(context, listen: false).vuserid;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final detail = Provider.of<FoodMeterProvider>(context, listen: false);

    String accessToken = prov.accessToken;

    isLoadingLastSeen = true ;
    var url = AppConstants.LAST_SEEN_FOOD_URL + "$id" ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.get(url, headers: ndas);
    final response = FoodMeterLastSeenModel.fromJson(json.decode(request.body));

    if(response.success == true){

      var responseJson = json.decode(request.body);

      myArray = responseJson['data']['data'] as List;

      dataArray = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      isLoadingLastSeen = false;

      print("Last Seen data ${request.body}");


      for(int i = 0 ; i < myArray.length; i++){

        if(responseJson['data']['data'][i]['product'] != null){

          lastSeenFood = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
          lastSeenFood.removeWhere((value) => value.product == null);

          Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[i].product.id);



        } else {

        }

      }



    } else {
      print("Error receiving data");
    }

    notifyListeners();

    return null ;

  }


}