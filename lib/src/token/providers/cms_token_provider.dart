import 'package:flutter/cupertino.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:new_klikdna/src/token/models/token_model.dart';


class CmsTokenProvider with ChangeNotifier {

  String cmsAccessToken= "" ;

  getCmsToken() async {

    print("START GET TOKEN");

    var url = AppConstants.CMS_TOKEN_URL;
    var body = {
      "email": AppConstants.CMS_EMAIL_TOKEN,
      "password": AppConstants.CMS_PASSWORD_TOKEN,
    };
    final request = await http.post(url, body: body);
    final cmsTokenResponse = TokenModel.fromJson(json.decode(request.body));

    if(request.statusCode == 200){

      print("CMS TOKEN GET TOKEN: ${request.statusCode}");

      cmsAccessToken = cmsTokenResponse.accessToken;

      notifyListeners();

      print("CMS ASKSES TOKEN $cmsAccessToken");

    } else {


    }

  }

  

}