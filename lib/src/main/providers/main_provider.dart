import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/home/pages/home_page.dart';
import 'package:new_klikdna/src/login/models/new_dashboard_user_model.dart';
import 'package:new_klikdna/src/mitra/pages/mitra_page.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/new_patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/pmr/pages/pmr_page.dart';
import 'package:new_klikdna/src/profile/pages/main_profile_page.dart';
import 'package:new_klikdna/src/report/pages/new_main_report_page.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainProvider with ChangeNotifier {



  Widget currenPage = new HomePage();
  SharedPreferences prefs;


  int currentTab;
  String currentTitle;
  String personId;

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    personId = prefs.getString('personId');
    notifyListeners();
  }




  void selectTab(BuildContext context, int tabItem){
      currentTab = tabItem;

      switch (tabItem) {
        case 0 :
          currentTitle = "Beranda";
          currenPage = HomePage();


          break;

        case 1 :
          currentTitle = "PMR";
          currenPage = PMRPage();


          break;

        case 2 :
          currentTitle = "Mitra";
          currenPage = MitraPage();
          break;

        case 3 :
          currentTitle = "Report";
          currenPage = NewMainReportPage();

          break;

        case 4 :
          currentTitle = "Profil";
          currenPage = MainProfilePage();
          break;
      }

  }
}