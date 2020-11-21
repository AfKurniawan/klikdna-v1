import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
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

  @override
  void initState() {
    Provider.of<PatientCardProvider>(context, listen: false).getPatientCard(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  final account = Provider.of<AccountProvider>(context, listen: false);
    return Consumer<PatientCardProvider>(
      builder: (context, prov, _){
        return Scaffold(
          //backgroundColor: Colors.grey[100],
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                "Kartu Pasien",
                style: TextStyle(color: Colors.grey, fontSize: 16),
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
                  child: Text("Ubah Kartu Pasien", style: TextStyle(color: MyColors.dnaGreen)),
                  onPressed: (){
                    Navigator.pushNamed(context, "edit_patient_card_page");
                  },
                )
              ],
            ),
            body: prov.isLoading == true ?
            Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(strokeWidth: 2))
               : account.isError == true || account.listPatentCard.length == 0 ? Center(child: Text("Anda tidak memiliki Kartu Pasien"))
                : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
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
                          Consumer<PatientCardProvider>(
                            builder: (context, model, _) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: model.photoView == null ?
                                  Image.asset("assets/images/no_image.png", height: 100, width: 100, fit: BoxFit.cover)
                                      : Image.memory(
                                    model.photoView,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    // height: 150,
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
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
                          Text(prov.nama == null ? "-" : "${prov.nama}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("Nomor KTP"),
                          SizedBox(height: 10),
                          Text(prov.noKtp == null ? "-" : prov.noKtp, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Kartu Asuransi"),
                              GestureDetector(
                                child: Text("Lihat Semua", style: TextStyle(color: MyColors.dnaGreen)),
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
                              Text("-", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          Text(prov.bloodType == null ? "-" : prov.bloodType, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
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
                          Text("Jenis Kelamin"),
                          SizedBox(height: 10),
                          Text(prov.gender == null ? "-"  : prov.gender == "male" ? "Pria" : prov.gender == "female" ? "Wanita"
                              : prov.gender,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
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
                          Text(prov.medicalProfesional == null ? "-" : prov.medicalProfesional, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("Emergency Contact"),
                          SizedBox(height: 10),
                          Text(prov.emergencyContact == null ? "-" : prov.emergencyContact, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("Comorbidity"),
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
