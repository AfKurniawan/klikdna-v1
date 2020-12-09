import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_klikdna/src/home/providers/artikel_provider.dart';
import 'package:new_klikdna/src/home/widgets/artikel_item.dart';
import 'package:new_klikdna/src/home/widgets/banner_slider.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/src/home/widgets/event_slider.dart';
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
    Size size = MediaQuery.of(context).size;
    var mediaquery = MediaQuery.of(context);
    Provider.of<ArtikelProvider>(context, listen: false).getArtikel(context, context.watch<TokenProvider>().accessToken);
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
                    SizedBox(height: 16),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Post it now", style: TextStyle(
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
                    SizedBox(height: 12),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DashboardSlider(
                                svgSrc:
                                "assets/images/positnow_1.png",
                                title: "",
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(right: 10),
                                desc: "",
                                press: () {

                                },
                              ),
                              SizedBox(height: 8),
                              Container(
                                width: 150,
                                  child: Text("Makanan tidak sehat untuk tubuh"))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DashboardSlider(
                                svgSrc:
                                "assets/images/positnow_2.png",
                                title: "",
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(right: 10),
                                desc: "",
                                press: () {

                                },
                              ),
                              SizedBox(height: 8),
                              Container(
                                  width: 150,
                                  child: Text("Diet yang terbaik untuk kamu"))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DashboardSlider(
                                svgSrc:
                                "assets/images/positnow_3.png",
                                title: "",
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(right: 10),
                                desc: "",
                                press: () {

                                },
                              ),
                              SizedBox(height: 8),
                              Container(
                                  width: 150,
                                  child: Text("7 Workout yang dapat dilakukan dirumah"))
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 22),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Event", style: TextStyle(
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
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(1, 4),
                                        blurRadius: 10,
                                        color: Color(0xFFB0CCE1).withOpacity(0.62),
                                      ),
                                    ],
                                  ),
                                  height: 255,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      EventSlider(
                                        svgSrc:
                                        "assets/images/event_1.png",
                                        title: "",
                                        width: 312,
                                        height: 130,
                                        desc: "",
                                        press: () {

                                        },
                                      ),
                                      SizedBox(height: 11),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0, bottom: 12),
                                        child: Container(
                                            width: 300,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.share,
                                                  color: Color(0xff717171), size: 20),
                                                SizedBox(height: 16),
                                                Text("DNA 101 Pengetahuan Dasar",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14
                                                  ),
                                                ),
                                                SizedBox(height: 9),
                                                Text("Buat kamu yang ingin mengetahui tentang kondisi kamu pada saat menjalankan olahraga",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),
                                                ),
                                                SizedBox(height: 14),
                                              ],
                                            )),
                                      ),


                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(1, 4),
                                        blurRadius: 10,
                                        color: Color(0xFFB0CCE1).withOpacity(0.62),
                                      ),
                                    ],
                                  ),
                                  height: 255,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      EventSlider(
                                        svgSrc:
                                        "assets/images/event_1.png",
                                        title: "",
                                        width: 312,
                                        height: 130,
                                        desc: "",
                                        press: () {

                                        },
                                      ),
                                      SizedBox(height: 11),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0, bottom: 12),
                                        child: Container(
                                            width: 300,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.share,
                                                    color: Color(0xff717171), size: 20),
                                                SizedBox(height: 16),
                                                Text("DNA 101 Pengetahuan Dasar",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 14
                                                  ),
                                                ),
                                                SizedBox(height: 9),
                                                Text("Buat kamu yang ingin mengetahui tentang kondisi kamu pada saat menjalankan olahraga",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12
                                                  ),
                                                ),
                                                SizedBox(height: 14),
                                              ],
                                            )),
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                    SizedBox(height: 22),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Podcast", style: TextStyle(
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
                    SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DashboardSlider(
                                svgSrc:
                                "assets/images/podcast_1.png",
                                title: "",
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(right: 10),
                                desc: "",
                                press: () {

                                },
                              ),
                              SizedBox(height: 8),
                              Container(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Bercerita Indonesia", style: TextStyle(fontSize: 14)),
                                      Text("Krisye Dwi Kuncoro", style: TextStyle(fontSize: 12, color: Color(0xffA1A1A1))),
                                    ],
                                  )
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DashboardSlider(
                                svgSrc:
                                "assets/images/podcast_2.png",
                                title: "",
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(right: 10),
                                desc: "",
                                press: () {

                                },
                              ),
                              SizedBox(height: 8),
                              Container(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Podcong Cast", style: TextStyle(fontSize: 14)),
                                      Text("Ahmad Alfan", style: TextStyle(fontSize: 12, color: Color(0xffA1A1A1))),
                                    ],
                                  )
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DashboardSlider(
                                svgSrc:
                                "assets/images/podcast_3.png",
                                title: "",
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(right: 10),
                                desc: "",
                                press: () {

                                },
                              ),
                              SizedBox(height: 8),
                              Container(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Podcong Cast", style: TextStyle(fontSize: 14)),
                                      Text("Ahmad Alfan", style: TextStyle(fontSize: 12, color: Color(0xffA1A1A1))),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
