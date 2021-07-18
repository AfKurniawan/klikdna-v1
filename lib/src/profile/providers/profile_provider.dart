import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/last_seen_foodmeter_provider.dart';
import 'package:new_klikdna/src/profile/widgets/cupertino_dialog_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileProvider with ChangeNotifier {

  String result;
  final format = DateFormat("yyyy-MM-dd");

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, "/");
    Provider.of<MemberProvider>(context, listen: false).resetMember();
    Provider.of<PatientCardProvider>(context, listen: false).clearPatientCard();
    Provider.of<AccountProvider>(context, listen: false).clearLastID();
    Provider.of<LastSeenFoodMeterProvider>(context, listen: false).clearLastSeen();
    notifyListeners();
  }



  void makeCallPhone(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoDialogWidget(
          title: "Menghubungi via Telepon",
          message:
          'Apakah anda yakin akan menghubungi KlikDNA melalui Telepon ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('tel:+62215713966');
            } else {
              launch('tel:+62215713966');
            }
          },
        );
      },
    );
  }

  void syaratKetentuan(String url) async {
   const url2 = 'https://www.klikdna.com/webviewpages/ketentuanpengguna';
    if (await canLaunch(url2)) {
      await launch(url2,
          forceWebView: true,
        enableJavaScript: true
      );
    } else {
      throw 'Could not launch $url';
    }

  }

  void kebijakanPrivasi(String url) async {
    const url2 = 'https://www.klikdna.com/webviewpages/kebijakanprivasi';
    if (await canLaunch(url2)) {
      await launch(url2, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url2';
    }

  }

  void openWhatsapp(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoDialogWidget(
          title: "Menghubungi via Whatsapp",
          message:
          'Apakah anda yakin akan menghubungi KlikDNA melalui Whatsapp ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('whatsapp://send?phone=+62816307362');
            } else {
              launch('whatsapp://send?phone=+62816307362');
            }
          },
        );
      },
    );
  }

  void openTelegram(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {

        return CupertinoDialogWidget(
          title: "Menghubungi via Telegram",
          message:
          'Apakah anda yakin akan menghubungi KlikDNA melalui Telegram ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('https://t.me/joinchat/AAAAAEhlwknZ0OyOKtitiw');
            } else {
              launch('https://t.me/joinchat/AAAAAEhlwknZ0OyOKtitiw');
            }
          },
        );
      },
    );
  }

  void sendEmail(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoDialogWidget(
          title: "Menghubungi via Email",
          message: 'Apakah anda yakin akan menghubungi KlikDNA melalui Email ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('mailto:support@klikdna.com');
            } else {
              launch('mailto:support@klikdna.com');
            }
          },
        );
      },
    );
  }
}