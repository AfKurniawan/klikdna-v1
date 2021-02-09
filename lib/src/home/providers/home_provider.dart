import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/home/models/home_model.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeProvider extends ChangeNotifier {


  List<ArrayData> bannerMapArray = [];
  List<ArrayData> bannerArray ;

  List<ArrayData> pinMapArray = [];
  List<ArrayData> pinArray ;

  List<ArrayData> allEventMapArray = [];
  List<ArrayData> allEventArray = [] ;

  List<ArrayData> trainingEventMapArray = [];
  List<ArrayData> trainingEventArray = [] ;

  List<ArrayData> healthEventMapArray = [];
  List<ArrayData> healthEventArray = [] ;




  var jsonArray = [];
  var promo ;
  bool isLoading ;

  Future<List<HomeModel>> getHomeContents(BuildContext context) async {
    isLoading = true ;
    var url = AppConstants.GET_HOME_ARTIKEL;
    final prov = Provider.of<CmsTokenProvider>(context, listen: false);
    String accessToken = prov.cmsAccessToken;
    print("CMS TOKEN IN HOME+++++ :$accessToken");
    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    final response = await http.get(url, headers: ndas);

    if(response.statusCode == 200){

      var responseJson = json.decode(response.body);
      jsonArray = responseJson['data'] as List;
      isLoading = false ;

      print("RESPONE STATUS CODE ====== ${response.statusCode}");



      for (int i = 0; i < jsonArray.length; i++) {
        promo = Data.fromJson(jsonArray[i]['data']);

        bannerMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
        bannerArray = bannerMapArray.where((i) => i.data.categoryId == 4 && i.data.status == 1).toList();

        pinMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
        pinArray = pinMapArray.where((i) => i.data.categoryId == 11 && i.data.status == 1).toList();

        var now = new DateTime.now();
        var sekarang = now.subtract(Duration(days: 0));
        allEventMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
        allEventArray = allEventMapArray.where((i) => i.data.categoryId == 13 || i.data.categoryId == 10 && i.data.status == 1).toList();
        allEventArray.removeWhere((el) => DateTime.parse(el.data.doDate).isBefore(sekarang));
        allEventArray.sort((a, b) => a.data.createdAt.compareTo(b.data.createdAt));

        trainingEventMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
        trainingEventArray = trainingEventMapArray.where((i) => i.data.categoryId == 10 && i.data.status == 1).toList();
        trainingEventArray.removeWhere((el) => DateTime.parse(el.data.doDate).isBefore(sekarang));
        trainingEventArray.sort((a, b) => a.data.createdAt.compareTo(b.data.createdAt));

        healthEventMapArray = jsonArray.map((p) => ArrayData.fromJson(p)).toList();
        healthEventArray = healthEventMapArray.where((i) => i.data.categoryId == 13 && i.data.status == 1).toList();
        healthEventArray.removeWhere((el) => DateTime.parse(el.data.doDate).isBefore(sekarang) && el.data.status == 1);
        healthEventArray.sort((a, b) => a.data.createdAt.compareTo(b.data.createdAt));


      }
      notifyListeners();
    }

    return null;

  }


  Future<File> shareContents(BuildContext context, String path, String desc) async {

    final response = await http.get("$path");
    final Directory tempo = await getTemporaryDirectory();
    final File imageFile = File('${tempo.path}/sharedImages.jpg');
    imageFile.writeAsBytesSync(response.bodyBytes);

    if(Platform.isIOS){
      Share.shareFiles(['${tempo.path}/sharedImages.jpg']);
      copyText(desc);
    } else {
      Share.shareFiles(['${tempo.path}/sharedImages.jpg'], text: '$desc');
    }

    return imageFile;
  }

  copyText(String desc){
    Clipboard.setData(new ClipboardData(text: "$desc"))
        .then((result) {

      Fluttertoast.showToast(
          msg: "Text berhasil dicopy",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );

    });
  }

  void handleUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

  }





}