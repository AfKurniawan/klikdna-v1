import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PMRProvider with ChangeNotifier {

  String firstname = "" ;
  String lastname = "" ;
  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    firstname = prefs.getString("firstname");
    lastname = prefs.getString("lastname");
    notifyListeners();
  }

}