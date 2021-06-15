import 'package:flutter/material.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
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

  /*
  var bersepeda = cal / (0.13 * weight)
  var senam = cal / (0.11 * weight)
  var berlari = cal / (0.13 * weight)
  var berjalan = cal / (0.08 * weight)
  var yoga = cal / (0.04 * weight)
  var berenang = cal / (0.17 * weight)
  var membersikanRumah = cal / (0.05 * weight)
  var berbelanja = cal / (0.04 * weight)

  *note:
  cal == calories
  weight == berat badan yang diambil dari patient card*/
  String bb = "0";
  double cal = 0.0;
  double berjalan = 0.0;
  double berlari = 0.0;
  double bersepeda = 0.0;
  double senam = 0.0;
  double yoga = 0.0;
  double bersih2 = 0.0;
  double belanja = 0.0;
  double renang = 0.0;


  @override
  void initState() {
    isExpanded = false;
    bb = Provider.of<PatientCardProvider>(context, listen: false).bb;
    print("Berat Badan Detail Page $bb");
    hitungRumus();
    super.initState();
  }

  hitungRumus(){
    List<MobileNutritions> kalori =
    Provider.of<FoodMeterProvider>(context, listen: false)
        .newMobilenutritionListz
        .where((e) => (e.nutritionName.contains("Kalori")))
        .toList();
    String cal = kalori.isEmpty ? "0.0" : kalori[0].nutritionSize;
    berjalan = double.parse(cal) / (0.08 * double.parse(bb));
    print("Berjalan ${berjalan.round()}");
    berlari = double.parse(cal) / (0.13 * double.parse(bb));
    bersepeda = double.parse(cal) / (0.13 * double.parse(bb));
    senam = double.parse(cal) / (0.11 * double.parse(bb));
    yoga = double.parse(cal) / (0.04 * double.parse(bb));
    bersih2 = double.parse(cal) / (0.05 * double.parse(bb));
    belanja = double.parse(cal) / (0.04 * double.parse(bb));
    renang = double.parse(cal) / (0.17 * double.parse(bb));

  }

  @override
  Widget build(BuildContext context) {
    //
    final prov = Provider.of<FoodMeterProvider>(context);

    List splittedBerjalan = berjalan.round().toString().split(".");
    List splittedBerlari = berlari.round().toString().split(".");
    List splittedBerenang = renang.round().toString().split(".");
    List splittedBersepeda = bersepeda.round().toString().split(".");
    List splittedSenam = senam.round().toString().split(".");
    List splittedYoga = yoga.round().toString().split(".");
    List splittedBelanja = belanja.round().toString().split(".");
    List splittedBersih = bersih2.round().toString().split(".");
    String berjalanVal = splittedBerjalan[0];
    List splittedSize = prov.sizeProduk.toString().split(".");

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
                    readonly: false,
                    autofocus: false,
                    textEditingController: serachController,
                    hint: "Cari makanan, minuman atau restoran",
                    obscure: false,
                    labelText: "Cari makanan, minuman atau restoran",
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
                Text("${prov.namaProduk}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto")),
                SizedBox(height: 4),
                Text("1 Porsi ${splittedSize[0]} ${prov.prodUom}",
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
                buildTileNutrition(prov),
                SizedBox(height: 15),
                isExpanded == true
                    ? buildListBuilderNutritions(prov)
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
                buildRekomendasiOlahRaga(prov),
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
                              padding: const EdgeInsets.only(left: 18.0),
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
                                      Text("$berjalanVal",
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
                              padding: const EdgeInsets.only(left: 18.0),
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
                                      Text("${splittedBerlari[0]}",
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
                              padding: const EdgeInsets.only(left: 18.0),
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
                                      Text("${splittedBersepeda[0]}",
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
                              padding: const EdgeInsets.only(left: 18.0),
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
                                      Text("${splittedBerenang[0]}",
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
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Image.asset("assets/icons/yoga_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("${splittedYoga[0]}",
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
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Image.asset("assets/icons/senam_icon.png",
                                  height: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("${splittedSenam[0]}",
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
                buildAktifitasLainnya(prov),
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
                              padding: const EdgeInsets.only(left: 18.0),
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
                                      Text("${splittedBersih[0]}",
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
                              padding: const EdgeInsets.only(left: 18.0),
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
                                      Text("${splittedBelanja[0]}",
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

  Row buildAktifitasLainnya(FoodMeterProvider prov) {
    List<MobileNutritions> kalori =
    Provider.of<FoodMeterProvider>(context, listen: false)
        .newMobilenutritionListz
        .where((e) => (e.nutritionName.contains("Kalori")))
        .toList();

    List kaloriSize =
    kalori.isEmpty ? "0.0".split(".") : kalori[0].nutritionSize.split(".");
    return Row(
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
                    Text("${kaloriSize[0]}",
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
              "Aktifitas lainnya yang dapat kamu lakukan untuk membakar ${kaloriSize[0]} Kkal",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto")),
        )
      ],
    );
  }

  Widget buildRekomendasiOlahRaga(FoodMeterProvider prov) {
    List<MobileNutritions> kalori =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionListz
            .where((e) => (e.nutritionName.contains("Kalori")))
            .toList();

    List kaloriSize = kalori.isEmpty ? "0.0".split(".") : kalori[0].nutritionSize.split(".");

    return Row(
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
                    Text("${kaloriSize[0]}",
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
              "Aktifitas yang dapat kamu lakukan untuk membakar ${kaloriSize[0]} kkal",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto")),
        )
      ],
    );
  }

  Widget buildTileNutrition(FoodMeterProvider prov) {
    List<MobileNutritions> kalori =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionListz
            .where((e) => (e.nutritionName.contains("Kalori")))
            .toList();
    List<MobileNutritions> protein =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionListz
            .where((e) => (e.nutritionName.contains("Protein")))
            .toList();
    List<MobileNutritions> lemak =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionListz
            .where((e) => (e.nutritionName.contains("Lemak")))
            .toList();
    List<MobileNutritions> karbo =
        Provider.of<FoodMeterProvider>(context, listen: false)
            .newMobilenutritionListz
            .where((e) => (e.nutritionName.contains("Karbo")))
            .toList();

    List kaloriSize =
        kalori.isEmpty ? "0.0".split(".") : kalori[0].nutritionSize.split(".");
    List proteinSize = protein.isEmpty
        ? "0.0".split(".")
        : protein[0].nutritionSize.split(".");
    List lemakSize =
        lemak.isEmpty ? "0.0".split(".") : lemak[0].nutritionSize.split(".");
    List karboSize =
        karbo.isEmpty ? "0.0".split(".") : karbo[0].nutritionSize.split(".");

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
                  Text("Kalori",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          fontSize: 12)),
                  Text(kalori.isEmpty ? "0 Kkal" : "${kaloriSize[0]} Kkal",
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
                  Text("Protein",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          fontSize: 12)),
                  Text("${proteinSize[0]} g",
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
                  Text("Lemak",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          fontSize: 12)),
                  Text("${lemakSize[0]} g",
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
                  Text("Karbo",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Roboto",
                          fontSize: 12)),
                  Text("${karboSize[0]} g",
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

  Widget buildListBuilderNutritions(FoodMeterProvider prov) {
    prov.newMobilenutritionListx.removeWhere((e) =>
        e.nutritionName.contains("Kalori") ||
        e.nutritionName.contains("Protein") ||
        e.nutritionName == "Lemak" ||
        e.nutritionName.contains("Karbo"));
    return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: prov.newMobilenutritionListx.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            List splitSize = prov.newMobilenutritionListx[index].nutritionSize
                .toString()
                .split(".");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${prov.newMobilenutritionListx[index].nutritionName}",
                          style: TextStyle(fontSize: 14)),
                      Row(
                        children: [
                          Text("${splitSize[0]}",
                              style: TextStyle(fontSize: 14)),
                          SizedBox(width: 5),
                          Text(
                              "${prov.newMobilenutritionListx[index].nutritionUom}",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 1,
              color: Colors.grey,
            );
          },
        ));
  }
}
