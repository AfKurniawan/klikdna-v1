
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/pages/login_page.dart';
import 'package:new_klikdna/src/main/pages/main_page.dart';
import 'package:new_klikdna/src/onboarding/pages/on_boarding_page.dart';
import 'package:new_klikdna/src/patient_card/pages/edit_patient_card_page.dart';
import 'package:new_klikdna/src/patient_card/pages/patient_card_page.dart';
import 'package:new_klikdna/src/splash/pages/splash_page.dart';
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
        return PageTransition(child: MainPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "patient_card_page" :
        return PageTransition(child: PatientCardPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "edit_patient_card_page" :
        return PageTransition(child: EditPatientCardPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;


    }

    return null;

  }
}