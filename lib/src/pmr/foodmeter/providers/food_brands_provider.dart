import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/food_brand_model.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http ;

class FoodBrandsProvider extends ChangeNotifier {



  List<BrandDetail> brandDetailMap = [];
  List<BrandDetail> brandDetailList = [];
  List<BrandDetail> makananList = [];
  List<BrandDetail> minumanList = [];

  List<BrandDetail> makananMapList = [];
  List<BrandDetail> minumanMapList = [];

  bool isLoading = false ;

  Future<List> getRestoDetailzz(BuildContext context, int id) async {

    print("Start get Specific Food");

    isLoading = true ;

    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var url = AppConstants.PAGE_FOOD_BRANDS_URL + "$id" ;


    var r =  await http.get(url, headers: ndas);


    var response = json.decode(r.body);


    if(r.statusCode == 200){

      print("Specific BRANDS ===>> ${r.body}");
      isLoading = false;

      var brandFoodArray = response['data']['mobile_products'] as List;

      brandDetailList = brandFoodArray.map<BrandDetail>((j) => BrandDetail.fromJson(j)).toList();
      makananMapList = brandFoodArray.map<BrandDetail>((j) => BrandDetail.fromJson(j)).toList();
      minumanMapList = brandFoodArray.map<BrandDetail>((j) => BrandDetail.fromJson(j)).toList();

      makananList = makananMapList.where((i) => ("${i.categoryId}" == "1")).toList();
      minumanList = minumanMapList.where((i) => ("${i.categoryId}" == "2")).toList();


      Navigator.of(context).pushNamed("restaurant_detail_page", arguments: id);




    } else {

      print("Something wrong");
      isLoading = false;

    }
    notifyListeners();
  }
}