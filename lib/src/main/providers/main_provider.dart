import 'package:flutter/material.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/home/pages/home_page.dart';
import 'package:new_klikdna/src/mitra/pages/mitra_page.dart';
import 'package:new_klikdna/src/pmr/pages/pmr_page.dart';
import 'package:new_klikdna/src/profile/pages/main_profile_page.dart';
import 'package:new_klikdna/src/report/pages/home_report_page.dart';
import 'package:new_klikdna/src/report/pages/new_main_report_page.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken();
          break;

        case 1 :
          currentTitle = "PMR";
          currenPage = PMRPage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken();
          Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);

          break;

        case 2 :
          currentTitle = "Mitra";
          currenPage = MitraPage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken();
          break;

        case 3 :
          currentTitle = "Report";
          currenPage = NewMainReportPage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken();
          Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
          Provider.of<ReportProvider>(context, listen: false).getSample(context, personId);
          break;

        case 4 :
          currentTitle = "Profil";
          currenPage = MainProfilePage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken();
          break;
      }

  }
}