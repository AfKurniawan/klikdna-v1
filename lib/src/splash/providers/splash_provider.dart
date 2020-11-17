import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider with ChangeNotifier {

  bool isLogin;

  getPrefs(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      isLogin = prefs.getBool("isLogin");
      print("ISLOGIN IN SPLASHPAGE $isLogin");
    var duration = new Duration(seconds: 2);

    if(isLogin == null || isLogin == false){
      Timer(duration, (){
        Navigator.of(context).pushReplacementNamed("login_page");
      });
    } else {
        Navigator.of(context).pushReplacementNamed("main_page");
    }
  }

}