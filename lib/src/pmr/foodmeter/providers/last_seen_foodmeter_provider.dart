import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/food_meter_last_seen_model.dart';
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

  String kal0 = "" ;
  String kal1 = "" ;
  String kal2 = "" ;
  String kal3 = "" ;
  String kal4 = "" ;

  int id0 = 0 ;
  int id1 = 0 ;
  int id2 = 0 ;
  int id3 = 0 ;
  int id4 = 0 ;
  int id5 = 0 ;

  String food0 = "" ;
  String food1 = "" ;
  String food2 = "" ;
  String food3 = "" ;
  String food4 = "" ;

  String kalori0 = "" ;
  String kalori1 = "" ;
  String kalori2 = "" ;
  String kalori3 = "" ;
  String kalori4 = "" ;



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



      var array2 = myArray[0]['data'];
      dataArray = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      isLoadingLastSeen = false;

      print("Last Seen Length ${lastSeenFood.length}");

      print("Response api body last --> ${request.body}");





      for(int i = 0 ; i < myArray.length; i++){

        if(responseJson['data']['data'][i]['product'] != null){

          lastSeenFood = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
          lastSeenFood.removeWhere((value) => value.product == null);

          Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[i].product.id);

          // id0 = lastSeenFood[0].product.id;
          // id1 = lastSeenFood[1].product.id;
          // id2 = lastSeenFood[2].product.id;
          // id3 = lastSeenFood[3].product.id;
          // id4 = lastSeenFood[4].product.id;

          // food0 = lastSeenFood[0].product.productName;
          // food0 = lastSeenFood[1].product.productName;
          // food0 = lastSeenFood[2].product.productName;
          // food0 = lastSeenFood[3].product.productName;
          // food0 = lastSeenFood[4].product.productName;


          print("id --> $id0, $id1, $id2, $id3, $id4, ${lastSeenFood[i].product.productName}");


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