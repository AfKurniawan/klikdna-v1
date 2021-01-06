import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/foodmeter/models/detail_food_meter_model.dart';
import 'package:new_klikdna/src/foodmeter/models/food_meter_model.dart';
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FoodMeterProvider extends ChangeNotifier {

  List<Food> listFood = [];
  List<Food> searchListResult = [];



  bool isLoading;
  Future<FoodMeterModel> getFoodsData(BuildContext context, String query) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);

    String accessToken = prov.accessToken;

    print("QUERY: $query");

    isLoading = true ;
    notifyListeners();
    var url = AppConstants.GET_FOOD_METER_URL ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    var body ={
      "product_name": "$query"
    };

    final request = await http.post(url, headers: ndas, body: json.encode(body));
    final response = FoodMeterModel.fromJson(json.decode(request.body));

    if(response.success == true){

      var data = json.decode(request.body);

      var detailArray = data['data'] as List;
      listFood = detailArray.map<Food>((j) => Food.fromJson(j)).toList();
      isLoading = false;
      notifyListeners();

      print("LIST FOOD LENGHT: ${listFood.length}");

    } else {
      print("ERERERERERE");
    }

    notifyListeners();

    return null ;

  }


  List<MobileNutritions> mobileNutritions = [];
  String productName;
  String productUom;
  String productSize;

  Future<FoodMeterModel> getDetailFoodMeter(BuildContext context, int foodId) async {

    final prov = Provider.of<TokenProvider>(context, listen: false);

    String accessToken = prov.accessToken;

    print("FOOD ID: $foodId");

    isLoading = true ;

    var url = AppConstants.GET_DETAIL_FOOD_METER_URL + "$foodId" ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.get(url, headers: ndas);
    final response = DetailFoodMeterModel.fromJson(json.decode(request.body));

    if(response.success == true){

      var data = json.decode(request.body);

      var detailArray = data['data']['mobile_nutritions'] as List;
      mobileNutritions = detailArray.map<MobileNutritions>((j) => MobileNutritions.fromJson(j)).toList();
      isLoading = false;
      productName = response.data.productName;
      productUom = response.data.productUom;
      productSize = response.data.productSize;
      notifyListeners();

      print("LIST Nutrition LENGHT: ${mobileNutritions.length}");

    } else {
      print("ERERERERERE");
    }

    notifyListeners();

     return null ;

  }


  onSearchTextChanged(String text) async {
    searchListResult.clear();
    if (text.isEmpty) {
      notifyListeners();
      return;
    }

    listFood.forEach((item) {
      if (item.productName.contains(text) ||
          item.productName.contains(text)) searchListResult.add(item);
      print("SERACH LIST LENGHT: ${searchListResult.length}");
    });
    notifyListeners();
  }
}