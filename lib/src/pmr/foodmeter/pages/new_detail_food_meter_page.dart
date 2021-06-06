import 'package:flutter/material.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/detail_food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/pagination_model_data.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/detail_food_meter_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/custom_appbar.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/my_expansion_tile.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_and_icon_widget.dart';
import 'package:new_klikdna/widgets/custom_shadow_card_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:new_klikdna/widgets/outline_and_icon_button_widget.dart';
import 'package:new_klikdna/widgets/outline_button_widget.dart';
import 'package:provider/provider.dart';

class NewDetailFoodMeterPage extends StatefulWidget {
  final MobileNutritions nutritions;
  final Datum food;

  NewDetailFoodMeterPage({Key key, this.nutritions, this.food})
      : super(key: key);

  @override
  _NewDetailFoodMeterPageState createState() => _NewDetailFoodMeterPageState();
}

class _NewDetailFoodMeterPageState extends State<NewDetailFoodMeterPage> {
  TextEditingController serachController = new TextEditingController();
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List splittedSize = widget.food.productSize.toString().split(".");
    final prov = Provider.of<FoodMeterProvider>(context);
    prov.newMobilenutritionList.removeWhere((e) => e.nutritionName == "Kalori");

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
        title: Text(
          "Food Meter",
          style: TextStyle(
              fontFamily: "Roboto",
              color: MyColors.blackPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset("assets/images/logo.png", width: 19),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: FormWidget(
                    readonly: true,
                    autofocus: true,
                    textEditingController: serachController,
                    hint: "Cari makanan, minuman atau restauran",
                    obscure: false,
                    labelText: "Cari makanan, minuman atau restauran",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButtonWidget(
                          btnAction: () {},
                          height: 40,
                          outlineColor: MyColors.dnaGreen,
                          btnTextColor: MyColors.dnaGreen,
                          width: MediaQuery.of(context).size.width / 2.3,
                          myIcon: Icons.mic,
                          iconColor: MyColors.dnaGreen,
                          btnText: Text(
                            "Voice Search",
                            style: TextStyle(color: MyColors.dnaGreen),
                          )),
                      ButtonAndIconWidget(
                          btnAction: () {
                            Navigator.pushNamed(context, "dummy_tts_page");
                          },
                          height: 40,
                          widht: MediaQuery.of(context).size.width / 2.3,
                          color: MyColors.dnaGreen,
                          myIcon: Image.asset("assets/icons/scan_icon.png"),
                          btnText: "Pindai"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("${widget.food.productName}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto")),
                SizedBox(height: 4),
                Text("1 Porsi ${splittedSize[0]} ${widget.food.productUom}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Roboto",
                        color: Color(0xffA1A1A1))),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Informasi Nutrisi",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto")),
                    IconButton(
                        icon: Icon(isExpanded == true
                            ? Icons.expand_less
                            : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        }),
                  ],
                ),


                buildTileNutritionKalorie(prov),

                SizedBox(height: 15),
                isExpanded == true
                    ? Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: prov.newMobilenutritionList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return NutritionItemWidget(nutritions: prov.newMobilenutritionList[index],
                        );
                      },
                      separatorBuilder: (context, index){
                        return Container(
                          height: 1,
                          color: Colors.grey,
                        );
                      },
                    )
                )
                    : Container(),
                SizedBox(height: 24),
                Container(
                  child: Text("Rekomendasi Olah Raga",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto")),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                              color: MyColors.kkalColor,
                              borderRadius: BorderRadius.circular(60)),
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          left: 12,
                          bottom: 12,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("51",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto")),
                                Text('Kkal',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Roboto"))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 210,
                      child: Text(
                          "Aktifitas yang dapat kamu lakukan untuk membakar 147 kalori",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto")),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomShadowCardWidget(
                        height: 69,
                        width: 156,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset(
                                  "assets/icons/berjalan_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("9",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 5),
                                      Text("Menit",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Text("Berjalan",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomShadowCardWidget(
                        height: 69,
                        width: 156,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset(
                                  "assets/icons/berlari_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("6",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 5),
                                      Text("Menit",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Text("Berlari",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomShadowCardWidget(
                        height: 69,
                        width: 156,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset(
                                  "assets/icons/bersepeda_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("6",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 5),
                                      Text("Menit",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Text("Bersepeda",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomShadowCardWidget(
                        height: 69,
                        width: 156,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset(
                                  "assets/icons/berenang_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("4",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 5),
                                      Text("Menit",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Text("Berenang",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomShadowCardWidget(
                        height: 69,
                        width: 156,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset("assets/icons/yoga_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("18",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 5),
                                      Text("Menit",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Text("Yoga",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomShadowCardWidget(
                        height: 69,
                        width: 156,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset("assets/icons/senam_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("7",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 5),
                                      Text("Menit",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Text("Senam",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  child: Text("Rekomendasi Aktifitas Lainnya",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto")),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                              color: MyColors.kkalColor,
                              borderRadius: BorderRadius.circular(60)),
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          left: 12,
                          bottom: 12,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("51",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto")),
                                Text('Kkal',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Roboto"))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 210,
                      child: Text(
                          "Aktifitas lainnya yang dapat kamu lakukan untuk membakar 147 kalori",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto")),
                    )
                  ],
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomShadowCardWidget(
                        height: 69,
                        width: 156,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset(
                                  "assets/icons/bebersih_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("15",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 5),
                                      Text("Menit",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Text("Bersih Rumah",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomShadowCardWidget(
                        height: 69,
                        width: 156,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Image.asset(
                                  "assets/icons/belanja_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("18",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 5),
                                      Text("Menit",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12))
                                    ],
                                  ),
                                  Text("Belanja",
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildListTileExpandItem(FoodMeterProvider prov) {
    List<MobileNutritions> gula =
    Provider.of<FoodMeterProvider>(context, listen: false)
        .newMobilenutritionList
        .where((e) => (e.nutritionName.contains("gula")))
        .toList();
    List<MobileNutritions> sodium =
    Provider.of<FoodMeterProvider>(context, listen: false)
        .newMobilenutritionList
        .where((e) => (e.nutritionName.contains("Sodium")))
        .toList();
    List<MobileNutritions> kj =
    Provider.of<FoodMeterProvider>(context, listen: false)
        .newMobilenutritionList
        .where((e) => (e.nutritionName.contains("Kilojoule")))
        .toList();
    List<MobileNutritions> jenuh =
    Provider.of<FoodMeterProvider>(context, listen: false)
        .newMobilenutritionList
        .where((e) => (e.nutritionName.contains("Jenuh")))
        .toList();
    List<MobileNutritions> serat =
    Provider.of<FoodMeterProvider>(context, listen: false)
        .newMobilenutritionList
        .where((e) => (e.nutritionName.contains("Jenuh")))
        .toList();

    // for(int i = 0; prov.newMobilenutritionList.length > 0; i++){
    //   print("GULAAAA ===> ${prov.newMobilenutritionList[i].nutritionName}");
    // }


    //List gulaSize = gula[0].nutritionSize.toString().split(".");
    List sodiumSize = sodium[0].nutritionSize.toString().split(".");
    List kjSize = kj[0].nutritionSize.toString().split(".");
    List jenuhSize = jenuh[0].nutritionSize.toString().split(".");
    List seratSize = serat[0].nutritionSize.toString().split(".");
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("GULA", style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      Text("0", style: TextStyle(fontSize: 14)),
                      SizedBox(width: 5),
                      Text("g", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(bottom: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sodium", style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      Text("210", style: TextStyle(fontSize: 14)),
                      SizedBox(width: 5),
                      Text("mg", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(bottom: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Kilojoule", style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      Text("213", style: TextStyle(fontSize: 14)),
                      SizedBox(width: 5),
                      Text("kj", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(bottom: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Lemak Jenuh", style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      Text("0", style: TextStyle(fontSize: 14)),
                      SizedBox(width: 5),
                      Text("g", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(bottom: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Serat", style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      Text("1.6000", style: TextStyle(fontSize: 14)),
                      SizedBox(width: 5),
                      Text("g", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget buildTileNutritionKalorie(FoodMeterProvider prov) {
    List<MobileNutritions> kalori =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionList
            .where((e) => (e.nutritionName.contains("Kalori")))
            .toList();
    List<MobileNutritions> protein =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionList
            .where((e) => (e.nutritionName.contains("Protein")))
            .toList();
    List<MobileNutritions> lemak =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionList
            .where((e) => (e.nutritionName.contains("Lemak")))
            .toList();
    List<MobileNutritions> karbo =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionList
            .where((e) => (e.nutritionName.contains("Karbo")))
            .toList();
    List splittedKaloriSize = kalori[0].nutritionSize.toString().split(".");
    List splittedProteinSize = protein[0].nutritionSize.toString().split(".");
    List splittedLemakSize = lemak[0].nutritionSize.toString().split(".");
    List splittedKarboSize = karbo[0].nutritionSize.toString().split(".");
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        width: double.infinity,
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 65,
              width: 70,
              decoration: BoxDecoration(
                  color: MyColors.kkalColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${kalori[0].nutritionName}",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          fontSize: 12)),
                  Text("${splittedKaloriSize[0]} ${kalori[0].nutritionUom}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontSize: 14))
                ],
              ),
            ),
            Container(
              height: 65,
              width: 70,
              decoration: BoxDecoration(
                  color: MyColors.proteinColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${protein[0].nutritionName}",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          fontSize: 12)),
                  Text("${splittedProteinSize[0]} ${protein[0].nutritionUom}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontSize: 14))
                ],
              ),
            ),
            Container(
              height: 65,
              width: 70,
              decoration: BoxDecoration(
                  color: MyColors.fatColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${lemak[0].nutritionName}",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          fontSize: 12)),
                  Text("${splittedLemakSize[0]} ${lemak[0].nutritionUom}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontSize: 14))
                ],
              ),
            ),
            Container(
              height: 65,
              width: 70,
              decoration: BoxDecoration(
                  color: MyColors.carboColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${karbo[0].nutritionName}",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          fontSize: 12)),
                  Text("${splittedKarboSize[0]} ${karbo[0].nutritionUom}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontSize: 14))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

