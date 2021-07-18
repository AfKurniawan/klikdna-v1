import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/configs/prefs_key.dart';
import 'package:new_klikdna/configs/prefs_key.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/models/new_all_patien_card_model.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/favourite_food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/last_seen_foodmeter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/bottomsheet/bs_bb_tb_dialog.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/dialog_berat_tinggi_badan.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewPatientCardProvider extends ChangeNotifier {

  /// List All Of Pasien Card
  List<DataPatientCard> listPatientCard = [] ;
  List<DataPatientCard> listDataPatientCard = [];
  var lastId ;
  PrefsKey prefsKey = new PrefsKey();
  Future<DataPatientCard> getAllPatientCard (BuildContext context) async {
    prefsKey.getPrefs();
    int userid = prefsKey.userid;
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer ${tokenProvider.accessToken}"
    };
    var url = AppConstants.GET_PATIENT_CARD_URL;
    final response = await http.get(url, headers: header);
    print("[New Patient Card Provider] Get All Patient Card Response Status Code ==> ${response.statusCode}");
    if(response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      var dataArray = responseBody['data'] as List;
      print("[New Patient Card Provider] User ID from PREFS KEY class ====> ${prefsKey.userid}");
      listPatientCard = dataArray.map<DataPatientCard>((j) => DataPatientCard.fromJson(j)).toList();
      lastId = listPatientCard.where((element) => element.accountId == userid);
      if(lastId.isEmpty) {
        print("[New Patient Card Provider] Response All last ID ====> NULLLLLLL");
        insertNewPatientCard(context);
      } else {
        print("[New Patient Card Provider] Response All last ID ====> ${lastId.last.id}");
        //prefs.setInt("pasien_card_id", lastId.last.id);
        prefsKey.savePatientCardId(lastId.last.id);
      }

      notifyListeners();
    }
  }



   /// Get Pasien Card by Pasien Card ID
  List<DataPatientCard> listPatientCardById = [] ;
  List<DataPatientCard> listDataPatientCardById = [];
  String bb = "";
  String tb = "";
  Future<PatientCardModel> getPatientCardById (BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[New Patient Card Provider] Pasien Card ID SINGLE user ====> ${prefs.getInt('pasien_card_id')}");
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer ${tokenProvider.accessToken}"
    };
    var url = AppConstants.GET_PATIENT_CARD_URL + "${prefs.getInt('pasien_card_id')}";
    final response = await http.get(url, headers: header);
    print("[New Patient Card Provider] Get Only Patient Card Response Status Code ==> ${response.statusCode} ==> Response body ${response.body}");
    if(response.statusCode == 200) {
     // dialogBbTb.beratTinggiBadanDialog(context);
      final jsonPatientCard = PatientCardModel.fromJson(json.decode(response.body));
      bb = jsonPatientCard.data.weight ;
      tb = jsonPatientCard.data.height ;
      print("[New Patient Card Provider] RESPONSE Berat Badan & Tinggi Badan SINGLE Pasien ====> ${jsonPatientCard.data.height} | ${jsonPatientCard.data.weight}");
      notifyListeners();
      checkBeratBadan(context);
    }
  }


  BottomSheetBeratTinggiBadan dialogBbTb = new BottomSheetBeratTinggiBadan();
  checkBeratBadan(BuildContext context) {
    print("[NEW PATIENT CARD PROVIDER] Check BB dan TB ==> VALUE $bb | $tb");
    if (bb == null || tb == null) {
      print("[NEW PATIENT CARD PROVIDER] in condition bb dan tb null");
      beratTinggiBadanDialog(context);
    } else if (bb == "" || tb == "") {
      beratTinggiBadanDialog(context);
      print("[NEW PATIENT CARD PROVIDER] in condition bb dan tb kosong");
    } else {
      print("[NEW PATIENT CARD PROVIDER] in condition bb dan tb tidak kosong dan tidak null");
      Provider.of<LastSeenFoodMeterProvider>(context, listen: false).getLastSeenFood(context);
      Provider.of<FavouriteFoodMeterProvider>(context, listen: false).getFavouriteData(context);
    }
    notifyListeners();
  }

  Future<void> insertNewPatientCard(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    int _accountId = prefs.getInt("userid");
    print("[New Pasien Card Provider] Pasien Card ID ==> $_accountId");

    String gender = Provider.of<MitraProvider>(context, listen: false).vgender;
    String pcardName = Provider.of<MitraProvider>(context, listen: false).vallName;
    String pcardKtp = Provider.of<MitraProvider>(context, listen: false).vnik;

    var url = AppConstants.POST_NEW_PATIENT_CARD_URL;

    var body = {
      "account_id": "$_accountId",
      "no_ktp": pcardKtp,
      "nama" : pcardName,
      "gender" : gender
    };

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final response = await http.post(url, headers: header, body: json.encode(body));
    if (response.statusCode == 200) {
      final jsonNewPatientCard = PatientCardModel.fromJson(json.decode(response.body));
      bb = jsonNewPatientCard.data.weight;
      tb = jsonNewPatientCard.data.height;
      prefs.setInt("pasien_card_id", jsonNewPatientCard.data.id);
      print("[New Pasien Card Provider] Response body Insert Patient Card ==> ${response.body}");
    } else {

    }
  }

  Future<void> updateBeratBadan(
      BuildContext context, String height, String weight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    int _pasienCardId = prefs.getInt("pasien_card_id");
    print("[New Pasien Card Provider] Pasien Card ID ==> $_pasienCardId");
    int _accountId = prefs.getInt("userid");
    print("[New Pasien Card Provider] Account ID ==> $_accountId");


    var url = AppConstants.UPDATE_PATIENT_CARD_URL + '$_pasienCardId';

    var body = {
      "account_id": "$_accountId",
      "height": height,
      "weight": weight
    };

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final response = await http.put(url, headers: header, body: json.encode(body));
    if (response.statusCode == 200) {
      showToast(context, "Berhasil", "Data berhasil diupdate");
    } else {}
  }

  void showToast(BuildContext ctx, String title, String subtitle) async {
    bool isCircle = true;
    AchievementView(
      ctx,
      title: "$title",
      alignment: Alignment.bottomCenter,
      color: Colors.lightBlue,
      subTitle: "$subtitle",
      isCircle: isCircle,
      duration: Duration(milliseconds: 1000),
      listener: (status) {
        if (status == AchievementState.opening) {
          Navigator.of(ctx).pop();
        }
      },
    )..show();
  }

  void beratTinggiBadanDialog (BuildContext context) {
    showModalBottomSheet(
        enableDrag: false,
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        builder: (context) {
          return BottomSheetBeratTinggiBadan();
        });
  }
}