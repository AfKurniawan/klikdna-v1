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
    print("user id to get last seen food is --> $id");
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

      myArray = responseJson['data']['data']as List;

      //print("jason Response => $myArray");

      var array2 = myArray[0]['data'];
      dataArray = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      isLoadingLastSeen = false;
      lastSeenFood = myArray.map<DataArray>((j) => DataArray.fromJson(j)).toList();
      //lastSeenFood.sort((b, a) => b.product.createdAt.compareTo(a.product.createdAt));

      print("lenght => ${lastSeenFood.length}");

       id0 = json.decode(request.body)['data']['data'][0]['product']['id'];
     // print("ID 0 => $id0");
       id1 = json.decode(request.body)['data']['data'][1]['product']['id'];
     // print("ID 1 => $id1");
       id2 = json.decode(request.body)['data']['data'][2]['product']['id'];
     // print("ID 2 => $id2");
       id3 = json.decode(request.body)['data']['data'][3]['product']['id'];
     // print("ID 3 => $id3");
       id4 = json.decode(request.body)['data']['data'][4]['product']['id'];
     // print("ID 4 => $id4");

      // Prod
      food0 = json.decode(request.body)['data']['data'][0]['product']['product_name'].toString();
      // print("ID 0 => $id0");
      food1 = json.decode(request.body)['data']['data'][1]['product']['product_name'].toString();
      // print("ID 1 => $id1");
      food2 = json.decode(request.body)['data']['data'][2]['product']['product_name'].toString();
      // print("ID 2 => $id2");
      food3 = json.decode(request.body)['data']['data'][3]['product']['product_name'].toString();
      // print("ID 3 => $id3");
      food4 = json.decode(request.body)['data']['data'][4]['product']['product_name'].toString();

      Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context);


      for(int i = 0 ; i < dataArray.length; i++){

        if(lastSeenFood[i].product != null) {
          //print("Last seen ${lastSeenFood[i].product.id}");
          //Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, lastSeenFood[i].product.id);
        }

      }



    } else {
      print("Error receiving data");
    }

    notifyListeners();

    return null ;

  }




}