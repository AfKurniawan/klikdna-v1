import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/patient_card/widgets/dialog_error_patient_card.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PatientCardProvider with ChangeNotifier {

  int id;
  int accountId;
  String noKtp;
  String inssuranceCode;
  String nama;
  String gender;
  String dob;
  String bloodType;
  String medicalProfesional;
  String emergencyContact;
  String comorbidity;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String photo ;
  bool sukses;



  bool isLoading ;
  List<Asuransi> listAsuransi = [];


  String patienCardId = "";
  Future<PatientCardModel>getPatientCard(BuildContext context) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    final getId = Provider.of<AccountProvider>(context, listen: false);
    getId.getUserAccount(context);
    patienCardId = getId.lastID;
    notifyListeners();

    print("LAST ID : $patienCardId");

    String accessToken = prov.accessToken;
    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var url = AppConstants.GET_PATIENT_CARD_URL + patienCardId ;

    final request = await http.get(url, headers: ndas);
    final response = PatientCardModel.fromJson(json.decode(request.body));


    if(request.statusCode == 200){
      //print("RESPONSE BODY: ${request.body}");
      isLoading = false;
      id = response.data.id;
      nama = response.data.nama;
      accountId = response.data.accountId;
      noKtp = response.data.noKtp;
      inssuranceCode = response.data.inssuranceCode;
      dob = response.data.dob;
      bloodType = response.data.bloodType;
      gender = response.data.gender;
      medicalProfesional = response.data.medicalProfesional;
      emergencyContact = response.data.emergencyContact;
      comorbidity = response.data.comorbidity;
      photo = response.data.photo;




      print("FOTO PATIENT CARD: $photo");


      sukses = response.success;

      var data = json.decode(request.body);

      var detailArray = data['data']['detail'] as List;
      listAsuransi = detailArray.map<Asuransi>((j) => Asuransi.fromJson(j)).toList();

      print("PATIEN CARD ID PAGE PATIENT CARD: $id");

      notifyListeners();



      setParams();

    } else {
      isLoading = false;
      showDialogError(context);

    }

    return null;

  }

  Future<void> showDialogError(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => DialogErrorKartuPasien(
          title: "Belum ada Kartu Pasien tersimpan",
          description: "",
          filledButtonText: "Oke",
          filledButtonaction: (){
            Navigator.of(context).pushReplacementNamed('main_page', arguments: 1);
          },
        ));
  }







  TextEditingController namaController = new TextEditingController();
  TextEditingController noKtpController = new TextEditingController();
  TextEditingController insuranceCardController = new TextEditingController();
  TextEditingController bloodTypeController = new TextEditingController();
  TextEditingController medicalProfController = new TextEditingController();
  TextEditingController emergencyContactController = new TextEditingController();
  TextEditingController comorbidityController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();


  Uint8List photoView ;
  setParams(){

    namaController.text = nama;
    noKtpController.text = noKtp;
    insuranceCardController.text = inssuranceCode;
    bloodTypeController.text = bloodType;
    medicalProfController.text = medicalProfesional;
    emergencyContactController.text = emergencyContact;
    comorbidityController.text = comorbidity;
    dobController.text = dob;
    //photoView = Base64Decoder().convert(photo);

    print("FOTO FROM JSON: $photo");

    print("HPOTO VIEW: $photoView");
    notifyListeners();

  }

  final picker = ImagePicker();
  String photo64Encode = "";
  Uint8List image64Decode ;


  Future getImageV2 (BuildContext context) async {
    final photo = await picker.getImage(source: ImageSource.camera);
    File image = await FlutterNativeImage.compressImage(photo.path,
        quality: 50, targetWidth: 100, targetHeight: 100);
    List<int> imageBytes = image.readAsBytesSync();
    photo64Encode = base64Encode(imageBytes); ///INI DIKIRIM KE BACKEND
    image64Decode = Base64Decoder().convert(photo64Encode);  ///UNTUK DITAMPILKAN

    if(photo64Encode == ""){
      return image64Decode == photoView;
    }
    notifyListeners();
  }



  Future<void> updatePatientCard(BuildContext context, String jenkel) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;
    String gambar = photo64Encode;
    notifyListeners();

    print("PHOTO: $gambar");
    String personId = prefs.getString("personId");
    int accountid = prefs.getInt("userid");
    var url = AppConstants.UPDATE_PATIENT_CARD_URL + patienCardId ;

    var body = {
      "account_id": accountid,
      "no_ktp": noKtpController.text,
      "inssurance_code": insuranceCardController.text,
      "nama": namaController.text,
      "gender": jenkel,
      "dob": dobController.text,
      "blood_type": bloodTypeController.text,
      "medical_profesional": medicalProfController.text,
      "emergency_contact": emergencyContactController.text,
      "comorbidity": comorbidityController.text,
      "photo": gambar
    };

    Map<String, String> ndas = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.put(url, headers: ndas, body: json.encode(body));


    if(sukses == true){
      print("${request.body}");
      showDialogSukses(context);

    } else {
      print("ERRRORRR UPDATE PATEINT CARD");
      print("${request.body}");
    }

  }

  void setRhesus(BuildContext context, String rhesus){
    print("RHESUS : $rhesus");
    bloodTypeController.text = rhesus;
    notifyListeners();
  }

  Flushbar flushbar = Flushbar(
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
    message: 'Kartu Pasien berhasil di simpan',
  );


  Future<Flushbar> showDialogSukses(BuildContext ctx){
    flushbar
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
}