import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/detail_food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/last_seen_foodmeter_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FoodMeterProvider extends ChangeNotifier {

  List<Food> listFood = [];
  List<Food> searchListResult = [];

  bool isLoading;
  bool dashboardVisible = true ;

  bool isLoadingDetail ;

  Future<FoodMeterModel> getFoodsData(BuildContext context, String query) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);

    String accessToken = prov.accessToken;

    isLoading = true ;
    notifyListeners();
    var url = AppConstants.GET_FOOD_METER_URL ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    var body = {
      "product_name": "$query"
    };

    final request = await http.post(url, headers: ndas, body: json.encode(body));
    final response = FoodMeterModel.fromJson(json.decode(request.body));

    if(response.success == true){
      dashboardVisible = false ;
      print("${request.body}");
      var data = json.decode(request.body);

      var detailArray = data['data'] as List;
      listFood = detailArray.map<Food>((j) => Food.fromJson(j)).toList();
      isLoading = false;
      notifyListeners();


    } else {

    }

    notifyListeners();

    return null ;

  }


  List<MobileNutritions> newMobilenutritionList0 = [];
  List<MobileNutritions> newMobilenutritionList1 = [];
  List<MobileNutritions> newMobilenutritionList2 = [];
  List<MobileNutritions> newMobilenutritionList3 = [];
  List<MobileNutritions> newMobilenutritionList4 = [];

  List<MobileNutritions> newMobilenutritionMapList0 = [];
  List<MobileNutritions> newMobilenutritionMapList1 = [];
  List<MobileNutritions> newMobilenutritionMapList2 = [];
  List<MobileNutritions> newMobilenutritionMapList3 = [];
  List<MobileNutritions> newMobilenutritionMapList4 = [];


  List<MobileNutritions> proteinList0 = [];
  List<MobileNutritions> proteinList1 = [];
  List<MobileNutritions> proteinList2 = [];
  List<MobileNutritions> proteinList3 = [];
  List<MobileNutritions> proteinList4 = [];

  List<MobileNutritions> kaloriList0 = [];
  List<MobileNutritions> kaloriList1 = [];
  List<MobileNutritions> kaloriList2 = [];
  List<MobileNutritions> kaloriList3 = [];
  List<MobileNutritions> kaloriList4 = [];


  String kal0 = "Kalori" ;
  String kal1 = "Kalori" ;
  String kal2 = "Kalori" ;
  String kal3 = "Kalori" ;
  String kal4 = "Kalori" ;

  String kalSize0 = "" ;
  String kalSize1 = "" ;
  String kalSize2 = "" ;
  String kalSize3 = "" ;
  String kalSize4 = "" ;

  String prot0 = "Protein" ;
  String prot1 = "Protein" ;
  String prot2 = "Protein" ;
  String prot3 = "Protein" ;
  String prot4 = "Protein" ;

  String protSize0 = "";
  String protSize1 = "";
  String protSize2 = "";
  String protSize3 = "";
  String protSize4 = "";

  String protUom0 = "";
  String protUom1 = "";
  String protUom2 = "";
  String protUom3 = "";
  String protUom4 = "";





  Future<List> getDetailFoodMeter(BuildContext context) async {
    isLoadingDetail = true;
    var value = <Map<String, dynamic>>[];
    final prov = Provider.of<TokenProvider>(context, listen: false);
    final lastFood = Provider.of<LastSeenFoodMeterProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var url0 = AppConstants.GET_DETAIL_FOOD_METER_URL + "${lastFood.id0}" ;
    var url1 = AppConstants.GET_DETAIL_FOOD_METER_URL + "${lastFood.id1}" ;
    var url2 = AppConstants.GET_DETAIL_FOOD_METER_URL + "${lastFood.id2}" ;
    var url3 = AppConstants.GET_DETAIL_FOOD_METER_URL + "${lastFood.id3}" ;
    var url4 = AppConstants.GET_DETAIL_FOOD_METER_URL + "${lastFood.id4}" ;


    var r0 =  await http.get(url0, headers: ndas);
    var r1 =  await http.get(url1, headers: ndas);
    var r2 =  await http.get(url2, headers: ndas);
    var r3 =  await http.get(url3, headers: ndas);
    var r4 =  await http.get(url4, headers: ndas);

    var response0 = json.decode(r0.body);
    var response1 = json.decode(r1.body);
    var response2 = json.decode(r2.body);
    var response3 = json.decode(r3.body);
    var response4 = json.decode(r4.body);

    if(r4.statusCode == 200){


      // id 1
      var nutritionArray = response0['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList0 = nutritionArray.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList0 = newMobilenutritionMapList0.where((i) => ("${i.productId}" == "${lastFood.id0}")).toList();

      newMobilenutritionList0.forEach((item) {
        if (item.nutritionName.contains("Kalori")) {
          kaloriList0.add(item);
          kalSize0 = kaloriList0.first.nutritionSize.substring(0, kaloriList0.first.nutritionSize.indexOf('.'));
          kal0 = kaloriList0.first.nutritionName;
        }
      });

      newMobilenutritionList0.forEach((item) {
        if (item.nutritionName.contains("Protein")) {
          proteinList0.add(item);
          protSize0 = proteinList0.first.nutritionSize.substring(0, 3);
          prot0 = proteinList0.first.nutritionName;
        }
      });



      // id 2
      var nutritionArray1 = response1['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList1 = nutritionArray1.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList1 = newMobilenutritionMapList1.where((i) => ("${i.productId}" == "${lastFood.id1}")).toList();

      newMobilenutritionList1.forEach((item) {
        if (item.nutritionName.contains("Kalori")) {
          kaloriList1.add(item);
          kalSize1 = kaloriList1.first.nutritionSize.substring(0, kaloriList1.first.nutritionSize.indexOf('.'));
          kal1 = kaloriList1.first.nutritionName;
        }
      });

      newMobilenutritionList1.forEach((item) {
        if (item.nutritionName.contains("Protein")) {
          proteinList1.add(item);
          protSize1 = proteinList1.first.nutritionSize.substring(0, 3);
          prot1 = proteinList1.first.nutritionName;
        }
      });


      // id 3
      var nutritionArray2 = response2['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList2 = nutritionArray2.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList2 = newMobilenutritionMapList2.where((i) => ("${i.productId}" == "${lastFood.id2}")).toList();
      newMobilenutritionList2.forEach((item) {
        if (item.nutritionName.contains("Kalori")) {
          kaloriList2.add(item);
          kalSize2 = kaloriList2.first.nutritionSize.substring(0, kaloriList2.first.nutritionSize.indexOf('.'));
          kal2 = kaloriList2.first.nutritionName;
        }
      });

      newMobilenutritionList2.forEach((item) {
        if (item.nutritionName.contains("Protein")) {
          proteinList2.add(item);
          protSize2 = proteinList2.first.nutritionSize.substring(0, 3);
          prot2 = proteinList2.first.nutritionName;
        }
      });

      //id 4
      var nutritionArray3 = response3['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList3 = nutritionArray3.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList3 = newMobilenutritionMapList3.where((i) => ("${i.productId}" == "${lastFood.id3}")).toList();
      newMobilenutritionList3.forEach((item) {
        if (item.nutritionName.contains("Kalori")) {
          kaloriList3.add(item);
          kalSize3 = kaloriList3.first.nutritionSize.substring(0, 3);
          kal3 = kaloriList3.first.nutritionName;
        }
      });

      newMobilenutritionList3.forEach((item) {
        if (item.nutritionName.contains("Protein")) {
          proteinList3.add(item);
          protSize3 = proteinList3.first.nutritionSize.substring(0, 3);
          prot3 = proteinList3.first.nutritionName;
        }
      });


      //id 5
      var nutritionArray4 = response4['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList4 = nutritionArray4.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList4 = newMobilenutritionMapList4.where((i) => ("${i.productId}" == "${lastFood.id4}")).toList();

      newMobilenutritionList4.forEach((item) {
        if (item.nutritionName.contains("Kalori")) {
          kaloriList4.add(item);
          kalSize4 = kaloriList4.first.nutritionSize.substring(0, kaloriList4.first.nutritionSize.indexOf('.'));
          kal4 = kaloriList4.first.nutritionName;
        }
      });

      newMobilenutritionList4.forEach((item) {
        if (item.nutritionName.contains("Protein")) {
          proteinList4.add(item);
          protSize4 = proteinList4.first.nutritionSize.substring(0, 3);
          prot4 = proteinList4.first.nutritionName;
        }
      });

      if(proteinList4.length != null){
        isLoadingDetail = false ;
      }


    } else {

      print("Something wrong");

    }
     notifyListeners();
  }



  onSearchTextChanged(String text) async {
    searchListResult.clear();
    if (text.isEmpty) {
      notifyListeners();
      return;
    }

    listFood.forEach((item) {
      if (item.productName.contains(text) || item.productName.contains(text)) searchListResult.add(item);
    });
    notifyListeners();
  }
}