import 'package:flutter/material.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/home/pages/home_page.dart';
import 'package:new_klikdna/src/mitra/pages/mitra_page.dart';
import 'package:new_klikdna/src/pmr/pages/pmr_page.dart';
import 'package:new_klikdna/src/profile/pages/detail_profile_page.dart';
import 'package:new_klikdna/src/report/pages/main_report_page.dart';
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'package:provider/provider.dart';

class MainProvider with ChangeNotifier {



  Widget currenPage = new HomePage();


  int currentTab;
  String currentTitle;

  void selectTab(BuildContext context, int tabItem){
      currentTab = tabItem;

      switch (tabItem) {
        case 0 :
          currentTitle = "Beranda";
          currenPage = HomePage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          break;

        case 1 :
          currentTitle = "PMR";
          currenPage = PMRPage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);

          break;

        case 2 :
          currentTitle = "Mitra";
          currenPage = MitraPage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          break;

        case 3 :
          currentTitle = "Report";
          currenPage = ReportPage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          break;

        case 4 :
          currentTitle = "Profil";
          currenPage = DetailProfilePage();
          Provider.of<TokenProvider>(context, listen: false).getApiToken();
          break;
      }

  }
}