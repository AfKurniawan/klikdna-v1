import 'package:flutter/material.dart';
import 'package:new_klikdna/src/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/src/report/widgets/button_icon_widget.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_and_icon_widget.dart';
import 'package:new_klikdna/widgets/custom_shadow_card_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:new_klikdna/widgets/outline_and_icon_button_widget.dart';
import 'package:new_klikdna/widgets/outline_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class NewFoodMeterPage extends StatefulWidget {
  @override
  _NewFoodMeterPageState createState() => _NewFoodMeterPageState();
}

class _NewFoodMeterPageState extends State<NewFoodMeterPage> {

  bool visible = true;
  void toggle() {
    setState(() {
      visible = !visible;
    });
  }

  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    Provider.of<TokenProvider>(context, listen: false).getApiToken();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FoodMeterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.iconArrowColor,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Focus(
                onFocusChange: (isFocus){
                  if(isFocus){
                    Navigator.pushReplacementNamed(context, "food_meter_search_page");
                  }
                },
                child: FormWidget(
                  readonly: true,
                  textEditingController: searchController,
                  hint: "Cari makanan, minuman atau restauran",
                  obscure: false,
                  labelText: "Cari makanan, minuman atau restauran",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineAndIconButtonWidget(
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
            ),
            Consumer<FoodMeterProvider>(
              builder: (context, fm, _){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16),
                      child: CustomShadowCardWidget(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 21, top: 20, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: MyColors.burgerIconColor,
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
                                        color: MyColors.drinkIconColor,
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
                                        color: MyColors.restoranIconColor,
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
                      ),
                    ),
                    SizedBox(height: 27),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("Terakhir Dilihat",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto"
                          )
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16),
                        child: ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return CustomShadowCardWidget(
                              width: MediaQuery.of(context).size.width /2.5,
                              margin: EdgeInsets.only(right: 16, bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 0, right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Indomie Goreng"),
                                    SizedBox(height: 16),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: MyColors.kkalColor,
                                                        borderRadius: BorderRadius.circular(50),
                                                      ),
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text("Kalori",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.w300
                                                        )),
                                                  ],
                                                ),
                                                Text("147 kkal",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "Roboto"
                                                    )),
                                              ],
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
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
                                                Text("1.2 g",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "Roboto"
                                                    )),
                                              ],
                                            ),


                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 27),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("Pencarian Favorit",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto"
                          )
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16),
                        child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return CustomShadowCardWidget(
                                margin: EdgeInsets.only(right: 16, bottom: 16),
                                width: 280,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, top: 16),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                color: MyColors.burgerIconColor,
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: Center(
                                                    child: Image.asset("assets/icons/burger_icon.png", height: 12)),
                                              )),
                                          SizedBox(width: 13),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Indomie Goreng",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ),
                                              Text("177 Kalori 1 serving",
                                                  style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w300
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    //////////////////////////
                                    Padding(
                                      padding: const EdgeInsets.only(left: 17.0, top: 8, right: 19),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 19.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                          color: MyColors.kkalColor,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text("Kalori",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.w300
                                                        )),
                                                  ],
                                                ),
                                                Text("147 kkal",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Roboto",
                                                        fontWeight: FontWeight.w400
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 16.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                          color: MyColors.proteinColor,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text("Protein",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.w300
                                                        )),
                                                  ],
                                                ),
                                                Text("1.2 g",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Roboto",
                                                        fontWeight: FontWeight.w400
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                          color: MyColors.fatColor,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text("Fat",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.w300
                                                        )),
                                                  ],
                                                ),
                                                Text("0.3 g",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: "Roboto",
                                                        fontWeight: FontWeight.w400
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 10,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                        color: MyColors.carboColor,
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text("Carbo",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontFamily: "Roboto",
                                                          fontWeight: FontWeight.w300
                                                      )),
                                                ],
                                              ),
                                              Text("40 g",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Roboto",
                                                      fontWeight: FontWeight.w400
                                                  ))
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Informasi Nutrisi",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto"
                              )),
                          IconButton(
                              icon: Icon(Icons.arrow_forward_ios, size: 20, color: MyColors.iconArrowColor),
                              onPressed: (){}
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 14),
                        child: Row(
                          children: [
                            CustomShadowCardWidget(
                              child: Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width /2.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/images/kacang.png", height: 129, fit: BoxFit.fill),
                                      SizedBox(height: 7),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Text("Lemak",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300
                                            )),
                                      )
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(width: 11),
                            CustomShadowCardWidget(
                              child: Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width /2.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/images/nasi.png", height: 129, fit: BoxFit.fill),
                                      SizedBox(height: 7),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Text("Karbohidrat",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300
                                            )),
                                      )
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(width: 11),
                            CustomShadowCardWidget(
                              child: Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width /2.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/images/protein.png", width: 150, height: 129, fit: BoxFit.fill),
                                      SizedBox(height: 7),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Text("Protein",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300
                                            )),
                                      )
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(width: 11),
                            CustomShadowCardWidget(
                              child: Container(
                                  height: 180,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/images/garam.png", width: 150, height: 129, fit: BoxFit.fill),
                                      SizedBox(height: 7),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Text("Garam",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300
                                            )),
                                      )
                                    ],
                                  )
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}


