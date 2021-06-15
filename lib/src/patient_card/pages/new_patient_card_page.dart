import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/card_insurance_item.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:new_klikdna/widgets/loading_widget.dart';
import 'package:new_klikdna/widgets/outline_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPatientCardPage extends StatefulWidget {
  @override
  _NewPatientCardPageState createState() => _NewPatientCardPageState();
}

class _NewPatientCardPageState extends State<NewPatientCardPage> {
  bool isExpanded = false;
  String choice;
  String gender;
  String pcardName;
  String pcardKtp;

  @override
  void initState() {
    getPrefs();
    Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
    Provider.of<PatientCardProvider>(context, listen: false).getPatientCard(context);
    Provider.of<MitraProvider>(context, listen: false).refreshMitraData();
    Provider.of<AsuransiProvider>(context, listen: false).checkLastId(context);
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      gender = prefs.getString("gender");
      pcardName = Provider.of<MitraProvider>(context, listen: false).vallName;
      pcardKtp = Provider.of<MitraProvider>(context, listen: false).vnik;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MitraProvider>(
      builder: (context, prov, _) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Stack(
                children: <Widget>[
                  buildHeader(),
                  Container(
                    padding: EdgeInsets.only(top: 110),
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          color: MyColors.backgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        children: [
                          Consumer<PatientCardProvider>(
                            builder: (context, card, _) {
                              final name = '$pcardName';
                              final split = name.split(' ');
                              final Map<int, String> values = {
                                for (int i = 0; i < split.length; i++)
                                  i: split[i]
                              };

                              final value1 = values[0];
                              final value2 = values[1];
                              return Container(
                                height: 146,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          height: 100,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Image.asset(
                                                      "assets/images/ellipse_patient_card.png",
                                                      height: 85)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: 100,
                                            width: MediaQuery.of(context).size.width / 3,
                                            child: PhotoPatientCardWidget()),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width / 3,
                                              height: 100,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                      top: 12,
                                                      right: 12,
                                                      child: Image.asset(
                                                          "assets/images/logo.png",
                                                          height: 26,
                                                          width: 19)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          child: Column(
                                            children: [
                                              Text("Nama",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: "Roboto")),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                value2.length > 1
                                                    ? "$value1 ${value2.substring(0, 1)}"
                                                    : value1,
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Roboto"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          child: Column(
                                            children: [
                                              Text("Nomor KTP",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: "Roboto")),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                pcardKtp == null
                                                    ? "-"
                                                    : "$pcardKtp",
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width / 3,
                                          child: Column(
                                            children: [
                                              Text("Jenis Kelamin",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: "Roboto")),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                card.gender == "male"
                                                    ? "Laki-Laki"
                                                    : "Perempuan",
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),

                          /// Kertu ASURA
                          Container(
                            color: Colors.white,
                            child: Consumer<PatientCardProvider>(
                              builder: (context, pcard, _) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "asuransi_page");
                                      },
                                      splashColor: Colors.grey,
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.black12),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Kartu Asuransi",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              IconButton(
                                                icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: MyColors.grey,
                                                    size: 18),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, "asuransi_page");
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Consumer<PatientCardProvider>(
                                      builder: (context, prov, _) {
                                        return prov.isMuter == true ?
                                        Container(
                                          height: 100,
                                            child: LoadingWidget())
                                          : prov.listAsuransi.length == 0
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 150,
                                                      child: Image.asset(
                                                          "assets/images/no_patient_card.png"),
                                                    ),
                                                    Text(
                                                        "Belum ada Kartu Asuransi tersimpan",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14)),
                                                    SizedBox(height: 12),
                                                    Text(
                                                      "Yuk, tambah kartu asuransi kamu agar lebih mudah saat melihat data yang disimpan",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 12),
                                                    ),
                                                    SizedBox(height: 16),
                                                    OutlineButtonWidget(
                                                      outlineColor: MyColors.dnaGreen,
                                                      btnText: Text("Tambah Kartu Asuransi",
                                                          style: TextStyle(
                                                              color: MyColors.dnaGreen,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 14
                                                          )),
                                                      btnAction: () {
                                                        Navigator.pushNamed(context, "add_asuransi_page");
                                                      },
                                                      outlineTextColor:
                                                          MyColors.dnaGreen,
                                                      height: 46,
                                                    ),
                                                    SizedBox(height: 10),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                height: 180,
                                                child: Center(
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: prov.listAsuransi.length == 0
                                                          ? 0
                                                          : prov.listAsuransi.length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          width: MediaQuery.of(
                                                                  context).size.width,
                                                          child: CardInssuranceItem(
                                                              model:
                                                                  prov.listAsuransi[
                                                                      index]),
                                                        );
                                                      }),
                                                ),
                                              );
                                      },
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),

                          /// GOLOGAN DARAH
                          Container(
                            color: Colors.white,
                            child: Consumer<PatientCardProvider>(
                              builder: (context, pcard, _) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  width: 180,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      color: MyColors.dnaGreen,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: Text(
                                                        "Golongan Darah",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white)),
                                                  )),
                                              IconButton(
                                                icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: MyColors.grey,
                                                    size: 18),
                                                onPressed: () {
                                                  showModalGolonganDarah(
                                                      context);
                                                  Provider.of<TokenProvider>(
                                                          context,
                                                          listen: false)
                                                      .getApiToken();
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            blurRadius: 3,
                                            color: Colors.grey[700]
                                                .withOpacity(0.32),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Center(
                                            child: Text(pcard
                                                        .bloodTypeController
                                                        .text ==
                                                    null
                                                ? "Tambahkan disini.."
                                                : "${pcard.bloodTypeController.text}")),
                                      ),
                                      height: 70,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: 180,
                                            height: 34,
                                            decoration: BoxDecoration(
                                                color: MyColors.dnaGreen,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text(
                                                  "Medical Professional",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white)),
                                            )),
                                        IconButton(
                                          icon: Icon(Icons.arrow_forward_ios,
                                              color: MyColors.grey, size: 18),
                                          onPressed: () {
                                            showModalEditing(
                                                context,
                                                pcard.medicalProfController,
                                                "Medical Professsional",
                                                "Medical Professsional",
                                                "Maks. 30 Karakter",
                                                "Medical Professional",
                                                TextInputType.text);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 16.0, right: 16),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              color: Colors.grey[700]
                                                  .withOpacity(0.32),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(28.0),
                                          child: Center(
                                              child: Text(pcard.medicalProfController.text == null
                                                  ? "Tambahkan disini.."
                                                  : "${pcard.medicalProfController.text}")),
                                        )),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: MyColors.dnaGreen,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text("Kontak Darurat",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white)),
                                            )),
                                        IconButton(
                                          icon: Icon(Icons.arrow_forward_ios,
                                              color: MyColors.grey, size: 18),
                                          onPressed: () {
                                            showModalEditing(
                                                context,
                                                pcard
                                                    .emergencyContactController,
                                                "Kontak Darurat",
                                                "Kontak Darurat",
                                                "Maks. 13 Karakter",
                                                "Kontak Darurat",
                                                TextInputType.numberWithOptions(signed: true, decimal: false));
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 12.0, right: 12),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              color: Colors.grey[700]
                                                  .withOpacity(0.32),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: GestureDetector(
                                            child: Center(
                                                child: pcard.emergencyContactController.text == null || pcard.emergencyContact == null ?
                                                Text("Tambahkan disini..", style: TextStyle(
                                                  color: Colors.black38
                                                ))
                                                  : Text ("${pcard.emergencyContactController.text}",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.blue),
                                            )),
                                            onTap: () {
                                              Provider.of<PatientCardProvider>(
                                                      context,
                                                      listen: false)
                                                  .callKontakDarurat(
                                                      context,
                                                      pcard
                                                          .emergencyContactController
                                                          .text);
                                            },
                                          ),
                                        )),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: 180,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: MyColors.dnaGreen,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text("Komorbiditas",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white)),
                                            )),
                                        IconButton(
                                          icon: Icon(Icons.arrow_forward_ios,
                                              color: MyColors.grey, size: 18),
                                          onPressed: () {
                                            showModalEditing(
                                                context,
                                                pcard.comorbidityController,
                                                "Komorbiditas",
                                                "Komorbiditas",
                                                "Maks. 30 Karakter",
                                                "Komorbiditas",
                                                TextInputType.text);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 12.0, right: 12),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              color: Colors.grey[700]
                                                  .withOpacity(0.32),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Center(
                                              child: Text(pcard
                                                          .comorbidityController
                                                          .text ==
                                                      null
                                                  ? "Tambahkan disini.."
                                                  : "${pcard.comorbidityController.text}")),
                                        )),
                                    SizedBox(height: 20),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  buildBackButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Positioned buildBackButton(BuildContext context) {
    return Positioned(
      left: 20,
      top: 50,
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, 'health_meter_page');
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 8, top: 10, bottom: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black45,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Container buildHeader() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
          color: MyColors.dnaGreen,
          image: DecorationImage(
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  MyColors.dnaGreen.withOpacity(0.3), BlendMode.dstIn),
              image: AssetImage("assets/images/header_background.png"))),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "Kartu Pasien",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModalEditing(
      BuildContext context,
      TextEditingController textController,
      String title,
      String hint,
      String maxChar,
      String appbarTitle,
      TextInputType inputType) {
    var prov = Provider.of<PatientCardProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) {
        return Container(
          height: MediaQuery.of(context).size.height / 1,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24))),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios, size: 20),
                      ),

                      Text(
                        "$appbarTitle",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),

                    ],
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: FormWidget(
                      hint: "$hint",
                      obscure: false,
                      textEditingController: textController,
                      keyboardType: inputType,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text("$maxChar"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonWidget(
                      btnText: "Simpan",
                      btnAction: () {
                        prov.updatePatientCard(context);
                      },
                      height: 50,
                      color: MyColors.dnaGreen,
                    ),
                  ),
                ],
              ),
          ),
        );
      },
      isScrollControlled: true,
    );
  }

  List<String> golonganDarah = [
    "O(I)Rh+",
    "O(I)Rh-",
    "A(II)Rh+",
    "A(II)Rh-",
    "B(III)Rh+",
    "B(III)Rh-",
    "AB(IV)Rh+",
    "AB(IV)Rh-"
  ];

  List<String> descGolonganDarah = [
    "First blood type, Rh positive",
    "First blood type, Rh negative",
    "Second blood type, Rh positive",
    "Second blood type, Rh negative",
    "Third blood type, Rh positive",
    "Third blood type, Rh negative",
    "Fourth blood type, Rh positive",
    "Fourth blood type, Rh negative"
  ];

  void showModalGolonganDarah(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.4,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Golongan Darah",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                    ),
                    Row(
                      children: [
                        Text("Batalkan"),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.clear),
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.center,
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemCount:
                            golonganDarah == null ? 0 : golonganDarah.length,
                        separatorBuilder: (context, int) {
                          return Divider();
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(golonganDarah[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    Text(descGolonganDarah[index],
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    Provider.of<PatientCardProvider>(context,
                                            listen: false)
                                        .setRhesus(
                                            context, golonganDarah[index]);
                                  });
                                }),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class PhotoPatientCardWidget extends StatelessWidget {
  const PhotoPatientCardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Consumer<PatientCardProvider>(
                builder: (context, model, _) {
                  return InkWell(
                    onTap: () {
                      context.read<PatientCardProvider>().getImageV2(context);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: model.image64Decode != null
                            ? Image.memory(
                                model.image64Decode,
                                width: 72,
                                fit: BoxFit.cover,
                                height: 72,
                                // height: 150,
                              )
                            : Image.asset("assets/images/no_image.png",
                                height: 72, width: 72, fit: BoxFit.cover)),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
            right: 30,
            top: 62,
            child: InkWell(
              onTap: () {
                context.read<PatientCardProvider>().getImageV2(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.camera_alt, size: 15),
                  )),
            )),
      ],
    );
  }
}
