
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/dummy/pages/dummy_chart_page.dart';
import 'package:new_klikdna/src/home/pages/details/detail_pin_page.dart';
import 'package:new_klikdna/src/home/pages/details/detail_promo_page.dart';
import 'package:new_klikdna/src/home/pages/details/detail_event_page.dart';
import 'package:new_klikdna/src/home/pages/semua/all_event_by_categories_page.dart';
import 'package:new_klikdna/src/home/pages/semua/semua_event_page.dart';
import 'package:new_klikdna/src/home/pages/semua/semua_pin_page.dart';
import 'package:new_klikdna/src/home/pages/semua/semua_promo_page.dart';
import 'package:new_klikdna/src/login/pages/login_page.dart';
import 'package:new_klikdna/src/lorem_ipsum/pages/lorem_ipsum_page.dart';
import 'package:new_klikdna/src/main/pages/main_page.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/pages/wallet_referral_page.dart';
import 'package:new_klikdna/src/onboarding/pages/on_boarding_page.dart';
import 'package:new_klikdna/src/patient_card/asuransi/pages/add_asuransi_page.dart';
import 'package:new_klikdna/src/patient_card/asuransi/pages/asuransi_page.dart';
import 'package:new_klikdna/src/patient_card/asuransi/pages/edit_asuransi_page.dart';
import 'package:new_klikdna/src/patient_card/pages/edit_patient_card_page.dart';
import 'package:new_klikdna/src/patient_card/pages/new_patient_card_page.dart';
import 'package:new_klikdna/src/patient_card/pages/patient_card_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/detail_food_meter_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/detail_nutrition_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/dummy/dummy_tts_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/food_meter_by_kategori_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/food_meter_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/foodmeter_search_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/new_detail_food_meter_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/new_foodmeter_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/restaurant_detail_page.dart';
import 'package:new_klikdna/src/profile/pages/main_profile_page.dart';
import 'package:new_klikdna/src/profile/pages/lihat_profile_page.dart';
import 'package:new_klikdna/src/report/pages/detail_report_page.dart';
import 'package:new_klikdna/src/report/pages/hasil_report_page.dart';
import 'package:new_klikdna/src/report/pages/home_report_page.dart';
import 'package:new_klikdna/src/splash/pages/splash_page.dart';
import 'package:page_transition/page_transition.dart';

class Routing {

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{

      "/": (_) => SplashPage(),
      // "/": (_) => NewDetailFoodMeterPage(),

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

      case "new_patient_card_page" :
        return PageTransition(child: NewPatientCardPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "edit_patient_card_page" :
        return PageTransition(
            child: EditPatientCardPage(),
            type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "home_report_page" :
        return PageTransition(
            child: HomeReportPage(),
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

      case "new_food_meter_page" :
        return PageTransition(
            child: NewFoodMeterPage(),
            type: PageTransitionType.fade,
            duration: Duration(
                milliseconds: 350
            )
        );


      case "food_meter_search_page" :
        return PageTransition(
            child: FoodMeterSearchPage(callback: settings.arguments),
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

      case "new_detail_food_meter_page" :
        return PageTransition(
            child: NewDetailFoodMeterPage(id: settings.arguments),
            type: PageTransitionType.fade,
            duration: Duration(
                milliseconds: 350
            )
        );

      case "restaurant_detail_page" :
        return PageTransition(
            child: RestoranDetailPage(id: settings.arguments),
            type: PageTransitionType.fade,
            duration: Duration(
                milliseconds: 350
            )
        );

      case "detail_nutrition_page" :
        return PageTransition(
            child: DetailNutritionPage(model: settings.arguments),
            type: PageTransitionType.fade,
            duration: Duration(
                milliseconds: 350
            )
        );

      case "food_meter_by_kategori_page" :
        return PageTransition(
            child: FoodMeterByKategoryPage(currentTab: settings.arguments),
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

      // case "post_it_now_page":
      //   return PageTransition(child: PostItNowPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
      //   break;

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

      case "semua_event_page":
        return PageTransition(child: SemuaEventPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "detail_pin_page":
        return PageTransition(child: DetailPinPage(model: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "detail_event_page":
        return PageTransition(child: DetailEventPage(model: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;

      case "all_event_by_category":
        return PageTransition(child: AllEventByCategoriesPage(model: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;


      case "dummy_tts_page":
        return PageTransition(child: DummyTTSPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;




    }

    return null;

  }
}