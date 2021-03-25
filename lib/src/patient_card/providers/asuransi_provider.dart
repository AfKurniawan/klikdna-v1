import 'dart:convert';

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
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

  Future<void> updateAsuransi(BuildContext context, String type) async {
    final prov = Provider.of<TokenProvider>(context, listen: false);
    final patientCardId = Provider.of<PatientCardProvider>(context, listen: false);
    int patientId = patientCardId.id;
    print("PATIEN CARD ID : $patientId");
    print("ASURASNI ID: $asuransiId");

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
    print("PROSES WITH BODY: $body");

    final request = await http.put(url, headers: ndas, body: json.encode(body));
    print("STATUS CODE: ${request.statusCode}");

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



  Future<void> addAsuransi(BuildContext context, String type) async {
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    final getId = Provider.of<AccountProvider>(context, listen: false);
    getId.getUserAccount(context);
    patientCardId = int.parse(getId.lastID);

    print("PASIEN ID $patientCardId");

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
    print("PROSES WITH BODY: $body");

    final request = await http.post(url, headers: ndas, body: json.encode(body));
    print("STATUS CODE: ${request.body}");

    if(request.statusCode == 200){
      showToast(context, "Berhasil", "Kartu Asuransi berhasil diupdate");
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

    var url = AppConstants.DELETE_ASURANSI_URL + insurId.toString() ;
    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    final request = await http.delete(url, headers: ndas);
    print("STATUS CODE: ${request.statusCode}");

    if(request.statusCode == 200){
      showToast(context, "Berhasil", "Kartu Asuransi berhasil dihapus");

      print("RESPONSE BODY: ${request.body}");
    }

  }




  void showToast(BuildContext ctxx, String title, String subtitle) async {
    bool isCircle = true;
    await AchievementView(
      ctxx,
      title: "$title",
      alignment: Alignment.bottomCenter,
      color: Colors.lightBlue,
      subTitle: "$subtitle",
      isCircle: isCircle,
      duration: Duration(milliseconds: 1000),
      listener: (status) {
        print(status);
        if(status == AchievementState.open) {
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
        print("RESULT $result");
        break;
      case "Kesehatan":
        result = "Kesehatan";
        print("RESULT $result");
        break;
    }
  }
  void showModalAddInsuranceCard(BuildContext context){
    final validator = RequiredValidator(errorText: "Form wajib diisi");
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext _) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height - 25,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Tambah Asuransi", style: TextStyle(fontSize: 14)),
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 20),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(top: 20),
                // height: MediaQuery.of(context).size.height - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SimpleAutoCompleteTextField(
                              key: key,
                              suggestions: listNamaAsuransi,
                              controller: addNamaAsuransiController,
                              decoration: InputDecoration(
                                  labelText: "Nama Asuransi",
                                  alignLabelWithHint: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: MyColors.dnaGreen, width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red[300], width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red[300], width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent, width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusColor: MyColors.dnaGreen,
                                  hintText: "",
                                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12)),
                            ),
                            SizedBox(height: 20),
                            Text("Jenis Asuransi"),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              height: 60,
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10))),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        hint: Text(''),
                                        value: tipeValue,
                                        underline: Container(),
                                        items: walletType.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(
                                              value,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String value) {

                                            _handleRadioValueChange(context, value);

                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            FormWidget(
                              validator: validator,
                              hint: "",
                              obscure: false,
                              labelText: "Nomor Polis",
                              textEditingController: addNomorPolisController,
                              keyboardType: TextInputType.number,
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            FormWidget(
                              hint: "",
                              validator: validator,
                              obscure: false,
                              labelText: "Pemegang Polis",
                              textEditingController: addPemegangPolisController,
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            FormWidget(
                              hint: "",
                              obscure: false,
                              validator: validator,
                              labelText: "Nama Peserta",
                              textEditingController: addNamaPesertaController,
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            FormWidget(
                              hint: "",
                              validator: validator,
                              obscure: false,
                              labelText: "Nomor Kartu",
                              keyboardType: TextInputType.number,
                              textEditingController: addNomorKartuController,
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10.0),
              child: addNamaAsuransiController.text.isEmpty ?  ButtonWidget(
                btnText: "Simpan",
                height: 50,
                color: MyColors.grey,
              ) : ButtonWidget(
                btnText: "Simpan",
                btnAction: (){
                  //Provider.of<AsuransiProvider>(context, listen: false).addAsuransi(context, addAsuransi);
                  if (_formKey.currentState.validate() && addNamaAsuransiController.text.isNotEmpty) {
                    context.read<AsuransiProvider>().addAsuransi(context, tipeValue);
                  }
                },
                height: 50,
                color: MyColors.dnaGreen,
              ),
            ),
          ),
        );
      },
    );
  }



}