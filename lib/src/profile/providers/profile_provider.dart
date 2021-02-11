import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/profile/widgets/cupertino_dialog_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileProvider with ChangeNotifier {

  String result;
  final format = DateFormat("yyyy-MM-dd");



  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, "/");
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
    //const url = 'https://dnaku.id/ketentuan/mobile/syarat_ketentuan';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }

  }

  void kebijakanPrivasi(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }

  }

  void lembarPersetujuan() async {
    const url = 'https://dnaku.id/ketentuan/mobile/lembar_persetujuan';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
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