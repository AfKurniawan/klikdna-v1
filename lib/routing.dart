
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/asuransi/pages/add_asuransi_page.dart';
import 'package:new_klikdna/src/asuransi/pages/asuransi_page.dart';
import 'package:new_klikdna/src/asuransi/pages/edit_asuransi_page.dart';
import 'package:new_klikdna/src/dummy/pages/dummy_chart_page.dart';
import 'package:new_klikdna/src/foodmeter/pages/detail_food_meter_page.dart';
import 'package:new_klikdna/src/foodmeter/pages/food_meter_page.dart';
import 'package:new_klikdna/src/home/pages/pin_detail_page.dart';
import 'package:new_klikdna/src/home/pages/detail_promo_page.dart';
import 'package:new_klikdna/src/home/pages/semua_event_page.dart';
import 'package:new_klikdna/src/home/pages/semua_pin_page.dart';
import 'package:new_klikdna/src/home/pages/semua_promo_page.dart';
import 'package:new_klikdna/src/login/pages/login_page.dart';
import 'package:new_klikdna/src/lorem_ipsum/pages/lorem_ipsum_page.dart';
import 'package:new_klikdna/src/main/pages/main_page.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/pages/wallet_referral_page.dart';
import 'package:new_klikdna/src/onboarding/pages/on_boarding_page.dart';
import 'package:new_klikdna/src/patient_card/pages/edit_patient_card_page.dart';
import 'package:new_klikdna/src/patient_card/pages/patient_card_page.dart';
import 'package:new_klikdna/src/postitnow/pages/detail_positnow_page.dart';
import 'package:new_klikdna/src/postitnow/pages/postitnow_page.dart';
import 'package:new_klikdna/src/profile/pages/main_profile_page.dart';
import 'package:new_klikdna/src/profile/pages/lihat_profile_page.dart';
import 'package:new_klikdna/src/report/pages/detail_report_page.dart';
import 'package:new_klikdna/src/report/pages/hasil_report_page.dart';
import 'package:new_klikdna/src/splash/pages/splash_page.dart';
import 'package:new_klikdna/src/wearable/pages/health_meter_page.dart';
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

      case "lorem_ipsum_page":
        return PageTransition(child: LoremIpsumPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "post_it_now_page":
        return PageTransition(child: PostItNowPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "detail_positnow_page":
        return PageTransition(child: DetailPostitNowPage(model: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "detail_promo_page":
        return PageTransition(child: DetailPromoPage(model: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "asuransi_page":
        return PageTransition(child: AsuransiPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "add_asuransi_page":
        return PageTransition(child: AddAsuransiPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "edit_asuransi_page":
        return PageTransition(child: EditAsuransiPage(model: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "health_meter_page":
        return PageTransition(child: DummyChartPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "semua_promo_page":
        return PageTransition(child: SemuaPromoPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "semua_pin_page":
        return PageTransition(child: SemuaPinPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "pin_detail_page":
        return PageTransition(child: PinDetailPage(model: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "semua_event_page":
        return PageTransition(child: SemuaEventPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;


    }

    return null;

  }
}