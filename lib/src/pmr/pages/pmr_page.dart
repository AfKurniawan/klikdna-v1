
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Consumer<PMRProvider>(
      builder: (context, prov, _){
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Container(
                color: MyColors.dnaGreen,
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/no_image.png'),
                          radius: 35,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Hai", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300)
                          ),

                          Text(
                              "${prov.firstname } ${prov.lastname}" == null ? "" : "${prov.firstname } ${prov.lastname}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                //padding: EdgeInsets.only(top: 140),
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.of(context).pushNamed("patient_card_page");
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
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
                                Text("Kartu Pasien")
                              ],
                            ),

                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed("food_meter_page");
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
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
                                Text("Food Meter")
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
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
