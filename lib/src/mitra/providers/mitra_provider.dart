import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/profile/widgets/cupertino_dialog_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MitraProvider with ChangeNotifier {


  void treeWebview(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true, universalLinksOnly: true);
    } else {
      throw 'Could not launch $url';
    }

  }

  void openWhatsapp(BuildContext context, String whatsapp, String name) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoDialogWidget(
          title: "Menghubungi via Whatsapp",
          message:
          'Apakah anda yakin akan menghubungi $name melalui Whatsapp ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('whatsapp://send?phone=62$whatsapp');
            } else {
              launch('whatsapp://send?phone=62$whatsapp');
            }
          },
        );
      },
    );
  }

  void makePhoneCall(BuildContext context, String nomor, String nama) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoDialogWidget(
          title: "Menghubungi via Telepon",
          message:
          'Apakah anda yakin akan menghubungi $nama melalui Telepon ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('tel:$nomor');
            } else {
              launch('tel:$nomor');
            }
          },
        );
      },
    );
  }
}

