import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/patient_card/models/asuransi_model.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/card_insurance_item.dart';
import 'package:new_klikdna/src/patient_card/widgets/custom_dialog_confirm.dart';
import 'package:new_klikdna/src/patient_card/widgets/dialog_error_patient_card.dart';
import 'package:new_klikdna/src/profile/widgets/cupertino_dialog_widget.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  String photo = "" ;
  bool sukses;



  bool isMuter ;
  List<Asuransi> listAsuransi = [];

  List<Widget> slideCard = [];


  String patienCardId = "";
  int mitraId = 0;
  Future<PatientCardModel>getPatientCard(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMuter = true;
    final prov = Provider.of<TokenProvider>(context, listen: false);

    final getId = Provider.of<AccountProvider>(context, listen: false);
    getId.getUserAccount(context);
    patienCardId = getId.lastID;


    print("ACCOUNT ID ___: $patienCardId");

    String accessToken = prov.accessToken;
    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var url = AppConstants.GET_PATIENT_CARD_URL + '$patienCardId';

    final request = await http.get(url, headers: ndas);

    print("PATIEN CARD BODY_______: ${request.body}");


    if(request.statusCode == 200){

      final response = PatientCardModel.fromJson(json.decode(request.body));

      isMuter = false;
      id = response.data.id;
      nama = response.data.nama;
      accountId = response.data.accountId;
      noKtp = prefs.getString('nik');
      inssuranceCode = response.data.inssuranceCode;
      dob = response.data.dob;
      bloodType = response.data.bloodType;
      gender = response.data.gender;
      medicalProfesional = response.data.medicalProfesional;
      emergencyContact = response.data.emergencyContact;
      comorbidity = response.data.comorbidity;
      photo = response.data.photo;


      print("GENDER PATIENT CARD: $gender");


      sukses = response.success;

      var data = json.decode(request.body);

      var detailArray = data['data']['detail'] as List;
      listAsuransi = detailArray.map<Asuransi>((j) => Asuransi.fromJson(j)).toList();

      slideCard = [
        CardInssuranceItem(),
        CardInssuranceItem()
      ];

      notifyListeners();

      setParams();

    } else {
      isMuter = false;
      //showDialogError(context);

    }

    notifyListeners();
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

  Future<void> showDialogKonfirmasiHapus(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => CustomDialogKonfirmasiWidget(
          title: "Kartu Asuransi ini akan dihapus",
          description: "Apakah kamu yakin akan menghapus Kartu Asuransi ini?",
          filledButtonText: "Batal",
          outlineButtonText: "Hapus",
          filledButtonaction: (){
            Navigator.of(context).pop();

          },
          outlineButtonAction: (){
            Provider.of<AsuransiProvider>(context, listen: false).deleteAsuransi(context, id);
          },
        ));
  }

  void callKontakDarurat(BuildContext context, String phone) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoDialogWidget(
          title: "Menghubungi via Telepon",
          message:
          'Apakah anda yakin akan menghubungi Kontak Darurat melalui Telepon ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('tel:$phone');
            } else {
              launch('tel:$phone');
            }
          },
        );
      },
    );
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


  Future getImageV2(BuildContext context) async {
    final photo = await picker.getImage(source: ImageSource.camera);
    File image = await FlutterNativeImage.compressImage(photo.path,
        quality: 50, targetWidth: 100, targetHeight: 100);
    List<int> imageBytes = image.readAsBytesSync();
    photo64Encode = base64Encode(imageBytes); ///INI DIKIRIM KE BACKEND
    image64Decode = Base64Decoder().convert(photo64Encode);  ///UNTUK DITAMPILKAN

    if(photo64Encode == ""){
      return image64Decode == photoView;
    }
    updatePhoto(context);
    notifyListeners();

  }

  Future<void> updatePhoto(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    prov.getApiToken();
    String accessToken = prov.accessToken;
    String gambar = photo64Encode;
    notifyListeners();

    print("PHOTO: $gambar");
    int accountid = prefs.getInt("userid");
    var url = AppConstants.UPDATE_PATIENT_CARD_URL + patienCardId ;

    var body = {
      "account_id": accountid,
      "no_ktp": noKtpController.text,
      "inssurance_code": insuranceCardController.text,
      "nama": namaController.text,
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
      showToastUpdatePhoto(context, "Berhasil", "Data berhasil diupdate");

    } else {
      print("ERRRORRR UPDATE PATEINT CARD");
      print("${request.body}");
    }

  }

  void showToastUpdatePhoto(BuildContext ctx, String title, String subtitle) async {
    bool isCircle = true;
    await AchievementView(
      ctx,
      title: "$title",
      alignment: Alignment.bottomCenter,
      color: Colors.lightBlue,
      subTitle: "$subtitle",
      isCircle: isCircle,
      duration: Duration(milliseconds: 1000),
      listener: (status) {
        print(status);
      },
    )..show();

  }



  Future<void> updatePatientCard(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    prov.getApiToken();
    String accessToken = prov.accessToken;
    String gambar = photo64Encode;
    notifyListeners();

    print("PHOTO: $gambar");
    int accountid = prefs.getInt("userid");
    var url = AppConstants.UPDATE_PATIENT_CARD_URL + patienCardId ;

    var body = {
      "account_id": accountid,
      "no_ktp": noKtpController.text,
      "inssurance_code": insuranceCardController.text,
      "nama": namaController.text,
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
      showToast(context, "Berhasil", "Data berhasil diupdate");

    } else {
      print("ERRRORRR UPDATE PATEINT CARD");
      print("${request.body}");
    }

  }

  void setRhesus(BuildContext context, String rhesus){
    print("RHESUS : $rhesus");
    bloodTypeController.text = rhesus;
    updatePatientCard(context);
    notifyListeners();
  }


  void showToast(BuildContext ctx, String title, String subtitle) async {
    bool isCircle = true;
    await AchievementView(
      ctx,
      title: "$title",
      alignment: Alignment.bottomCenter,
      color: Colors.lightBlue,
      subTitle: "$subtitle",
      isCircle: isCircle,
      duration: Duration(milliseconds: 1000),
      listener: (status) {
        print(status);
        if(status == AchievementState.opening){
          Navigator.of(ctx).pop();
        }
      },
    )..show();

  }


  showDialogSukses(BuildContext ctx){
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
      message: 'Kartu Pasien berhasil di simpan',
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
}