
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/pmr/providers/pmr_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class PMRPage extends StatefulWidget {


  @override
  _PMRPageState createState() => _PMRPageState();
}

class _PMRPageState extends State<PMRPage> {

  @override
  void initState() {
    Provider.of<PMRProvider>(context, listen: false).getName();
    super.initState();
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
                height: 110,
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
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text("${prov.vallName}",
                              style: TextStyle(
                                color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(width: 30),

                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 90),
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
                                    Navigator.of(context).pushNamed("new_patient_card_page");
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
              // Positioned(
              //   right: 20,
              //   top: 70,
              //   child: InkWell(
              //     onTap: (){
              //       Navigator.pushNamed(context, 'health_meter_page');
              //     },
              //     child: Icon(
              //       Icons.watch,
              //       color: Colors.white,
              //       size: 30,
              //     ),
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }
}
