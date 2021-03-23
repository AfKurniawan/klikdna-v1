import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/asuransi/widgets/asuransi_items_widget.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/card_insurance_item.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
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
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 140,
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
                    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 0),
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

                Container(
                  padding: EdgeInsets.only(top: 110),
                  child: Container(
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
                                  Image.asset("assets/images/ellipse_patient_card.png", height: 85),
                                ],

                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width /2.5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Consumer<PatientCardProvider>(
                                          builder: (context, model, _) {
                                            return InkWell(
                                              onTap: (){
                                                context.read<PatientCardProvider>().getImageV2(
                                                    context);
                                                print("TAKE PHOTO");
                                              },
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: model.image64Decode != null ?
                                                  Image.memory(
                                                    model.image64Decode,
                                                    width: 72,
                                                    fit: BoxFit.cover,
                                                    height: 72,
                                                    // height: 150,
                                                  ) :
                                                  Image.asset(
                                                      "assets/images/no_image.png",
                                                      height: 72,
                                                      width: 72,
                                                      fit: BoxFit.cover)
                                              ),
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
                                        onTap: (){
                                          context.read<PatientCardProvider>().getImageV2(
                                              context);
                                          print("TAKE PHOTO");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white30,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Icon(Icons.camera_alt,size: 15),
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

                              final value1 = values[0];
                              final value2 = values[1];
                              final value3 = values[2];
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
                                          Text(card.noKtp == null ? "-"  : "${card.noKtp}",
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
                                          Navigator.pushNamed(context, "asuransi_page");
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
                                                IconButton(
                                                  icon: Icon(Icons.arrow_forward_ios, color: MyColors.grey, size: 18),
                                                  onPressed: (){
                                                    Navigator.pushNamed(context, "asuransi_page");
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Consumer<PatientCardProvider>(
                                        builder: (context, prov, _){
                                          return prov.listAsuransi.length == 0
                                              ? Container(
                                              height: 210,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: Image.asset("assets/images/no_patient_card.png",
                                                          width: 180),
                                                    ),
                                                    Text("Belum ada Kartu Asuransi tersimpan",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                          : Container(
                                            height: 230,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: prov.listAsuransi.length == 0 ? 0 : prov.listAsuransi.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child: CardInssuranceItem(
                                                        model: prov.listAsuransi[index]),
                                                  );
                                                }),
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
                                          IconButton(
                                            icon: Icon(Icons.arrow_forward_ios, color: MyColors.grey, size: 18),
                                            onPressed: (){
                                              showModalGolonganDarah(context);
                                              Provider.of<TokenProvider>(context,listen: false).getApiToken();
                                            },
                                          )
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
                                            child: Center(
                                                child: Text(pcard.bloodTypeController.text == null ? "-" : "${pcard.bloodTypeController.text}")),
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
                                          IconButton(
                                            icon: Icon(Icons.arrow_forward_ios, color: MyColors.grey, size: 18),
                                            onPressed: (){
                                              showModalEditing(context, pcard.medicalProfController, "Medical Professsional", "Medical Professsional", "Maks. 30 Karakter", TextInputType.text);
                                            },
                                          )
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
                                            child: Center(child: Text(pcard.medicalProfController.text == null ? "-" : "${pcard.medicalProfController.text}")),
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
                                          IconButton(
                                            icon: Icon(Icons.arrow_forward_ios, color: MyColors.grey, size: 18),
                                            onPressed: (){
                                              showModalEditing(context, pcard.emergencyContactController, "Kontak Darurat", "Kontak Darurat", "Maks. 13 Karakter", TextInputType.phone);
                                            },
                                          )
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
                                            child: GestureDetector(
                                              child: Center(
                                                  child: Text(pcard.emergencyContactController.text == null ? "-" : "${pcard.emergencyContactController.text}",
                                                    style: TextStyle(
                                                      decoration: TextDecoration.underline,
                                                      color: Colors.blue
                                                    ),
                                                  )),
                                              onTap: (){
                                                Provider.of<PatientCardProvider>(context, listen: false).callKontakDarurat(context, pcard.emergencyContactController.text);
                                              },
                                            ),
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
                                          IconButton(
                                            icon: Icon(Icons.arrow_forward_ios, color: MyColors.grey, size: 18),
                                            onPressed: (){
                                              showModalEditing(context, pcard.comorbidityController, "Komorbiditas", "Komorbiditas", "Maks. 30 Karakter", TextInputType.text);
                                            },
                                          )
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
                                            child: Center(child: Text(pcard.comorbidityController.text == null ? "-" : "${pcard.comorbidityController.text}")),
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
                  top: 50,
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
                ),

              ],
            ),
          ),
        );
      },
    );
  }


  void showModalEditing(BuildContext context, TextEditingController textController, String tittle, String hint, String maxChar, TextInputType inputType){
    var prov = Provider.of<PatientCardProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) {
        return Scaffold(
          body: Container(
            child: Container(
                height: MediaQuery.of(context).size.height - 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 40),
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.grey),
                            onPressed: (){
                          Navigator.of(context).pop();
                            }),
                        SizedBox(width: 20),
                        Text("$tittle", style: TextStyle(fontSize: 14))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: FormWidget(
                      hint: "$hint",
                      obscure: false,
                      textEditingController: textController,
                      keyboardType: inputType,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text("$maxChar"),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ButtonWidget(
              btnText: "Simpan",
              btnAction: (){
                prov.updatePatientCard(context);
              },
              height: 50,
              color: MyColors.dnaGreen,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(golonganDarah[index],
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text(descGolonganDarah[index],
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    Provider.of<PatientCardProvider>(context, listen: false).setRhesus(context, golonganDarah[index]);
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
