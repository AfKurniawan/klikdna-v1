import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/detail_food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/favourite_food_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/list_food_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/resto_model_data.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteFoodMeterProvider extends ChangeNotifier {

  List<DrinkFood> listFood = [];

  List<Food> searchListResult = [];

  bool isLoadingFood;
  bool dashboardVisible = true ;

  bool isLoadingDetail ;


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

  List<MobileNutritions> lemakList0 = [];
  List<MobileNutritions> lemakList1 = [];
  List<MobileNutritions> lemakList2 = [];
  List<MobileNutritions> lemakList3 = [];
  List<MobileNutritions> lemakList4 = [];

  List<MobileNutritions> karboList0 = [];
  List<MobileNutritions> karboList1 = [];
  List<MobileNutritions> karboList2 = [];
  List<MobileNutritions> karboList3 = [];
  List<MobileNutritions> karboList4 = [];

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


  String karbo0 = "Karbo" ;
  String karbo1 = "Karbo" ;
  String karbo2 = "Karbo" ;
  String karbo3 = "Karbo" ;
  String karbo4 = "Karbo" ;

  String karboSize0 = "" ;
  String karboSize1 = "" ;
  String karboSize2 = "" ;
  String karboSize3 = "" ;
  String karboSize4 = "" ;

  String lemak0 = "Lemak" ;
  String lemak1 = "Lemak" ;
  String lemak2 = "Lemak" ;
  String lemak3 = "Lemak" ;
  String lemak4 = "Lemak" ;

  String lemakSize0 = "" ;
  String lemakSize1 = "" ;
  String lemakSize2 = "" ;
  String lemakSize3 = "" ;
  String lemakSize4 = "" ;

  String kategori0 = "";
  String kategori1 = "";
  String kategori2 = "";
  String kategori3 = "";
  String kategori4 = "";

  List items;
  List<Data3> dataMakanan;
  String lastItemId = '0';

  List<Data3> listMakanan = [];
  List<Data3> newItems = [];
  List dataPageList ;
  String nextPage = "" ;



  Future<ListFoodModel> getListFood(BuildContext context, String url) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);

    String accessToken = prov.accessToken;
    isLoadingFood = true ;


    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    final request = await http.get(url, headers: ndas);

    if(request.statusCode == 200){
      var data = json.decode(request.body);
      var detailArray = data['data']['data']['data'] as List;

      listMakanan = detailArray.map<Data3>((j) => Data3.fromJson(j)).toList();



      print("ini data New Item $newItems");
      isLoadingFood = false;

      notifyListeners();


    } else {

    }

    notifyListeners();

    return null ;

  }

  List<Data3> listMinuman = [];
  Future<ListFoodModel> getListMinuman(BuildContext context, String filter) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);

    String accessToken = prov.accessToken;

    isLoadingFood = true ;
    var url = AppConstants.LIST_FOOD_URL + '$filter' ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    final request = await http.get(url, headers: ndas);

    if(request.statusCode == 200){
      var data = json.decode(request.body);
      var detailArray = data['data']['data']['data'] as List;
      listMinuman = detailArray.map<Data3>((j) => Data3.fromJson(j)).toList();
      isLoadingFood = false;

      notifyListeners();


    } else {

    }

    notifyListeners();

    return null ;

  }

  List<Datum> listRestaurant = [];
  Future<ModelDataResto> getListRestaurant(BuildContext context, String filter) async {

    print("LIST FORESTOD");
    final prov = Provider.of<TokenProvider>(context, listen: false);

    String accessToken = prov.accessToken;

    isLoadingFood = true ;
    var url = AppConstants.LIST_FOOD_URL + '$filter' ;

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    final request = await http.get(url, headers: ndas);

    if(request.statusCode == 200){
      var data = json.decode(request.body);
      var detailArray = data['data']['data']['data'] as List;
      listRestaurant = detailArray.map<Datum>((j) => Datum.fromJson(j)).toList();
      isLoadingFood = false;

      notifyListeners();


    } else {

    }

    notifyListeners();

    return null ;

  }




  Future<FavouriteFoodModel> getFavouriteData(BuildContext context) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);

    String accessToken = prov.accessToken;

    isLoadingFood = true ;
    var url = AppConstants.IS_FAVOURITE_FOOD_URL ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    final request = await http.get(url, headers: ndas);
    final response = FavouriteFoodModel.fromJson(json.decode(request.body));

    if(request.statusCode == 200){

      var data = json.decode(request.body);
      var detailArray = data['drink_food']['data'] as List;
      listFood = detailArray.map<DrinkFood>((j) => DrinkFood.fromJson(j)).toList();
      isLoadingFood = false;


      id0 = json.decode(request.body)['drink_food']['data'][0]['id'];
      // print("ID 0 => $id0");
      id1 = json.decode(request.body)['drink_food']['data'][1]['id'];
      // print("ID 1 => $id1");
      id2 = json.decode(request.body)['drink_food']['data'][2]['id'];
      // print("ID 2 => $id2");
      id3 = json.decode(request.body)['drink_food']['data'][3]['id'];
     //  print("ID 3 => $id3");
      id4 = json.decode(request.body)['drink_food']['data'][4]['id'];
      // print("ID 4 => $id4");

      // Prod
      food0 = json.decode(request.body)['drink_food']['data'][0]['product_name'];
     // print("Food 0 => $food0");
      food1 = json.decode(request.body)['drink_food']['data'][1]['product_name'];
     // print("Food 1 => $food1");
      food2 = json.decode(request.body)['drink_food']['data'][2]['product_name'];
     // print("Food 2 => $food2");
      food3 = json.decode(request.body)['drink_food']['data'][3]['product_name'];
     // print("Food 3 => $food3");
      food4 = json.decode(request.body)['drink_food']['data'][4]['product_name'];
     // print("Food 4 => $food4");


      getDetailFavouriteFood(context);

      notifyListeners();


    } else {

    }

    notifyListeners();

    return null ;

  }


  Future<List> getDetailFavouriteFood(BuildContext context) async {
    isLoadingDetail = true;
    print("get fav running");
    var value = <Map<String, dynamic>>[];
    final prov = Provider.of<TokenProvider>(context, listen: false);
    final favourite = Provider.of<FavouriteFoodMeterProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var url0 = AppConstants.GET_DETAIL_FOOD_METER_URL + "$id0" ;
    var url1 = AppConstants.GET_DETAIL_FOOD_METER_URL + "$id1" ;
    var url2 = AppConstants.GET_DETAIL_FOOD_METER_URL + "$id2" ;
    var url3 = AppConstants.GET_DETAIL_FOOD_METER_URL + "$id3" ;
    var url4 = AppConstants.GET_DETAIL_FOOD_METER_URL + "$id4" ;


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

      kategori0 = response0['data']['category_id'];
      //print("Kategory $kategori0");
      kategori1 = response1['data']['category_id'];
      //print("Kategory $kategori1");
      kategori2 = response2['data']['category_id'];
      //print("Kategory $kategori2");
      kategori3 = response3['data']['category_id'];
      //print("Kategory $kategori3");
      kategori4 = response4['data']['category_id'];
      //print("Kategory $kategori4");



      // id 1
      var nutritionArray = response0['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList0 = nutritionArray.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList0 = newMobilenutritionMapList0.where((i) => ("${i.productId}" == "$id0")).toList();


      if(nutritionArray.length == 0){
        kalSize0 = '0';
        protSize0 = "0";
        karboSize0 =  "0" ;
        lemakSize0 = "0";
        
      } else {
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
            protSize0 = proteinList0.first.nutritionSize.substring(0, proteinList0.first.nutritionSize.indexOf('.'));
            prot0 = proteinList0.first.nutritionName;
          }
        });

        newMobilenutritionList0.forEach((item) {
          if (item.nutritionName.contains("Karbo")) {
            karboList0.add(item);
            karboSize0 = karboList0.first.nutritionSize.substring(0, karboList0.first.nutritionSize.indexOf('.'));
            karbo0 = proteinList0.first.nutritionName;
          }
        });

        newMobilenutritionList0.forEach((item) {
          if (item.nutritionName.contains("Lemak")) {
            lemakList0.add(item);
            lemakSize0 = lemakList0.first.nutritionSize.substring(0, lemakList0.first.nutritionSize.indexOf('.'));
            lemak0 = lemakList0.first.nutritionName;
          }
        });
      }




      // id 2
      var nutritionArray1 = response1['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList1 = nutritionArray1.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList1 = newMobilenutritionMapList1.where((i) => ("${i.productId}" == "$id1")).toList();

      if(nutritionArray1.length == 0){
        kalSize1 = '0';
        protSize1 = "0";
        karboSize1 =  "0";
        lemakSize1 = "0";
      } else {
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
            protSize1 = proteinList1.first.nutritionSize.substring(0, proteinList1.first.nutritionSize.indexOf('.'));
            prot1 = proteinList1.first.nutritionName;
          }
        });

        newMobilenutritionList1.forEach((item) {
          if (item.nutritionName.contains("Karbo")) {
            karboList1.add(item);
            karboSize1 = karboList1.first.nutritionSize.substring(0, karboList1.first.nutritionSize.indexOf('.'));
            karbo1 = proteinList1.first.nutritionName;
          }
        });

        newMobilenutritionList1.forEach((item) {
          if (item.nutritionName.contains("Lemak")) {
            lemakList1.add(item);
            lemakSize1 = lemakList1.first.nutritionSize.substring(0, lemakList1.first.nutritionSize.indexOf('.'));
            lemak1 = lemakList1.first.nutritionName;
          }
        });
      }



      // id 3
      var nutritionArray2 = response2['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList2 = nutritionArray2.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList2 = newMobilenutritionMapList2.where((i) => ("${i.productId}" == "$id2")).toList();

      if(nutritionArray2.length == 0){
        kalSize2 = '0';
        protSize2 = "0";
        karboSize2 =  "0";
        lemakSize2 = "0";
      } else {
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
            protSize2 = proteinList2.first.nutritionSize.substring(0, proteinList2.first.nutritionSize.indexOf('.'));
            prot2 = proteinList2.first.nutritionName;
          }
        });

        newMobilenutritionList2.forEach((item) {
          if (item.nutritionName.contains("Karbo")) {
            karboList2.add(item);
            karboSize2 = karboList2.first.nutritionSize.substring(0, karboList2.first.nutritionSize.indexOf('.'));
            karbo2 = proteinList2.first.nutritionName;
          }
        });

        newMobilenutritionList2.forEach((item) {
          if (item.nutritionName.contains("Lemak")) {
            lemakList2.add(item);
            lemakSize2 = lemakList2.first.nutritionSize.substring(0, lemakList2.first.nutritionSize.indexOf('.'));
            lemak2 = lemakList2.first.nutritionName;
          }
        });
      }


      //id 4
      var nutritionArray3 = response3['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList3 = nutritionArray3.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList3 = newMobilenutritionMapList3.where((i) => ("${i.productId}" == "$id3")).toList();
      if(nutritionArray3.length == 0){
        kalSize3 = '0';
        protSize3 = "0";
        karboSize3 =  "0";
        lemakSize3 = "0";
      } else {
        newMobilenutritionList3.forEach((item) {
          if (item.nutritionName.contains("Kalori")) {
            kaloriList3.add(item);
            kalSize3 = kaloriList3.first.nutritionSize.substring(0, kaloriList3.first.nutritionSize.indexOf('.'));
            kal3 = kaloriList3.first.nutritionName;
          }
        });

        newMobilenutritionList3.forEach((item) {
          if (item.nutritionName.contains("Protein")) {
            proteinList3.add(item);
            protSize3 = proteinList3.first.nutritionSize.substring(0, proteinList3.first.nutritionSize.indexOf('.'));
            prot3 = proteinList3.first.nutritionName;
          }
        });

        newMobilenutritionList3.forEach((item) {
          if (item.nutritionName.contains("Karbo")) {
            karboList3.add(item);
            karboSize3 = karboList3.first.nutritionSize.substring(0, karboList3.first.nutritionSize.indexOf('.'));
            karbo3 = proteinList3.first.nutritionName;
          }
        });

        newMobilenutritionList3.forEach((item) {
          if (item.nutritionName.contains("Lemak")) {
            lemakList3.add(item);
            lemakSize3 = lemakList3.first.nutritionSize.substring(0, lemakList3.first.nutritionSize.indexOf('.'));
            lemak3 = lemakList3.first.nutritionName;
          }
        });
      }



      //id 5
      var nutritionArray4 = response4['data']['mobile_nutritions'] as List;
      newMobilenutritionMapList4 = nutritionArray4.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionList4 = newMobilenutritionMapList4.where((i) => ("${i.productId}" == "$id4")).toList();

      if(nutritionArray4.length == 0){
        kalSize4 = '0';
        protSize4 = "0";
        karboSize4 =  "0";
        lemakSize4 = "0";
      } else {
        newMobilenutritionList4.forEach((item) {
          if (item.nutritionName.contains("Kalori")) {
            kaloriList4.add(item);
            kalSize4 = kaloriList4.first.nutritionSize.substring(0, kaloriList4.first.nutritionSize.indexOf('.'));
            kal4 = kaloriList4.first.nutritionName;
            print("ID 4 KALORI $kal4, $kalSize4");
          }
        });

        newMobilenutritionList4.forEach((item) {
          if (item.nutritionName.contains("Protein")) {
            proteinList4.add(item);
            protSize4 = proteinList4.first.nutritionSize.substring(0, proteinList4.first.nutritionSize.indexOf('.'));
            prot4 = proteinList4.first.nutritionName;
          }
        });

        newMobilenutritionList4.forEach((item) {
          if (item.nutritionName.contains("Karbo")) {
            karboList4.add(item);
            karboSize4 = karboList4.first.nutritionSize.substring(0, karboList4.first.nutritionSize.indexOf('.'));
            karbo4 = proteinList4.first.nutritionName;
          }
        });

        newMobilenutritionList4.forEach((item) {
          if (item.nutritionName.contains("Lemak")) {
            lemakList4.add(item);
            lemakSize4 = lemakList4.first.nutritionSize.substring(0, lemakList4.first.nutritionSize.indexOf('.'));
            lemak4 = lemakList4.first.nutritionName;
          }
        });
      }


      if(newMobilenutritionList4.length != null){
        isLoadingDetail = false ;
      }


    } else {

      print("Something wrong");

    }
     notifyListeners();
  }




}