
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/foodmeter/pages/detail_food_meter_page.dart';
import 'package:new_klikdna/src/foodmeter/pages/food_meter_page.dart';
import 'package:new_klikdna/src/login/pages/login_page.dart';
import 'package:new_klikdna/src/main/pages/main_page.dart';
import 'package:new_klikdna/src/onboarding/pages/on_boarding_page.dart';
import 'package:new_klikdna/src/patient_card/pages/edit_patient_card_page.dart';
import 'package:new_klikdna/src/patient_card/pages/patient_card_page.dart';
import 'package:new_klikdna/src/profile/pages/main_profile_page.dart';
import 'package:new_klikdna/src/profile/pages/lihat_profile_page.dart';
import 'package:new_klikdna/src/report/pages/detail_report_page.dart';
import 'package:new_klikdna/src/report/pages/hasil_report_page.dart';
import 'package:new_klikdna/src/splash/pages/splash_page.dart';
import 'package:new_klikdna/src/wallets_and_referrals/pages/wallet_referral_page.dart';
import 'package:page_transition/page_transition.dart';

class Routing {

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{

      "/": (_) => SplashPage(),

    };
  }

  static Route onGenerateRoute(RouteSettings settings){

    switch(settings.name){

      case "login_page" :
        return PageTransition(child: LoginPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "onboarding_page" :
        return PageTransition(child: OnBoardingPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "main_page" :
        return PageTransition(child: MainPage(currentTab: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "patient_card_page" :
        return PageTransition(child: PatientCardPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "edit_patient_card_page" :
        return PageTransition(
            child: EditPatientCardPage(),
            type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "detail_profile_page" :
        return PageTransition(
          child: MainProfilePage(),
          type: PageTransitionType.fade,
          duration: Duration(
            milliseconds: 350
          )
        );

      case "lihat_profile_page" :
        return PageTransition(
          child: LihatProfilePage(),
          type: PageTransitionType.fade,
          duration: Duration(
            milliseconds: 350
          )
        );

      case "food_meter_page" :
        return PageTransition(
          child: FoodMeterPage(),
          type: PageTransitionType.fade,
          duration: Duration(
            milliseconds: 350
          )
        );

      case "detail_food_meter_page" :
        return PageTransition(
            child: DetailFoodMeterPage(food: settings.arguments),
            type: PageTransitionType.fade,
            duration: Duration(
                milliseconds: 350
            )
        );

      case "detail_report_page" :
        return PageTransition(
            child: DetailReportPage(model: settings.arguments),
            type: PageTransitionType.fade,
            duration: Duration(
                milliseconds: 350
            )
        );

      case "hasil_report_page":
        return PageTransition(child: HasilReportPage(model: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "wallet_referral_page":
        return PageTransition(child: WalletsAndReferralPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;


    }

    return null;

  }
}