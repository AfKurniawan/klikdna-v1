import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/card_insurance_item.dart';
import 'package:new_klikdna/src/patient_card/widgets/custom_dialog_confirm.dart';
import 'package:new_klikdna/src/patient_card/widgets/dialog_error_patient_card.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/favourite_food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/last_seen_foodmeter_provider.dart';
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
  String photo = "";
  String bb = "0";
  String tb = "0";
  bool sukses;

  bool isMuter;
  List<Asuransi> listAsuransi = [];

  List<Widget> slideCard = [];

  String patienCardId = "";
  int mitraId = 0;





  Future<PatientCardModel> getPatientCard(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMuter = true;
    final prov = Provider.of<TokenProvider>(context, listen: false);



    String accessToken = prov.accessToken;
    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };


    var url = AppConstants.GET_PATIENT_CARD_URL + "${prefs.getInt('pasien_card_id')}";

    final response = await http.get(url, headers: ndas);


    print("Get Patient Card Response Body ==> ${response.statusCode}");

    if (response.statusCode == 200) {

      final jsonResponse = PatientCardModel.fromJson(json.decode(response.body));

      isMuter = false;
      id = jsonResponse.data.id;
      nama = jsonResponse.data.nama;
      accountId = jsonResponse.data.accountId;
      noKtp = prefs.getString('nik');
      inssuranceCode = jsonResponse.data.inssuranceCode;
      dob = jsonResponse.data.dob;
      bb = jsonResponse.data.weight;
      tb = jsonResponse.data.height;
      bloodType = jsonResponse.data.bloodType;
      gender = jsonResponse.data.gender;
      medicalProfesional = jsonResponse.data.medicalProfesional;
      emergencyContact = jsonResponse.data.emergencyContact;
      print("EMERGENSI KONTAK $emergencyContact");
      comorbidity = jsonResponse.data.comorbidity;
      photo = jsonResponse.data.photo;

      sukses = jsonResponse.success;

      var data = json.decode(response.body);

      var detailArray = data['data']['detail'] as List;
      listAsuransi =
          detailArray.map<Asuransi>((j) => Asuransi.fromJson(j)).toList();


      slideCard = [CardInssuranceItem(), CardInssuranceItem()];

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
              filledButtonaction: () {
                Navigator.of(context)
                    .pushReplacementNamed('main_page', arguments: 1);
              },
            ));
  }

  Future<void> showDialogKonfirmasiHapus(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => CustomDialogKonfirmasiWidget(
              title: "Kartu Asuransi ini akan dihapus",
              description:
                  "Apakah kamu yakin akan menghapus Kartu Asuransi ini?",
              filledButtonText: "Batal",
              outlineButtonText: "Hapus",
              filledButtonaction: () {
                Navigator.of(context).pop();
              },
              outlineButtonAction: () {
                Provider.of<AsuransiProvider>(context, listen: false)
                    .deleteAsuransi(context, id);
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
  TextEditingController emergencyContactController =
      new TextEditingController();
  TextEditingController comorbidityController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();

  Uint8List photoView;

  setParams() {
    namaController.text = nama;
    noKtpController.text = noKtp;
    insuranceCardController.text = inssuranceCode;
    bloodTypeController.text = bloodType;
    medicalProfController.text = medicalProfesional;
    emergencyContactController.text = emergencyContact;
    comorbidityController.text = comorbidity;
    dobController.text = dob;
    notifyListeners();

  }

  final picker = ImagePicker();
  String photo64Encode = "";
  Uint8List image64Decode;

  Future getImageV2(BuildContext context) async {
    final photo = await picker.getImage(source: ImageSource.camera);
    File image = await FlutterNativeImage.compressImage(photo.path,
        quality: 50, targetWidth: 100, targetHeight: 100);
    List<int> imageBytes = image.readAsBytesSync();
    photo64Encode = base64Encode(imageBytes);

    ///INI DIKIRIM KE BACKEND
    image64Decode = Base64Decoder().convert(photo64Encode);

    ///UNTUK DITAMPILKAN

    if (photo64Encode == "") {
      return image64Decode == photoView;
    }
    updatePhoto(context);
    notifyListeners();
  }

  Future<void> updatePhoto(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    prov.getApiToken(context);
    String accessToken = prov.accessToken;
    String gambar = photo64Encode;
    notifyListeners();

    int accountid = prefs.getInt("userid");
    var url = AppConstants.UPDATE_PATIENT_CARD_URL + "${prefs.getInt('pasien_card_id')}";

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

    if (sukses == true) {
      showToastUpdatePhoto(context, "Berhasil", "Data berhasil diupdate");
    } else {}
  }

  void showToastUpdatePhoto(BuildContext ctx, String title, String subtitle) async {
    bool isCircle = true;
    AchievementView(
      ctx,
      title: "$title",
      alignment: Alignment.bottomCenter,
      color: Colors.lightBlue,
      subTitle: "$subtitle",
      isCircle: isCircle,
      duration: Duration(milliseconds: 1000),
      listener: (status) {},
    )..show();
  }

  Future<void> updatePatientCard(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    prov.getApiToken(context);
    String accessToken = prov.accessToken;
    String gambar = photo64Encode;
    int accountid = prefs.getInt("userid");
    var url = AppConstants.UPDATE_PATIENT_CARD_URL + '${prefs.getInt('pasien_card_id')}';

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

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final response = await http.put(url, headers: header, body: json.encode(body));
    print("[PASIEN CARD PROVIDER] Response body ${response.body} ");

    if (response.statusCode == 200) {
      showToast(context, "Berhasil", "Data berhasil diupdate");
    } else {}
  }




  void setRhesus(BuildContext context, String rhesus) {
    bloodTypeController.text = rhesus;
    updatePatientCard(context);
    notifyListeners();
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
          getPatientCard(ctx);
        }
      },
    )..show();
  }

  void clearPatientCard(){
    listAsuransi.clear();
    notifyListeners();
  }


}
