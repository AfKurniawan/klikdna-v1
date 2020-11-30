import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/asuransi_item.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:provider/provider.dart';

class EditPatientCardPage extends StatefulWidget {
  @override
  _EditPatientCardPageState createState() => _EditPatientCardPageState();
}

class _EditPatientCardPageState extends State<EditPatientCardPage> {
  String _radioValue;
  String result;
  final format = DateFormat("yyyy-MM-dd");

  void _handleRadioValueChange(String value) {

    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case "Male":
          result = "L";
          break;
        case "Female":
          result = "W";
          break;
      }
    });
  }

  @override
  void initState() {
    _radioValue = Provider
        .of<PatientCardProvider>(context, listen: false)
        .gender;
    print("RADIO VALUE: $_radioValue");
    Provider.of<PatientCardProvider>(context, listen: false).getPatientCard(
        context);
    super.initState();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PatientCardProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Data Diri",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 20,
            ),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, "detail_report_page");
              Navigator.of(context).pop();
            }),
        actions: [
        ],
      ),
      body: prov.isLoading == true
          ? Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator(strokeWidth: 2))
          : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 4,
              decoration: BoxDecoration(
                  color: MyColors.dnaGreen,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      colorFilter: new ColorFilter.mode(
                          MyColors.dnaGreen.withOpacity(0.2),
                          BlendMode.dstATop),
                      image: AssetImage(
                          "assets/images/header_background.png"))),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(
                      //           color: Colors.white, width: 2)),
                      //   child: CircleAvatar(
                      //     backgroundImage: _image == null
                      //         ? AssetImage('assets/images/no_image.png')
                      //         : (_image),
                      //     radius: 40,
                      //   ),
                      // ),
                      Consumer<PatientCardProvider>(
                        builder: (context, model, _) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: model.image64Decode != null ?
                              Image.memory(
                                model.image64Decode,
                                width: 100,
                                fit: BoxFit.cover,
                                height: 100,
                                // height: 150,
                              ) :
                              Image.asset(
                                  "assets/images/no_image.png", height: 100,
                                  width: 100,
                                  fit: BoxFit.cover)


                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            context.read<PatientCardProvider>().getImageV2(
                                context);
                            print("TAKE PHOTO");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(Icons.edit, size: 20),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FormWidget(
                    hint: "",
                    obscure: false,
                    labelText: "Nama",
                    textEditingController: prov.namaController,
                    labelStyle: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 15),
                  FormWidget(
                    hint: "",
                    obscure: false,
                    labelText: "Nomor KTP",
                    textEditingController: prov.noKtpController,
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kartu Asuransi"),
                      GestureDetector(
                        child: Text(
                            "Lihat Semua", style: TextStyle(color: MyColors
                            .dnaGreen)),
                        onTap: () {
                          Navigator.of(context).pushNamed("asuransi_page");
                        },
                      )
                    ],
                  ),
                  prov.listAsuransi.length == 0 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("-", style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold))),
                    ],
                  )
                      : Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent),
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1,
                              color: MyColors.grey
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: ExpansionTile(
                          title: Text(prov.listAsuransi[0].nomorAsuransi,
                              style: TextStyle(
                                  color: isExpanded ? MyColors.dnaGreen : Colors
                                      .black, fontSize: 14
                              )),
                          onExpansionChanged: (bool expanding) =>
                              setState(() => this.isExpanded = expanding),
                          tilePadding: EdgeInsets.only(left: 0, top: 0),
                          children: [
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: prov.listAsuransi.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return AsuransiItemWidget(
                                      model: prov.listAsuransi[index]);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // FormWidget(
                  //   hint: "",
                  //   obscure: false,
                  //   labelText: "Kartu Asuransi",
                  //   textEditingController: prov.insuranceCardController,
                  //   labelStyle: TextStyle(fontSize: 16),
                  // ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      showModalGolonganDarah(context);
                    },
                    child: AbsorbPointer(
                      child: FormWidget(
                        obscure: false,
                        labelText: "Golongan Darah",
                        textEditingController: prov.bloodTypeController,
                        labelStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jenis Kelamin"),
                      Row(
                        children: [
                          Radio(
                            value: "male",
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                            focusColor: MyColors.dnaGreen,
                            activeColor: MyColors.dnaGreen,
                          ),
                          Text("Pria"),
                          SizedBox(width: 20),
                          Radio(
                            value: "female",
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                            focusColor: MyColors.dnaGreen,
                            activeColor: MyColors.dnaGreen,
                          ),
                          Text("Wanita")
                        ],
                      ),
                      SizedBox(height: 15),
                      FormWidget(
                        hint: "",
                        obscure: false,
                        labelText: "Medical Professional",
                        textEditingController: prov.medicalProfController,
                        labelStyle: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      FormWidget(
                        hint: "",
                        obscure: false,
                        labelText: "Emergency Contact",
                        textEditingController: prov.emergencyContactController,
                        labelStyle: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      FormWidget(
                        hint: "",
                        obscure: false,
                        labelText: "Comorbidity",
                        textEditingController: prov.comorbidityController,
                        labelStyle: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      ButtonWidget(
                        btnAction: () {
                          prov.updatePatientCard(context, _radioValue);
                        },
                        btnText: "Lanjutkan",
                        height: 50,
                        color: MyColors.dnaGreen,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  void showModalGolonganDarah(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 1.4,
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
                          child: Text("Golongan Darah", style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),)),
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
                                child: Text(golonganDarah[index],
                                    style: TextStyle(fontSize: 16)),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    Provider.of<PatientCardProvider>(
                                        context, listen: false).setRhesus(
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
        }
    );
  }
}
