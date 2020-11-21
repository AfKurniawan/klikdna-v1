import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_klikdna/configs/localization.dart';
import 'package:new_klikdna/routing.dart';
import 'package:new_klikdna/src/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/src/home/providers/artikel_provider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/main/providers/main_provider.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/pmr/providers/pmr_provider.dart';
import 'package:new_klikdna/src/profile/providers/profile_provider.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/src/splash/providers/splash_provider.dart';
import 'package:new_klikdna/styles/my_theme.dart';
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static final navKey = new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create:  (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => TokenProvider()),
        ChangeNotifierProvider(create: (_) => ArtikelProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => PMRProvider()),
        ChangeNotifierProvider(create: (_) => AsuransiProvider()),
        ChangeNotifierProvider(create: (_) => PatientCardProvider()),
        ChangeNotifierProvider(create: (_) => MitraProvider()),
        ChangeNotifierProvider(create: (_) => FoodMeterProvider()),
        ChangeNotifierProvider(create: (_) => DetailReportProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => MemberProvider())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routing.getRoute(),
        initialRoute: "/",
        onGenerateRoute: (settings) => Routing.onGenerateRoute(settings),
        theme: MyTheme.lightTheme,
        navigatorKey: navKey,

        supportedLocales: [
          Locale('id', 'ID')
        ],

        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocaleLanguage in supportedLocales) {
            if (supportedLocaleLanguage.languageCode == locale.languageCode &&
                supportedLocaleLanguage.countryCode == locale.countryCode) {
              return supportedLocaleLanguage;
            }
          }
          return supportedLocales.first;
        },

      ),
    );
  }
}

