import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/asuransi/widgets/asuransi_items_widget.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/card_insurance.dart';
import 'package:new_klikdna/styles/my_colors.dart';
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

  @override
  void initState() {
    getPrefs();
    Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
    Provider.of<PatientCardProvider>(context, listen: false).getPatientCard(context);
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      gender = prefs.getString("gender");
    });

    debugPrint("GENDER >>>>>>>>>>>> $gender");

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MitraProvider>(
      builder: (context, prov, _){
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Container(
                height: 160,
                decoration: BoxDecoration(
                    color: MyColors.dnaGreen,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(
                            MyColors.dnaGreen.withOpacity(0.3),
                            BlendMode.dstIn),
                        image: AssetImage(
                            "assets/images/header_background.png"))),

                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text("Kartu Pasien",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 140),
                child: Container(
                 // padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),

                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Image.asset("assets/images/ellipse_patient_card.png", height: 100),

                              ],

                            ),
                            Stack(
                              children: [
                                Container(
                                  child: Container(
                                   // color: Colors.blue,
                                    width: MediaQuery.of(context).size.width /2.8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Consumer<PatientCardProvider>(
                                          builder: (context, model, _) {
                                            return ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: model.photoView == null ?
                                                Image.asset("assets/images/no_image.png", height: 75, width: 75, fit: BoxFit.cover)
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
                                  ),
                                ),
                                Positioned(
                                    right: 30,
                                    top: 55,
                                    child: InkWell(
                                      onTap: (){
                                        print("SEMMM");
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(Icons.edit,size: 15),
                                          )),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Consumer<AccountProvider>(
                          builder: (context, card, _){
                            final name = '${card.name}';
                            final split = name.split(' ');
                            final Map<int, String> values = {
                              for (int i = 0; i < split.length; i++)
                                i: split[i]
                            };
                            print(values);  // {0: grubs, 1:  sheep}

                            final value1 = values[0];
                            final value2 = values[1];
                            final value3 = values[2];
                            print(value1);  // grubs
                            print(value2);  //  sheep
                            print(value3);
                            return Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Text("Nama", style: TextStyle(
                                          fontSize: 12
                                        )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(value2.length > 1 ? "$value1 ${value2.substring(0, 1)}" : value1,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text("Nomor KTP", style: TextStyle(
                                            fontSize: 12
                                        )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("${card.noKtp}",
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Text("Jenis Kelamin", style: TextStyle(
                                            fontSize: 12
                                        )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(card.accountgender == "male"? "Laki-Laki" : "Perempuan",
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 10,
                          color: Colors.grey[100],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            child: Consumer<PatientCardProvider>(
                              builder: (context, pcard, _){
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        print("To Detail");
                                      },
                                      splashColor: Colors.grey,
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Colors.black12
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Kartu Asuransi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Consumer<PatientCardProvider>(
                                      builder: (context, prov, _){
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            height: 200,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: prov.listAsuransi.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return CardInssurance(
                                                      model: prov.listAsuransi[index]);
                                                }),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                            width: 200,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: MyColors.dnaGreen,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text("Golongan Darah",
                                                  style: TextStyle(fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                            )),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        margin: EdgeInsets.only(left: 8.0),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              color: Colors.grey[700].withOpacity(0.32),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Center(child: Text(pcard.bloodType)),
                                        )),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: 200,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: MyColors.dnaGreen,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    bottomRight: Radius.circular(20))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text("Medical Professional",
                                                  style: TextStyle(fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white)),
                                            )),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      margin: EdgeInsets.only(left: 8.0),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              color: Colors.grey[700].withOpacity(0.32),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Center(child: Text(pcard.medicalProfesional)),
                                        )),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: 200,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: MyColors.dnaGreen,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    bottomRight: Radius.circular(20))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text("Kontak Darurat",
                                                  style: TextStyle(fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white)),
                                            )),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        margin: EdgeInsets.only(left: 8.0),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              color: Colors.grey[700].withOpacity(0.32),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Center(child: Text(pcard.emergencyContact)),
                                        )),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: 200,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: MyColors.dnaGreen,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    bottomRight: Radius.circular(20))
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text("Komorbiditas",
                                                  style: TextStyle(fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white)),
                                            )),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                        margin: EdgeInsets.only(left: 8.0),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 3,
                                              color: Colors.grey[700].withOpacity(0.32),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Center(child: Text("${pcard.comorbidity}")),
                                        )),
                                    SizedBox(height: 20),

                                  ],
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 65,
                child: InkWell(
                  onTap: (){
                   // Navigator.pushNamed(context, 'health_meter_page');
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:12.0, right:8, top: 10, bottom: 10),
                      child: Icon(
                       Icons.arrow_back_ios,
                        color: Colors.black45,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
