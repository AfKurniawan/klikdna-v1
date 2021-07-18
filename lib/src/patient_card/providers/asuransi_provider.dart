import 'dart:convert';

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/models/asuransi_model.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AsuransiProvider extends ChangeNotifier {

  int asuransiId;
  int patientCardId;
  String nomorAsuransi;
  String nomorPolis;
  String pemegangPolis;
  String namaPeserta;
  String nomorKartu;

  bool isLoading;
  Future<Asuransi> getAsuransi(BuildContext context, int asuranId) async {

    isLoading = true;
    final prov = Provider.of<TokenProvider>(context, listen: false);
    final patient = Provider.of<PatientCardProvider>(context, listen: false);
    patient.getPatientCard(context);
    String accessToken = prov.accessToken;
    patientCardId = patient.id;


    var url = AppConstants.GET_ASURANSI_URL + asuranId.toString();
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.get(url, headers: ndas);
    final response = AsuransiModel.fromJson(json.decode(request.body));


    if(response.success == true){
      isLoading = false;
      asuransiId = response.data.id;
      patientCardId = response.data.patientCardId;
      nomorKartu = response.data.nomorKartu;
      nomorAsuransi = response.data.nomorAsuransi;
      namaPeserta = response.data.namaPeserta;
      nomorPolis = response.data.nomorPolis;
      pemegangPolis = response.data.pemegangPolis;
      notifyListeners();

      setParams();

    } else {
      isLoading = false;
      notifyListeners();
    }

    notifyListeners();

    return null;

  }

  TextEditingController namaAsuransiController = new TextEditingController();
  TextEditingController nomorPolisController = new TextEditingController();
  TextEditingController pemegangPolisController = new TextEditingController();
  TextEditingController namaPesertaController = new TextEditingController();
  TextEditingController nomorKartuController = new TextEditingController();

  setParams(){
    namaAsuransiController.text = nomorAsuransi;
    nomorPolisController.text = nomorPolis;
    pemegangPolisController.text = pemegangPolis;
    namaPesertaController.text = namaPeserta;
    nomorKartuController.text = nomorKartu;
    notifyListeners();
  }

  Future<void> updateAsuransi(BuildContext context, String type) async {
    final prov = Provider.of<TokenProvider>(context, listen: false);
    final patientCardId = Provider.of<PatientCardProvider>(context, listen: false);
    int patientId = patientCardId.id;

    String accessToken = prov.accessToken;

    var url = AppConstants.UPDATE_ASURANSI_URL + asuransiId.toString();
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var body = {
      "patient_card_id": patientId,
      "type": type,
      "nomor_asuransi": namaAsuransiController.text,
      "nomor_polis": nomorPolisController.text,
      "pemegang_polis": pemegangPolisController.text,
      "nama_peserta": namaPesertaController.text,
      "nomor_kartu": nomorKartuController.text,
    };

    final request = await http.put(url, headers: ndas, body: json.encode(body));

    if(request.statusCode == 200){
      showToast(context, "Berhasil", "Kartu Asuransi berhasil diupdate");

    }

    notifyListeners();

  }


  TextEditingController addNamaAsuransiController = new TextEditingController();
  TextEditingController addNomorPolisController = new TextEditingController();
  TextEditingController addPemegangPolisController = new TextEditingController();
  TextEditingController addNamaPesertaController = new TextEditingController();
  TextEditingController addNomorKartuController = new TextEditingController();


  Future<void> checkLastId(BuildContext context){

    final getId = Provider.of<AccountProvider>(context, listen: false);
    getId.getUserAccount(context);
    String lastid = getId.lastID;
    print("The Last ID ==> $lastid");

    if(lastid == null || lastid == "") {
      createPatienCard(context);
    }
  }

  Future<void> createPatienCard(BuildContext context) async {
    final prov = Provider.of<TokenProvider>(context, listen: false);
    final acc = Provider.of<AccountProvider>(context, listen: false);
    String accessToken = prov.accessToken;
    var url = AppConstants.POST_NEW_PATIENT_CARD_URL ;

    String gender = Provider.of<MitraProvider>(context, listen: false).vgender;
    String pcardName = Provider.of<MitraProvider>(context, listen: false).vallName;
    String pcardKtp = Provider.of<MitraProvider>(context, listen: false).vnik;
    int pcardUserId = Provider.of<MitraProvider>(context, listen: false).vuserid;

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    var body = {
      "account_id": pcardUserId,
      "no_ktp": pcardKtp,
      "nama" : pcardName,
      "gender" : gender
    };

    final response = await http.post(url, headers: ndas, body: json.encode(body));
    print("RESPONSE BODY NEW PATIENT CARD ${response.statusCode}, ${response.body}");

  }



  Future<void> addAsuransi(BuildContext context, String type) async {
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    final getId = Provider.of<AccountProvider>(context, listen: false);
    getId.getUserAccount(context);
    patientCardId = int.parse(getId.lastID);

    notifyListeners();


    var url = AppConstants.SAVE_ASURANSI_URL ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var body = {
      "patient_card_id": patientCardId,
      "type" : type,
      "nomor_asuransi": addNamaAsuransiController.text,
      "nomor_polis": addNomorPolisController.text,
      "pemegang_polis": addPemegangPolisController.text,
      "nama_peserta": addNamaPesertaController.text,
      "nomor_kartu": addNomorKartuController.text,
    };

    final request = await http.post(url, headers: ndas, body: json.encode(body));

    if(request.statusCode == 200){
      showToast(context, "Berhasil", "Kartu Asuransi berhasil diupdate");
      disposal();
    }

  }

  disposal(){
    addNamaAsuransiController.text = "";
    addNomorPolisController.text = "";
    addPemegangPolisController.text = "";
    addNamaPesertaController.text = "";
    addNomorKartuController.text = "";
    notifyListeners();
  }

  Future<void> deleteAsuransi(BuildContext context, int insurId) async {
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    var url = AppConstants.DELETE_ASURANSI_URL + insurId.toString() ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    final request = await http.delete(url, headers: ndas);

    if(request.statusCode == 200){
      showToast(context, "Berhasil", "Kartu Asuransi berhasil dihapus");
    }

  }




  void showToast(BuildContext ctxx, String title, String subtitle) async {
    bool isCircle = true;
    AchievementView(
      ctxx,
      title: "$title",
      alignment: Alignment.bottomCenter,
      color: Colors.lightBlue,
      subTitle: "$subtitle",
      isCircle: isCircle,
      duration: Duration(milliseconds: 1000),
      listener: (status) {
        if(status == AchievementState.opening) {
          Provider.of<PatientCardProvider>(ctxx, listen: false).getPatientCard(ctxx).then((value) => Navigator.of(ctxx).pop());
        }
      },
    )..show();

  }

  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final _formKey = GlobalKey<FormState>();

  List<String> listNamaAsuransi = [
    "AIA",
    "ALLIANZ",
    "AXA MANDIRI",
    "CIGNA",
    "FWD",
    "GENERALI",
    "PRUDENTIAL",
    "MANULIFE",
    "SEQUIS LIFE",
    "JIWASRAYA",
    "SINARMAS",
    "BNI LIFE",
    "LIPPO INSURANCE",
    "AXA",
    "TAKAFUL",
    "BUMIPUTERA",
    "AVRIST",
    "CHUBB",
    "ADIRA INSURANCE",
    "EQUITY",
    "AIA",
    "MUG"
  ];

  List<String> walletType = [
    "Jiwa",
    "Kesehatan"
  ];

  String tipeValue = "Jiwa" ;
  String result;

  void _handleRadioValueChange(BuildContext context, String value) {
    tipeValue = value;
    switch (tipeValue) {
      case "Jiwa":
        result = "Jiwa";
        break;
      case "Kesehatan":
        result = "Kesehatan";
        break;
    }
  }


  fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }



}