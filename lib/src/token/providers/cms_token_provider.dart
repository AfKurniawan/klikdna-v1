import 'package:flutter/cupertino.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'dart:convert';

import 'package:new_klikdna/src/token/models/token_model.dart';
import 'package:provider/provider.dart';


class CmsTokenProvider with ChangeNotifier {

  String cmsAccessToken= "" ;

  Future<String> getCmsToken (BuildContext context) async {
    var url = AppConstants.CMS_TOKEN_URL;
    var body = {
      "email": AppConstants.CMS_EMAIL_TOKEN,
      "password": AppConstants.CMS_PASSWORD_TOKEN,
    };
    final request = await http.post(url, body: body);
    final cmsTokenResponse = TokenModel.fromJson(json.decode(request.body));

    if(request.statusCode == 200) {

      cmsAccessToken = cmsTokenResponse.accessToken;
      context.read<HomeProvider>().getHomeContentsxx(context);

    } else {

      print("Do nothing");

    }

    notifyListeners();

    return cmsAccessToken;

  }

  

}