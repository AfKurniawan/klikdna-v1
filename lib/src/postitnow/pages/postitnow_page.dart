import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class PostItNowPage extends StatefulWidget {
  @override
  _PostItNowPageState createState() => _PostItNowPageState();
}

class _PostItNowPageState extends State<PostItNowPage> {

  final List<Widget> slideCard = [
    DashboardSlider(
      imgSrc:
      "assets/images/positnow_1.png",
      title: "",
      width: 380,
      height: 150,
      margin: EdgeInsets.only(right: 10),
      desc: "",
      press: () {

      },
    ),

    DashboardSlider(
      imgSrc:
      "assets/images/positnow_2.png",
      title: "",
      width: 380,
      height: 150,
      margin: EdgeInsets.only(right: 10),
      desc: "",
      press: () {

      },
    ),

  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Post It Now",
          style: TextStyle(fontSize: 14),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.dnaGrey,
              size: 20,
            ),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, "detail_report_page");
              Navigator.of(context).pop();
            }),
        actions: [
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 2, top: 24),
                  child: Container(
                    child: CarouselSlider(
                      items: slideCard,
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: false,
                          viewportFraction: 1.0,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: slideCard.map((url) {
                          int index = slideCard.indexOf(url);
                          if (_current == index) {
                            return Container(
                              width: 18.0,
                              height: 8.0,
                              margin:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                color: MyColors.dnaGreen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          } else {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: MyColors.grey),
                            );
                          }
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Info", style: TextStyle(
                 fontWeight: FontWeight.bold,
                fontSize: 16
                ),
              ),
            ),
            Container(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  padding: EdgeInsets.all(5),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1),
                  itemBuilder: (context, index){
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DashboardSlider(
                            imgSrc:
                            "assets/images/podcast_2.png",
                            title: "",
                            width: 150,
                            height: 125,
                            desc: "",
                            press: () {
                              Navigator.pushNamed(context, 'detail_positnow_page');
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
                    );
                  },
                )
              ),

            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Quotes", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
              ),
            ),
            Container(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  padding: EdgeInsets.all(5),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1),
                  itemBuilder: (context, index){
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DashboardSlider(
                            imgSrc:
                            "assets/images/podcast_2.png",
                            title: "",
                            width: 150,
                            height: 125,
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
                    );
                  },
                )
            ),

            SizedBox(height: 24),

          ],
        ),
      ),
    );
  }
}
