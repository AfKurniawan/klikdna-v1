import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_klikdna/src/home/providers/artikel_provider.dart';
import 'package:new_klikdna/src/home/widgets/artikel_item.dart';
import 'package:new_klikdna/src/home/widgets/banner_slider.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'package:new_klikdna/widgets/outline_button_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ArtikelProvider>(context, listen: false).getArtikel(context, context.watch<TokenProvider>().accessToken);
    var mediaQuery = MediaQuery.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        //appBar:  myApbar(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BannerSlider(),
                    ],
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Report kamu", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sanomat Grab Web',
                              color: Colors.black,
                            )),
                            GestureDetector(
                              child: Text("Lihat Semua",
                                  style: TextStyle(
                                      color: MyColors.dnaGreen, fontSize: 14)),
                              onTap: () {
                                print("LIHAT SEMUA CLICKED");
                              },
                            ),
                          ],
                        )),
                    SizedBox(height: 10),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          DashboardSlider(
                            svgSrc:
                            "assets/images/report_images.png",
                            title: "",
                            desc:
                            "",
                            press: () {
                              Navigator.of(context).pushNamed("main_page", arguments: 2);
                            },
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Kartu Pasien", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sanomat Grab Web',
                                color: Colors.black,
                              )),
                              GestureDetector(
                                child: Text("Lihat Semua",
                                    style: TextStyle(
                                        color: MyColors.dnaGreen, fontSize: 14)),
                                onTap: () {
                                  print("LIHAT SEMUA CLICKED");
                                },
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 10),
                    DashboardSlider(
                      svgSrc:
                      "assets/images/patient_card.png",
                      title: "Homemade egg with sauce and mayo special bread",
                      desc:
                      "10 Min - 147 calories",
                      press: () {
                        Navigator.of(context).pushNamed("patient_card_page");
                      },
                    ),

                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0, right: 8),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Artikel", style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sanomat Grab Web',
                                color: Colors.black,
                              )),
                              GestureDetector(
                                child: Text("Lihat Semua",
                                    style: TextStyle(
                                        color: MyColors.dnaGreen, fontSize: 14)),
                                onTap: () {
                                  print("LIHAT SEMUA CLICKED");
                                },
                              ),
                            ],
                          )),
                    ),

                    Consumer<ArtikelProvider>(
                        builder: (context, artikel, _){

                          return Container(
                              height: MediaQuery.of(context).size.height /1.6,
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: artikel.listArtikel.length,
                                //padding: EdgeInsets.all(1),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 1),
                                itemBuilder: (context, index) => ArtikelItem(artikel.listArtikel[index]),
                              )
                          );
                        }
                    )

                    //ListArtikelWidget(artikel: artikel),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: OutlineButtonWidget(
                  btnText: "Lihat Semua Artikel",
                  outlineTextColor: MyColors.dnaGreen,
                  height: 50,
                  btnAction: () {
                    Navigator.of(context).pushNamed("all_artikel_page");
                  },
                  filledColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
