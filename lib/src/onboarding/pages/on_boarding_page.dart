import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/localization.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/slide_tile_widget.dart';

class OnBoardingPage extends StatefulWidget {

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 15.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? MyColors.dnaGreen : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
          gradient:
          LinearGradient(colors: [MyColors.dnaGreen, MyColors.dnaGreen])),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black87),
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    child: Text("LEWATI",
                        style: TextStyle(
                            color: MyColors.dnaGreen,
                            fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Navigator.of(context).pushNamed('main_page', arguments: 0);
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 180,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: <Widget>[
                  SlideTileWidget(
                    imagePath: "assets/images/onboarding1.png",
                    title: lang.translate("onboarding_title1"),
                    desc: lang.translate("onboarding_desc1"),
                  ),
                  SlideTileWidget(
                    imagePath: "assets/images/onboarding2.png",
                    title: lang.translate("onboarding_title2"),
                    desc: lang.translate("onboarding_desc2"),
                  ),
                  SlideTileWidget(
                    imagePath: "assets/images/onboarding3.png",
                    title: lang.translate("onboarding_title3"),
                    desc: lang.translate("onboarding_desc3"),
                  )
                ],
              ),
            ),
            Container(
              child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 0; i < 3; i++)
                  i == slideIndex
                      ? _buildPageIndicator(true)
                      : _buildPageIndicator(false),
              ]),
            ),
          ],
        ),
        bottomSheet: slideIndex != 2
            ? Container(
          color: Colors.white,
          //margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  controller.animateToPage(2,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "MASUK",
                  style: TextStyle(
                      color: MyColors.dnaGreen,
                      fontWeight: FontWeight.w600),
                ),
              ),
              FlatButton(
                onPressed: () {
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "BERIKUTNYA",
                  style: TextStyle(
                      color: MyColors.dnaGreen,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        )
            : InkWell(
          onTap: () {
            print("Get Started Now");
            Navigator.pushReplacementNamed(context, "login_page");
          },
          child: Container(
            height: Platform.isIOS ? 50 : 60,
            color: MyColors.dnaGreen,
            alignment: Alignment.center,
            child: Text(
              "MULAI",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  AppBar myAppbar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      actions: <Widget>[
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Center(
              child: Row(
                children: [
                  Text("LEWATI",
                      style: TextStyle(
                          color: MyColors.dnaGreen,
                          fontWeight: FontWeight.w600)),
                  SizedBox(width: 20),
                  Icon(Icons.arrow_forward_ios,
                      color: MyColors.dnaGreen, size: 20)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
