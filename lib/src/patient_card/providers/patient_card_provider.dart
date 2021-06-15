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
    print("GET PASIEN CARD IS CALLING");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMuter = true;
    final prov = Provider.of<TokenProvider>(context, listen: false);

    final getId = Provider.of<AccountProvider>(context, listen: false);
    getId.getUserAccount(context);

    patienCardId = getId.lastID;

    print("PatienCard ID --> $patienCardId");

    String accessToken = prov.accessToken;
    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    print("ACCESS TOKERN --> $accessToken");

    var url = AppConstants.GET_PATIENT_CARD_URL + '$patienCardId';

    final request = await http.get(url, headers: ndas);

    if (request.statusCode == 200) {
      final response = PatientCardModel.fromJson(json.decode(request.body));

      isMuter = false;
      id = response.data.id;
      nama = response.data.nama;
      accountId = response.data.accountId;
      noKtp = prefs.getString('nik');
      inssuranceCode = response.data.inssuranceCode;
      dob = response.data.dob;
      bb = response.data.weight;
      tb = response.data.height;
      bloodType = response.data.bloodType;
      gender = response.data.gender;
      medicalProfesional = response.data.medicalProfesional;
      emergencyContact = response.data.emergencyContact;
      print("EMERGENSI KONTAK $emergencyContact");
      comorbidity = response.data.comorbidity;
      photo = response.data.photo;

      sukses = response.success;

      var data = json.decode(request.body);

      var detailArray = data['data']['detail'] as List;
      listAsuransi =
          detailArray.map<Asuransi>((j) => Asuransi.fromJson(j)).toList();

      print(
          "Respone berat badan --> ${response.data.weight} Response tinggi badan --> ${response.data.height}");

      slideCard = [CardInssuranceItem(), CardInssuranceItem()];

      _selectedValue = 0;
      _selectedValueTb = 0;
      tbController.text = "" ;
      bbController.text = "";
      isEnabled = false ;

      notifyListeners();

      //checkPatientCard(context);
      setParams();

    } else {
      isMuter = false;
      //showDialogError(context);

    }

    notifyListeners();
    return null;
  }

  checkPatientCard(BuildContext context){
    final acc = Provider.of<AccountProvider>(context, listen: false);
    if(acc.success == false || patienCardId == null) {
      showDialogError(context);
    } else {
      getBeratbadan(context);
    }
  }

  getBeratbadan(BuildContext context) {
    print("TINGGI BAdaan $tb -- BeraT Badan $bb");

    if (bb == "0" || tb == "0") {
      dialogBbTb(context);
    } else if (bb == null || tb == null) {
      dialogBbTb(context);
    } else {
      Provider.of<LastSeenFoodMeterProvider>(context, listen: false)
          .getLastSeenFood(context);
      Provider.of<FavouriteFoodMeterProvider>(context, listen: false)
          .getFavouriteData(context);
    }

    notifyListeners();
  }

  FixedExtentScrollController tbSelectController;
  FixedExtentScrollController bbSelectController;

  TextEditingController bbController = new TextEditingController();
  TextEditingController tbController = new TextEditingController();

  int _selectedValue = 20;
  int _selectedValueTb = 100;
  bool isEnabled = false;

  final _formKey = GlobalKey<FormState>();

  void dialogBbTb(BuildContext context) {
    final bbValidator = RequiredValidator(errorText: "Harap isi Berat");
    final tbValidator = RequiredValidator(errorText: "Harap isi Tinggi");
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        //isDismissible: false,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 24),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Isi Berat dan Tinggi Kamu",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: "Roboto"))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "Isilah berat dan tinggi kamu dengan benar untuk mendapatkan\nhasil rekomendasi pada food meter",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        fontFamily: "Roboto"))),
                          ),
                        ],
                      ),
                      SizedBox(height: 19),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: TextFormField(
                                  validator: bbValidator,
                                  style: TextStyle(
                                    color: MyColors.dnaBlack,
                                  ),
                                  controller: bbController,
                                  readOnly: true,
                                  onTap: () {
                                    _showBBPicker(context);
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: Colors.grey),
                                      labelText: "Berat",
                                      labelStyle: TextStyle(color: Colors.grey),
                                      alignLabelWithHint: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColors.dnaGreen, width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red[300], width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red[300], width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      focusColor: MyColors.dnaGreen,
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white54, fontSize: 12)),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: TextFormField(
                                  style: TextStyle(
                                    color: MyColors.dnaBlack,
                                  ),
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    _showTbPicker(context);
                                  },
                                  readOnly: true,
                                  validator: tbValidator,
                                  controller: tbController,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: Colors.grey),
                                      labelText: "Tinggi",
                                      labelStyle: TextStyle(color: Colors.grey),
                                      alignLabelWithHint: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColors.dnaGreen, width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red[300], width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red[300], width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.5),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      focusColor: MyColors.dnaGreen,
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white54, fontSize: 12)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 90),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Material(
                          color: MyColors.dnaGreen,
                          borderRadius: BorderRadius.circular(10),
                          child: isEnabled == false
                                ? InkWell(
                            onTap: () {

                            },
                            splashColor: Colors.white,
                            child: Ink(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200]),
                              child: Center(
                                child: Text(
                                  "Simpan",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                                : InkWell(
                                  onTap: () {
                                    if (_formKey.currentState.validate()) {
                                      updateBeratBadan(context, tbController.text,
                                          bbController.text);
                                    }

                                  },
                                  splashColor: Colors.white,
                                  child: Ink(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyColors.dnaGreen),
                                    child: Center(
                                      child: Text(
                                        "Simpan",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  _showBBPicker(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Berat'),
          content: Container(
            height: 350,
            width: 350.0,
            child: Column(
              children: <Widget>[
                Text('Kilogram'),
                Container(
                  height: MediaQuery.of(ctx).size.height / 4,
                  color: Colors.transparent,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1,
                    useMagnifier: true,
                    diameterRatio: 1,
                    scrollController: bbSelectController,
                    children: List<Widget>.generate(131, (int index) {
                      int i = index + 20;
                      return Center(
                        child: Text("$i"),
                      );
                    }),
                    onSelectedItemChanged: (i) {
                      _selectedValue = i + 20;
                      isEnabled = true ;
                    },
                  ),
                ),
                SizedBox(height: 40),
                CupertinoButton(
                  child: Text('OK'),
                  onPressed: () {
                    bbController.text = _selectedValue.toString();
                    print("VALUE ${bbController.text}");
                    isEnabled = true ;
                    Navigator.of(ctx).pop();
                    notifyListeners();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showTbPicker(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tinggi'),
          content: Container(
            height: 380,
            width: 350.0,
            child: Column(
              children: <Widget>[
                Text('Centimeter'),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  color: Colors.transparent,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1,
                    useMagnifier: true,
                    diameterRatio: 1,
                    scrollController: tbSelectController,
                    children: List<Widget>.generate(150, (int index) {
                      int i = index + 100;
                      return Center(
                        child: Text("$i"),
                      );
                    }),
                    onSelectedItemChanged: (i) {
                      _selectedValueTb = i + 100;
                      isEnabled = true ;
                      notifyListeners();
                    },
                  ),
                ),
                SizedBox(height: 50),
                CupertinoButton(
                  child: Text('OK'),
                  onPressed: () {
                    tbController.text = _selectedValueTb.toString();
                    print("VALUE ${bbController.text}");
                    isEnabled = true ;
                    Navigator.of(context).pop();
                    notifyListeners();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
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
    prov.getApiToken();
    String accessToken = prov.accessToken;
    String gambar = photo64Encode;
    notifyListeners();

    int accountid = prefs.getInt("userid");
    var url = AppConstants.UPDATE_PATIENT_CARD_URL + "$patienCardId";

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

  void showToastUpdatePhoto(
      BuildContext ctx, String title, String subtitle) async {
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
    prov.getApiToken();
    String accessToken = prov.accessToken;
    String gambar = photo64Encode;
    notifyListeners();

    print("PASI ID ==> $patienCardId");

    int accountid = prefs.getInt("userid");
    var url = AppConstants.UPDATE_PATIENT_CARD_URL + '$patienCardId';

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

    final request =
        await http.put(url, headers: header, body: json.encode(body));

    print("Status ==> ${request.statusCode}");

    if (sukses == true) {
      showToast(context, "Berhasil", "Data berhasil diupdate");
    } else {}
  }

  Future<void> updateBeratBadan(
      BuildContext context, String height, String weight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    prov.getApiToken();
    String accessToken = prov.accessToken;
    notifyListeners();

    print("PASI ID ==> $patienCardId");

    int accountid = prefs.getInt("userid");
    print(
        "account id untuk update patientcard $patienCardId, $accountId, $height, $weight");
    var url = AppConstants.UPDATE_PATIENT_CARD_URL + '$patienCardId';

    var body = {
      // "account_id": 14,
      // "height": "0",
      // "weight": "0"
      "account_id": accountid,
      "height": height,
      "weight": weight
    };

    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final response =
        await http.put(url, headers: header, body: json.encode(body));

    print("Status ==> ${response.body}");

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
        }
      },
    )..show();
  }
}
