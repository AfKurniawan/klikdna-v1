import 'package:flutter/material.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/dummy_nutrisi_desc.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/favourite_food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/last_seen_foodmeter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/favourite_items.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/last_seen_items.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_and_icon_widget.dart';
import 'package:new_klikdna/widgets/custom_shadow_card_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:new_klikdna/widgets/loading_widget.dart';
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
    Provider.of<LastSeenFoodMeterProvider>(context, listen: false)
        .getLastSeenFood(context);
    Provider.of<FavouriteFoodMeterProvider>(context, listen: false)
        .getFavouriteData(context);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String lemakdesc = "Lemak ialah salah satu komponen makronutrien yang berfungsi sebagai cadangan energi jangka waktu panjang, dan juga mambantu penyerapan beberapa jenis vitamin dalam tubuh, seperti vitamin A, D, E dan K. Hanya saja, seringkali lebihnya kadar lemak justrut tidak lagi bermanfaat, dan menjadi faktor resiko berbagai penyakit. Secara umum, lemak dapat dibagi menjadi asam lemak jenuh, asam lemak tidak jenuh, serta lemak trans. Asam lemak jenuh dan lemak trans tidak baik banyak dikonsumsi karena dapat menimbulkan penyumbatan pembuluh darah. Asupan lemak per hari menurut AKG adalah sekitar 10-25% dari total kalori per hari. Batas ini berkisar 30 gram asupan lemak jenuh per hari untuk laki-laki, 20 gram per hari untuk perempuan. Sementara lemak trans, batasnya sekitar 5 gram per hari" ;
  String garamdesc = "Garam, yang biasanya disebut sebagai Natrium atau Sodium, berperan dalam keseimbangan cairan dan ion dalam tubuh, serta menjaga kestabilan tekanan darah. Meskipun penting, namun rekomendasi asupan garam tidaklah banyak, yaitu 2400 mg, atau sekitar 1 sendok teh garam per harinya. akan tetapi, kelebihan asupan garam justru yang banyak terjadi belakangan ini, dan dapat menyebabkan hipertensi atau tekanan darah tinggi yang dapat menimbulkan berbagai penyakit lainnya lagi. Tingginya kadar garam dalam suatu makanan berperan dalam hal ini. Sementara itu, apabila tubuh kekurangan garam dapat menimbulkan gangguan keseimbangan cariran tubuh, membuat bengkak tubuh, badan lemas, dan lain sebagainya";
  String proteinDesc = "Protein merupakan kumpulan asam amino yang berperan penting dalam keseimbangan fungsi sel tubuh. Mulai dari fungsinya menjadi struktur penyusun sel tubuh, menjaga daya tahan tubuh, media transportasi sel, menjalankan fungsi enzim, menyampaikan pesan sel, menjadikan protein salah satu komponen vital yang jangan sampai kekurangan. Menurut AKG, asupan keseharian protein sekitar 10-15% dari keseluruhan kalori per hari. Hal ini berkisar 56-59 gram per hari untuk perempuan dan 62-66 gram per harinya untuk laki-laki. Kekurangan protein dapat berakibat pada berbagai macam gangguan fungsi tubuh, seperti malnutrisi, bengkak (edema), hilangnya massa otot, rentan terhadap infeksi akibat menurunnya daya tahan tubuh, masalah yang nampak pada kulit, rambut, kuku, dan lain sebagainya. Sementara itu, kelebihan protein dapat membuat penumpukan zat keton dalam tubuh (ketosis), gangguan fungsi ginjal, kurangnya kalsium dalam tubuh, serta resiko peningkatan berat badan. ";
  String karboDesc = "Karbohidrat adalah kumpulan senyawa yang menyediakan energi bagi tubuh kita dalam bentuk kalori. Fungsi karbohidrat adalah sebagai sumber energi utama dalam tubuh kita. Karbohidrat banyak ditemukan dalam bentuk gula, pati, buah dan sayur, susu, dan lain sebagainya. Jumlah asupan karbohidrat per hari seseorang berbeda-beda, ditentukan oleh jenis kelamin, usia, aktivitas, dan kondisi kesehatan.  Namun secara umum, menurut Angka Kecukupan Gizi (AKG) yang dibuat oleh Kementrian Kesehatan, batasan konsumsi harian karbohidrat adalah sekitar 60-75% dari jumlah asupan kalori per hari, yakni sekitar 350-390 gram untuk laki-laki, dan 300-320 gram untuk wanita. Ketika kekurangan karbohidrat dalam tubuh, seseorang dapat merasa lemah, pusing, mual, pandangan berkunang-kunang hingga sulit beraktivitas. Efek jangka panjang ketika seseorang kekurangan karbohidrat adalah malnutrisi, gangguan daya tahan tubuh, dan lainnya. Namun dewasa ini, hal yang lebih sering terjadi adalah kelebihan asupan karbohidrat sehari-hari. Hal ini dapat mengakibatkan resiko obesitas, penyakit kardiovaskuler, diabetes melitus tipe 2, dan penyakit tidak menular lainnya. ";

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
              child: Focus(
                onFocusChange: (isFocus) {
                  if (isFocus) {
                    Navigator.pushReplacementNamed(
                        context, "food_meter_search_page");
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
                      btnAction: () {},
                      height: 40,
                      widht: MediaQuery.of(context).size.width / 2.3,
                      color: MyColors.dnaGreen,
                      myIcon: Image.asset("assets/icons/scan_icon.png"),
                      btnText: "Pindai"),
                ],
              ),
            ),
            Consumer<FoodMeterProvider>(
              builder: (context, fm, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16),
                      child: CustomShadowCardWidget(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, bottom: 21, top: 20, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: MyColors.burgerIconColor,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Center(
                                              child: Image.asset(
                                                  "assets/icons/food_apple_icon.png",
                                                  height: 32)),
                                        )),
                                    splashColor: Colors.grey,
                                    onTap: (){
                                      Navigator.pushNamed(context, "food_meter_by_kategori_page");
                                    },
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Makanan",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400),
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
                                            child: Image.asset(
                                                "assets/icons/drinks_icon.png",
                                                height: 32)),
                                      )),
                                  SizedBox(height: 8),
                                  Text(
                                    "Minuman",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400),
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
                                            child: Image.asset(
                                                "assets/icons/resto_icon.png",
                                                height: 32)),
                                      )),
                                  SizedBox(height: 8),
                                  Text(
                                    "Restaurant",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400),
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
                              fontFamily: "Roboto")),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 16),
                        child: Consumer<FoodMeterProvider>(
                            builder: (context, food, _) {
                          return food.isLoadingDetail == true
                              ? LoadingWidget()
                              : buildSingleChildScrollViewLastSeen();
                        }),
                      ),
                    ),
                    SizedBox(height: 27),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text("Pencarian Favorit",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto")),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 16),
                        child: Consumer<FavouriteFoodMeterProvider>(
                          builder: (context, fav, _){
                           return buildSingleChildScrollViewFavourite();
                          }
                        ),
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
                                  fontFamily: "Roboto")),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 14),
                        child: Row(
                          children: [
                            InkWell(
                              child: CustomShadowCardWidget(
                                child: Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/images/kacang.png",
                                            height: 129, fit: BoxFit.fill),
                                        SizedBox(height: 7),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Text("Lemak",
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300)),
                                        )
                                      ],
                                    )),
                              ),
                              onTap: (){
                                Navigator.pushNamed(context, "detail_nutrition_page",
                                    arguments: DummyNutrisiDesc("Lemak", "assets/images/kacang.png", lemakdesc)
                                );
                              },
                            ),
                            SizedBox(width: 11),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, "detail_nutrition_page",
                                    arguments: DummyNutrisiDesc("Karbohidrat", "assets/images/nasi.png", karboDesc)
                                );
                              },
                              child: CustomShadowCardWidget(
                                child: Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/images/nasi.png",
                                            height: 129, fit: BoxFit.fill),
                                        SizedBox(height: 7),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Text("Karbohidrat",
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300)),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(width: 11),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, "detail_nutrition_page",
                                    arguments: DummyNutrisiDesc("Protein", "assets/images/protein.png", proteinDesc)
                                );
                              },
                              child: CustomShadowCardWidget(
                                child: Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/images/protein.png",
                                            width: 150, height: 129, fit: BoxFit.fill),
                                        SizedBox(height: 7),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Text("Protein",
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300)),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(width: 11),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, "detail_nutrition_page",
                                    arguments: DummyNutrisiDesc("Garam", "assets/images/garam.png", garamdesc)
                                );
                              },
                              child: CustomShadowCardWidget(
                                child: Container(
                                    height: 180,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/images/garam.png",
                                            width: 150, height: 129, fit: BoxFit.fill),
                                        SizedBox(height: 7),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Text("Garam",
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300)),
                                        )
                                      ],
                                    )),
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

  SingleChildScrollView buildSingleChildScrollViewLastSeen() {
    var lastSeen = Provider.of<LastSeenFoodMeterProvider>(context, listen: false);
    var details = Provider.of<FoodMeterProvider>(context, listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          LastSeenItem(food: lastSeen.food0, kal: details.kal0, kalSize: details.kalSize0, prot: details.prot0, protSize: details.protSize0),
          LastSeenItem(food: lastSeen.food1, kal: details.kal1, kalSize: details.kalSize1, prot: details.prot1, protSize: details.protSize1),
          LastSeenItem(food: lastSeen.food2, kal: details.kal2, kalSize: details.kalSize2, prot: details.prot2, protSize: details.protSize2),
          LastSeenItem(food: lastSeen.food3, kal: details.kal3, kalSize: details.kalSize3, prot: details.prot3, protSize: details.protSize3),
          LastSeenItem(food: lastSeen.food4, kal: details.kal4, kalSize: details.kalSize4, prot: details.prot4, protSize: details.protSize4)

        ],
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollViewFavourite() {
    var fav = Provider.of<FavouriteFoodMeterProvider>(context, listen: false);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FavouriteItems(food: fav.food0, kal: fav.kal0, kalSize: fav.kalSize0, prot: fav.prot0, protSize: fav.protSize0, lemak: fav.lemak0, lemakSize: fav.lemakSize0, karbo: fav.karbo0, karboSize: fav.kalSize0, kategori: fav.kategori0),
          FavouriteItems(food: fav.food1, kal: fav.kal1, kalSize: fav.kalSize1, prot: fav.prot1, protSize: fav.protSize1, lemak: fav.lemak1, lemakSize: fav.lemakSize1, karbo: fav.karbo1, karboSize: fav.kalSize1, kategori: fav.kategori1),
          FavouriteItems(food: fav.food2, kal: fav.kal2, kalSize: fav.kalSize2, prot: fav.prot2, protSize: fav.protSize2, lemak: fav.lemak2, lemakSize: fav.lemakSize2, karbo: fav.karbo2, karboSize: fav.kalSize2, kategori: fav.kategori2),
          FavouriteItems(food: fav.food3, kal: fav.kal3, kalSize: fav.kalSize3, prot: fav.prot3, protSize: fav.protSize3, lemak: fav.lemak3, lemakSize: fav.lemakSize3, karbo: fav.karbo3, karboSize: fav.kalSize3, kategori: fav.kategori3),
          FavouriteItems(food: fav.food4, kal: fav.kal4, kalSize: fav.kalSize4, prot: fav.prot4, protSize: fav.protSize4, lemak: fav.lemak4, lemakSize: fav.lemakSize4, karbo: fav.karbo4, karboSize: fav.kalSize4, kategori: fav.kategori4),

        ],
      ),
    );
  }
}


