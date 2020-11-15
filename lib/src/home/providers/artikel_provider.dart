import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/home/models/artikel_model.dart';
import 'package:http/http.dart' as http;
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class ArtikelProvider with ChangeNotifier {
  
  List<Artikel> listArtikel  = [];
  String token = "";
  Future<Artikel> getArtikel(BuildContext context, String token) async {

    print("START GET ARTIKEL");

    //token = Provider.of<TokenProvider>(context, listen: false).accessToken;

    var url = AppConstants.GET_ARTIKEL_URL;

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final request = await http.get(url, headers: ndas);
    print("REQUEST ARTIKEL: ${request.statusCode}");

    if(request.statusCode == 200){

      var data = json.decode(request.body);

      var detailArray = data['data'] as List;
      listArtikel = detailArray.map<Artikel>((j) => Artikel.fromJson(j)).toList();
      notifyListeners();

    } else {
      print("ERROR ARTIKEL");
    }

    return null;

  }
}