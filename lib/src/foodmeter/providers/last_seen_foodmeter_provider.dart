import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/foodmeter/models/food_meter_last_seen_model.dart';
import 'package:new_klikdna/src/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LastSeenFoodMeterProvider with ChangeNotifier {
  bool isLoading ;
  List<DataArray> dataArray ;
  var myArray = [];
  List<DataArray> lastSeenFood = [];

  String food1 = "" ;
  String food2 = "" ;
  String food3 = "" ;
  String food4 = "" ;
  String food5 = "" ;

  Future<FoodMeterLastSeenModel> getLastSeenFood(BuildContext context) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);
    var id = Provider.of<MitraProvider>(context, listen: false).vuserid;
    print("user id to get last seen food is --> $id");

    String accessToken = prov.accessToken;

    isLoading = true ;
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
      print("DATA ARRAY --> ${myArray.length}");
      dataArray = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      isLoading = false;
      lastSeenFood = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      lastSeenFood.sort((b, a) => b.product.createdAt.compareTo(a.product.createdAt));

      print("lenght => ${lastSeenFood.length}");

      if(lastSeenFood[0].product != null) {

        Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[0].product.id);
        Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[1].product.id);
        Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[2].product.id);
        Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[3].product.id);
        Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[4].product.id);

        // for(int i = 0 ; i < lastSeenFood.length; i++){
        //   print("ID FOOD ==> ${lastSeenFood[i].product.id}");
        //   Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[i].product.id);
        // }




      }

    } else {
      print("Error receiving data");
    }

    notifyListeners();

    return null ;

  }


  Future<FoodMeterLastSeenModel> getNutrition(BuildContext context) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);
    var id = Provider.of<MitraProvider>(context, listen: false).vuserid;
    print("user id to get last seen food is --> $id");

    String accessToken = prov.accessToken;
    isLoading = true ;

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
      print("DATA ARRAY --> ${myArray.length}");
      dataArray = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      isLoading = false;

      lastSeenFood = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      lastSeenFood.sort((b, a) => b.product.createdAt.compareTo(a.product.createdAt));

      if(lastSeenFood[0].product != null) {

        food1 = "${lastSeenFood[0].product.id}";
        food2 = "${lastSeenFood[1].product.id}";
        food3 = "${lastSeenFood[2].product.id}";
        food4 = "${lastSeenFood[3].product.id}";
        food5 = "${lastSeenFood[4].product.id}";
        notifyListeners();

      }

    } else {
      print("Error receiving data");
    }

    notifyListeners();

    return null ;

  }



}