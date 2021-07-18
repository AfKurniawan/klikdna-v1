import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/detail_food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/pagination_model_data.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/last_seen_foodmeter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/dialog_unavailable_feature.dart';
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


  List<MobileNutritions> newMobilenutritionList = [];
  List<MobileNutritions> newMobilenutritionListx = [];
  List<MobileNutritions> newMobilenutritionListz = [];

  List<MobileNutritions> newMobilenutritionList0 = [];
  List<MobileNutritions> newMobilenutritionList1 = [];
  List<MobileNutritions> newMobilenutritionList2 = [];
  List<MobileNutritions> newMobilenutritionList3 = [];
  List<MobileNutritions> newMobilenutritionList4 = [];

  List<MobileNutritions> newMobilenutritionMapList = [];
  List<MobileNutritions> newMobilenutritionMapListx = [];
  List<MobileNutritions> newMobilenutritionMapListz = [];


  List<MobileNutritions> newMobilenutritionMapList0 = [];
  List<MobileNutritions> newMobilenutritionMapList1 = [];
  List<MobileNutritions> newMobilenutritionMapList2 = [];
  List<MobileNutritions> newMobilenutritionMapList3 = [];
  List<MobileNutritions> newMobilenutritionMapList4 = [];


  List<MobileNutritions> proteinList = [];
  List<MobileNutritions> proteinList0 = [];
  List<MobileNutritions> proteinList1 = [];
  List<MobileNutritions> proteinList2 = [];
  List<MobileNutritions> proteinList3 = [];
  List<MobileNutritions> proteinList4 = [];

  List<MobileNutritions> kaloriList = [];
  List<MobileNutritions> kaloriList0 = [];
  List<MobileNutritions> kaloriList1 = [];
  List<MobileNutritions> kaloriList2 = [];
  List<MobileNutritions> kaloriList3 = [];
  List<MobileNutritions> kaloriList4 = [];


  String kal = "Kalori" ;
  String kal0 = "Kalori" ;
  String kal1 = "Kalori" ;
  String kal2 = "Kalori" ;
  String kal3 = "Kalori" ;
  String kal4 = "Kalori" ;

  String kalSize = "" ;
  String kalSize0 = "" ;
  String kalSize1 = "" ;
  String kalSize2 = "" ;
  String kalSize3 = "" ;
  String kalSize4 = "" ;

  String prot = "Protein" ;
  String prot0 = "Protein" ;
  String prot1 = "Protein" ;
  String prot2 = "Protein" ;
  String prot3 = "Protein" ;
  String prot4 = "Protein" ;

  String protSize = "";
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





  Future<List> getDetailFoodMeter(BuildContext context, int id) async {
    isLoadingDetail = true;

    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    var url = AppConstants.GET_DETAIL_FOOD_METER_URL + "$id" ;

    var r =  await http.get(url, headers: ndas);


    var response = json.decode(r.body);




    if(r.statusCode == 200){

      isLoadingDetail = false;
      var nutritionArray = response['data']['mobile_nutritions'] as List;

        newMobilenutritionMapList = nutritionArray.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();

        newMobilenutritionList = newMobilenutritionMapList.where((i) => ("${i.productId}" == "$id")).toList();

        newMobilenutritionListx = newMobilenutritionMapList.where((i) => ("${i.productId}" == "$id")).toList();



        newMobilenutritionList.forEach((item) {
          if (item.nutritionName.contains("Kalori")) {
            kaloriList.add(item);
          }
        });

        newMobilenutritionList.forEach((item) {
          if (item.nutritionName.contains("Protein")) {
            proteinList.add(item);
          }
        });




    } else {

      isLoadingDetail = false;
      print("Something wrong");

    }
     notifyListeners();
  }

  List<FoodMeterModel> fm = [];

  String namaProduk = "" ;
  String sizeProduk = "" ;
  String prodUom = "" ;

  Future<List> getSpecificFoodMeter(BuildContext context, int id) async {

    isLoadingDetail = true;
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var url = AppConstants.GET_DETAIL_FOOD_METER_URL + "$id" ;

    var r =  await http.get(url, headers: ndas);

    var response = json.decode(r.body);

    print("[FOOD METER PROVIDER] Response Staus Code ${r.statusCode}");

    if(r.statusCode == 200){

      isLoadingDetail = false ;

      var nutritionArray = response['data']['mobile_nutritions'] as List;
      var foodData = response['data'];

      final foodResponse = DetailFood.fromJson(foodData);

      namaProduk = foodResponse.productName;
      sizeProduk = foodResponse.productSize;
      prodUom = foodResponse.productUom ;

      newMobilenutritionMapListx = nutritionArray.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionListx = newMobilenutritionMapListx.where((i) => ("${i.productId}" == "$id")).toList();

      newMobilenutritionMapListz = nutritionArray.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      newMobilenutritionListz = newMobilenutritionMapListz.where((i) => ("${i.productId}" == "$id")).toList();


      //Navigator.of(context).pushNamed("new_detail_food_meter_page");

      isLoadingDetail = false;

      newMobilenutritionMapList = nutritionArray.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();

      newMobilenutritionList = newMobilenutritionMapList.where((i) => ("${i.productId}" == "$id")).toList();


      newMobilenutritionList.forEach((item) {
        if (item.nutritionName.contains("Kalori")) {
          kaloriList.add(item);
        }
      });

      newMobilenutritionList.forEach((item) {
        if (item.nutritionName.contains("Protein")) {
          proteinList.add(item);
        }
      });




    } else {

      isLoadingDetail = false ;
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

  void unavailableFeature (BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: true,
        builder: (context) {
          return BottomSheetUnavailableFeature();
        });
  }




}