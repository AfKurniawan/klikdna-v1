import 'package:flutter/cupertino.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:new_klikdna/src/token/models/token_model.dart';


class TokenProvider with ChangeNotifier {

  String accessToken= "" ;


  getApiToken() async {
    print("START GET TOKEN");
    var url = AppConstants.API_TOKEN_URL;
    var body = {
      "email": AppConstants.EMAIL_TOKEN,
      "password": AppConstants.PASSWORD_TOKEN,
    };
    final request = await http.post(url, body: body);
    final apiTokenResponse = TokenModel.fromJson(json.decode(request.body));

    if(request.statusCode == 200){

      print("GET TOKEN ${request.body}");
      accessToken = apiTokenResponse.accessToken;

      notifyListeners();

    } else {


    }

  }

  

}