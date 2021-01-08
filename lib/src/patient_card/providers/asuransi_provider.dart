import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/patient_card/models/asuransi_model.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
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
    String accessToken = prov.accessToken;
    patientCardId = patient.id;
    print("PATOENT CARD ID PAGE ASURANSI: $patientCardId");

    var url = AppConstants.GET_ASURANSI_URL + asuranId.toString();
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.get(url, headers: ndas);
    final response = AsuransiModel.fromJson(json.decode(request.body));

    print("ASURANSI: ${request.body}");

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
      print("Error Asuransi");
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

  Future<void> updateAsuransi(BuildContext context) async {
    final prov = Provider.of<TokenProvider>(context, listen: false);
    final patientCardId = Provider.of<PatientCardProvider>(context, listen: false);
    int patientId = patientCardId.id;
    print("PATIEN CARD ID : $patientId");
    print("ASURASNI ID: $asuransiId");

    String accessToken = prov.accessToken;
    notifyListeners();


    var url = AppConstants.UPDATE_ASURANSI_URL + asuransiId.toString();
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var body = {
      "patient_card_id": patientId,
      "nomor_asuransi": namaAsuransiController.text,
      "nomor_polis": nomorPolisController.text,
      "pemegang_polis": pemegangPolisController.text,
      "nama_peserta": namaPesertaController.text,
      "nomor_kartu": nomorKartuController.text,
    };
    print("PROSES WITH BODY: $body");

    final request = await http.put(url, headers: ndas, body: json.encode(body));
    print("STATUS CODE: ${request.statusCode}");

    if(request.statusCode == 200){
      showDialog(context);

      print("RESPONSE BODY: ${request.body}");
    }

  }


  TextEditingController addNamaAsuransiController = new TextEditingController();
  TextEditingController addNomorPolisController = new TextEditingController();
  TextEditingController addPemegangPolisController = new TextEditingController();
  TextEditingController addNamaPesertaController = new TextEditingController();
  TextEditingController addNomorKartuController = new TextEditingController();



  Future<void> addAsuransi(BuildContext context) async {
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;
    notifyListeners();


    var url = AppConstants.SAVE_ASURANSI_URL ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var body = {
      "patient_card_id": patientCardId.toString(),
      "nomor_asuransi": addNamaAsuransiController.text,
      "nomor_polis": addNomorPolisController.text,
      "pemegang_polis": addPemegangPolisController.text,
      "nama_peserta": addNamaPesertaController.text,
      "nomor_kartu": addNomorKartuController.text,
    };
    print("PROSES WITH BODY: $body");

    final request = await http.post(url, headers: ndas, body: json.encode(body));
    print("STATUS CODE: ${request.statusCode}");

    if(request.statusCode == 200){
      showDialog(context);
      print("RESPONSE BODY: ${request.body}");
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
    notifyListeners();

    var url = AppConstants.DELETE_ASURANSI_URL + insurId.toString() ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    final request = await http.delete(url, headers: ndas);
    print("STATUS CODE: ${request.statusCode}");

    if(request.statusCode == 200){
      showDialogDelete(context);

      print("RESPONSE BODY: ${request.body}");
    }

  }



  showDialog(BuildContext ctx){
    Flushbar(
      margin: EdgeInsets.all(8),
      duration: Duration(seconds: 4),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [MyColors.dnaGreen, Colors.lightBlueAccent],
        stops: [0.3, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      flushbarPosition: FlushbarPosition.BOTTOM,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Sukses...',
      message: 'Kartu Asuransi berhasil di simpan',
    )
      ..onStatusChanged = (FlushbarStatus status) {
        switch (status) {
          case FlushbarStatus.SHOWING:
            {
              break;
            }
          case FlushbarStatus.IS_APPEARING:
            {
              print("FLUSHBAR IS APPEARING");

              break;
            }
          case FlushbarStatus.IS_HIDING:
            {
              print("FLUSHBAR IS HIDING");
              break;
            }
          case FlushbarStatus.DISMISSED:
            {
              print("FLUSHBAR IS DISMISSED");
              Navigator.pushReplacementNamed(ctx, "patient_card_page");
              break;
            }
        }
      }
      ..show(ctx);
  }

  Flushbar delflushbar = Flushbar(
    margin: EdgeInsets.all(8),
    duration: Duration(seconds: 4),
    borderRadius: 8,
    backgroundGradient: LinearGradient(
      colors: [MyColors.dnaGreen, Colors.lightBlueAccent],
      stops: [0.3, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.grey,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    flushbarPosition: FlushbarPosition.BOTTOM,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'Sukses...',
    message: 'Kartu Asuransi berhasil di hapus',
  );


  Future<Flushbar> showDialogDelete(BuildContext ctx){
    delflushbar
      ..onStatusChanged = (FlushbarStatus status) {
        switch (status) {
          case FlushbarStatus.SHOWING:
            {
              break;
            }
          case FlushbarStatus.IS_APPEARING:
            {
              print("FLUSHBAR IS APPEARING");

              break;
            }
          case FlushbarStatus.IS_HIDING:
            {
              print("FLUSHBAR IS HIDING");

              break;
            }
          case FlushbarStatus.DISMISSED:
            {
              print("FLUSHBAR IS DISMISSED");
              Navigator.pushReplacementNamed(ctx, "patient_card_page");
              break;
            }
        }
      }
      ..show(ctx);

    return null;
  }



}