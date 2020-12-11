import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class DetailPostitNowPage extends StatefulWidget {
  @override
  _DetailPostitNowPageState createState() => _DetailPostitNowPageState();
}

class _DetailPostitNowPageState extends State<DetailPostitNowPage> {

  final List<Widget> slideCard = [
    DashboardSlider(
      svgSrc:
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
      svgSrc:
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 2, top: 24),
              child: Container(
                child: DashboardSlider(
                  svgSrc:
                  "assets/images/positnow_2.png",
                  title: "",
                  width: 380,
                  height: 180,
                  margin: EdgeInsets.only(right: 10),
                  desc: "",
                  press: () {

                  },
                ),
              ),
            ),



            SizedBox(height: 24),

          ],
        ),
      ),
    );
  }
}
