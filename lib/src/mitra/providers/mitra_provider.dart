import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MitraProvider with ChangeNotifier {


  void treeWebview(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true, universalLinksOnly: true);
    } else {
      throw 'Could not launch $url';
    }

  }
}