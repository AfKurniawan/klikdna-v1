import 'package:flutter/material.dart';
import 'package:new_klikdna/src/report/widgets/button_icon_widget.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_and_icon_widget.dart';
import 'package:new_klikdna/widgets/custom_shadow_card_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:new_klikdna/widgets/outline_button_widget.dart';

class NewFoodMeterPage extends StatefulWidget {
  @override
  _NewFoodMeterPageState createState() => _NewFoodMeterPageState();
}

class _NewFoodMeterPageState extends State<NewFoodMeterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Food Meter",
          style: TextStyle(
            fontFamily: "Roboto",
            color: MyColors.blackPrimary,
              fontWeight: FontWeight.w700,
            fontSize: 16
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset("assets/images/logo.png", width: 19),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormWidget(
                hint: "Cari makanan, minuman atau restauran",
                obscure: false,
                labelText: "Cari makanan, minuman atau restauran",
                prefixIcon: Icon(Icons.search),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButtonWidget(
                      btnAction: (){},
                      height: 40,
                      outlineColor: MyColors.dnaGreen,
                      btnTextColor: MyColors.dnaGreen,
                      width: MediaQuery.of(context).size.width / 2.3,
                      myIcon: Icons.mic,
                      iconColor: MyColors.dnaGreen,
                      btnText: Text(
                        "Voice Search",
                        style: TextStyle(
                          color: MyColors.dnaGreen
                        ),
                      )),
                  ButtonAndIconWidget(
                      btnAction: (){},
                      height: 40,
                      widht: MediaQuery.of(context).size.width / 2.3,
                      color: MyColors.dnaGreen,
                      myIcon: Image.asset("assets/icons/scan_icon.png"),
                      btnText: "Pindai"),
                ],
              ),
              SizedBox(height: 20),
              CustomShadowCardWidget(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                          color: Color(0xffA5FFB9),
                            borderRadius: BorderRadius.circular(50),
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Center(
                                  child: Image.asset("assets/icons/burger_icon.png", height: 32)),
                            )),
                        SizedBox(height: 8),
                        Text("Makanan",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 58),
                    Column(
                      children: [
                        Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Color(0xffAAE6FF),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Center(
                                  child: Image.asset("assets/icons/drinks_icon.png", height: 32)),
                            )),
                        SizedBox(height: 8),
                        Text("Minuman",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 58),
                    Column(
                      children: [
                        Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Color(0xffFFA3A3),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Center(
                                  child: Image.asset("assets/icons/drinks_icon.png", height: 32)),
                            )),
                        SizedBox(height: 8),
                        Text("Restaurant",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 27),
              Text("Terakhir Dilihat",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto"
                )
              ),
              SizedBox(height: 14),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CustomShadowCardWidget(
                      width: MediaQuery.of(context).size.width /2.5,
                      height: 93,
                      margin: EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Indomie Goreng"),
                          SizedBox(height: 4),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFD6A5),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text("kkal",
                                  style: TextStyle(
                                    fontSize: 10,
                                  )),
                                  SizedBox(width: 16),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFCFF9B),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text("Protein",
                                      style: TextStyle(
                                        fontSize: 10,
                                      ))
                                ],
                              ),

                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


