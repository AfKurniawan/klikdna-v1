import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/pagination_model_data.dart';
import 'package:http/http.dart' as http;

class FilterFood extends ChangeNotifier {
  ModelData modelDataFromJson(String str) => ModelData.fromJson(json.decode(str));
  String modelDataToJson(ModelData data) => json.encode(data.toJson());

  Future<ModelData> sendPagesDataRequest(int page) async {

    try {
      String url = AppConstants.LIST_FOOD_URL + '1//0/0?page=$page';

      http.Response response = await http.get(url);

      ModelData md = modelDataFromJson(response.body);
      return md;
    } catch (e) {
      if (e is IOException) {
        /*return CountriesData.withError(
            'Please check your internet connection.');*/
      } else {
        print(e.toString());
        /*return CountriesData.withError('Something went wrong.');*/
      }
    }
  }

  int totalPagesGetter(ModelData pagesData) {
    return pagesData.data.data.total;
  }
}