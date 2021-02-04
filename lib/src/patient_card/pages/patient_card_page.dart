import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/asuransi_item.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class PatientCardPage extends StatefulWidget {
  @override
  _PatientCardPageState createState() => _PatientCardPageState();
}

class _PatientCardPageState extends State<PatientCardPage> {

  bool isExpanded = false;
  String result;
  String _radioValue;

  void _handleRadioValueChange(String value) {

    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case "Laki-Laki":
          result = "L";
          break;
        case "Wanita":
          result = "W";
          break;
      }
    });
  }


  @override
  void initState() {
    Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
    Provider.of<PatientCardProvider>(context, listen: false).getPatientCard(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PatientCardProvider>(
      builder: (context, prov, _){
        return Scaffold(
          //backgroundColor: Colors.grey[100],
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                "Kartu Pasien",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: MyColors.dnaGrey,
                    size: 20,
                  ),
                  onPressed: () {
                    //Navigator.pushReplacementNamed(context, "detail_report_page");
                    Navigator.of(context).pop();
                  }),
              actions: [
                FlatButton(
                  child: Text("Ubah Kartu Pasien", style: TextStyle(color: MyColors.dnaGreen, fontSize: 12)),
                  onPressed: (){
                    Navigator.pushNamed(context, "edit_patient_card_page");
                  },
                )
              ],
            ),
            body: prov.isMuter == true
                ? Center(child: SpinKitDoubleBounce(color: Colors.grey))
                : Provider.of<AccountProvider>(context, listen: false).listPatentCard.length == 0
                ? Center(child: Text("Anda belum memiliki Kartu Pasien"))
                : SingleChildScrollView (
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 94,
                    decoration: BoxDecoration(
                        color: MyColors.dnaGreen,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: new ColorFilter.mode(
                                MyColors.dnaGreen.withOpacity(0.2),
                                BlendMode.dstATop),
                            image: AssetImage(
                                "assets/images/header_background.png"))),
                    child: Center(
                      child: Consumer<PatientCardProvider>(
                        builder: (context, model, _) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: model.photoView == null ?
                              Image.asset("assets/images/no_image.png", height: 62, width: 62, fit: BoxFit.cover)
                                  : Image.memory(
                                model.photoView,
                                width: 62,
                                fit: BoxFit.cover,
                                height: 62,
                                // height: 150,
                              ));
                        },
                      ),
                    ),
                  ),

                  Consumer<LoginProvider>(
                    builder: (child, login, _){
                      return Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama"),
                              SizedBox(height: 10),
                              Text(login.vallName == null ? "-" : "${login.vallName}",
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(height: 20),
                              Text("Nomor KTP"),
                              SizedBox(height: 10),
                              Text(prov.noKtp == null ? "-" : prov.noKtp,
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Kartu Asuransi"),
                                  GestureDetector(
                                    child: Text( prov.listAsuransi.length == 0 ? "" : "Lihat Semua", style: TextStyle(color: MyColors.dnaGreen)),
                                    onTap: (){
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
                                  Text("-", style: TextStyle(fontSize: 14)),
                                ],
                              )
                                  : Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
                                      title: Text(prov.listAsuransi[0].nomorAsuransi, style: TextStyle(
                                          color: isExpanded ? MyColors.dnaGreen : Colors.black, fontSize: 14
                                      )),
                                      onExpansionChanged: (bool expanding) => setState(() => this.isExpanded = expanding),
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10, right: 18, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Golongan Darah"),
                          SizedBox(height: 10),
                          Text(prov.bloodType == null ? "-" : prov.bloodType,
                              style: TextStyle(fontSize: 14))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Consumer<PatientCardProvider>(
                    builder: (child, pcard, _){
                      return Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 10, right: 18, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jenis Kelamin"),
                              SizedBox(height: 10),
                              Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.grey,
                                    disabledColor: MyColors.dnaGreen
                                ),
                                child: Row(
                                  children: [
                                    Radio(
                                      value: "male",
                                      onChanged: _handleRadioValueChange,
                                      groupValue: pcard.gender,
                                      focusColor: MyColors.dnaGreen,
                                      activeColor: MyColors.dnaGreen,
                                    ),
                                    Text("Pria"),
                                    SizedBox(width: 20),
                                    Radio(
                                      value: "female",
                                      groupValue: pcard.gender,
                                      onChanged: _handleRadioValueChange,
                                      focusColor: MyColors.dnaGreen,
                                      activeColor: MyColors.dnaGreen,

                                    ),
                                    Text("Wanita")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 10, right: 18, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Medical Profesional"),
                          SizedBox(height: 10),
                          Text(prov.medicalProfesional == null ? "-" : prov.medicalProfesional,
                              style: TextStyle(fontSize: 14)),
                          SizedBox(height: 20),
                          Text("Kontak Darurat"),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: (){
                              Provider.of<PatientCardProvider>(context, listen: false).callKontakDarurat(context, prov.emergencyContact);
                            },
                              child: Text(prov.emergencyContact == null ? "-" : prov.emergencyContact, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                          SizedBox(height: 20),
                          Text("Komorbiditas"),
                          SizedBox(height: 10),
                          Text(prov.comorbidity == null ? "-" : prov.comorbidity, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

        );
      },
    );
  }
}
