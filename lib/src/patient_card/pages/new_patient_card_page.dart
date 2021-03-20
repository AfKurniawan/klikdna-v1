import 'package:flutter/material.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class NewPatientCardPage extends StatefulWidget {
  @override
  _NewPatientCardPageState createState() => _NewPatientCardPageState();
}

class _NewPatientCardPageState extends State<NewPatientCardPage> {


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
                            MyColors.dnaGreen.withOpacity(0.2),
                            BlendMode.dstATop),
                        image: AssetImage(
                            "assets/images/header_background.png"))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 18, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        child: Text("${prov.vallName}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      SizedBox(width: 30),

                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 140),
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Personal Medical Report",
                            style: TextStyle(
                                fontSize: 14
                            )),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.of(context).pushNamed("patient_card_page");
                                  },
                                  child: Container(
                                    height: 86,
                                    width: 86,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(1, 4),
                                          blurRadius: 10,
                                          color: Color(0xFFB0CCE1).withOpacity(0.62),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                          "assets/icons/patient_card_icon.png",
                                          height: 35,
                                          width: 35,
                                        )),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text("Kartu Pasien",
                                  style: TextStyle(
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 24),
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed("food_meter_page");
                                  },
                                  child: Container(
                                    height: 86,
                                    width: 86,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(1, 4),
                                          blurRadius: 10,
                                          color: Color(0xFFB0CCE1).withOpacity(0.62),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                          "assets/icons/food_meter_icon.png",
                                          height: 35,
                                          width: 35,
                                        )),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text("Food Meter",
                                  style: TextStyle(
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 70,
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, 'health_meter_page');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                       Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 15,
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
