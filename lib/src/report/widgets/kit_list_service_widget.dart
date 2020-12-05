import 'package:flutter/material.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/widgets/grid_icon_menu_widget.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class KitServiceItemWidget extends StatefulWidget {
  final Detail model;
  final Member member;

  KitServiceItemWidget({Key key, this.model, this.member}) : super(key: key);

  @override
  _KitServiceItemWidgetState createState() => _KitServiceItemWidgetState();
}

class _KitServiceItemWidgetState extends State<KitServiceItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 20),
      child: Container(
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
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            Navigator.of(context)
                .pushNamed('detail_report_page', arguments: widget.model);
          },
          child: Stack(
            children: [
              Container(
                child: Positioned(
                    right: 0,
                    child: Container(
                      height: 90,
                      width: 80,
                      decoration: BoxDecoration(
                        color: widget.model.serviceName == "SPORT"
                            ? MyColors.sportBlue
                            : widget.model.serviceName == "HEALTH"
                            ? MyColors.healthGreen
                            : widget.model.serviceName == "DIET"
                            ? MyColors.dietGreen
                            : widget.model.serviceName == "SKIN"
                            ? MyColors.skinPink
                            : widget.model.serviceName ==
                            "CANCER MARKER"
                            ? Colors.deepOrange
                            : widget.model.serviceName ==
                            "DRUGS RESPONSE"
                            ? Colors.green
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 30.0, top: 8, bottom: 8, left: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            widget.model.serviceName == "SPORT"
                                ? "Sport"
                                : widget.model.serviceName == "HEALTH"
                                ? "Health"
                                : widget.model.serviceName == "DIET"
                                ? "Diet"
                                : widget.model.serviceName == "SKIN"
                                ? "Skin"
                                : widget.model.serviceName ==
                                "CANCER MARKER"
                                ? "Cancer Marker"
                                : widget.model.serviceName ==
                                "DRUGS RESPONSE"
                                ? "Drug Response"
                                : widget.model.serviceName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: widget.model.serviceName == "HEALTH" ? MyColors.healthGreen
                                    : widget.model.serviceName == "SPORT" ? MyColors.sportBlue
                                    : widget.model.serviceName == "DIET" ? MyColors.dietGreen
                                    : widget.model.serviceName == "SKIN" ? MyColors.skinPink
                                    : MyColors.dnaGreen
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width -180,
                          child: Text(
                              widget.model.serviceName == "SPORT"
                                  ? "Mulai kenali jenis olahraga yang cocok untuk kamu."
                                  : widget.model.serviceName == "HEALTH"
                                  ? "Pahami cara yang terbaik untuk pola hidup Sehat kamu."
                                  : widget.model.serviceName == "DIET"
                                  ? "Jenis diet apa saga yang cocok Untuk kamu."
                                  : widget.model.serviceName == "SKIN"
                                  ? "Ketahui resiko dan perawatan Mengenai kulit kamu."
                                  : widget.model.serviceName ==
                                  "CANCER MARKER"
                                  ? "Ketahui resiko kanker pada tubuhmu"
                                  : widget.model.serviceName ==
                                  "DRUGS RESPONSE"
                                  ? "Drug Response"
                                  : widget.model.serviceName,
                              style: TextStyle(
                                fontSize: 10,
                              )),
                        ),
                      ],
                    ),
                    Spacer(),
                    widget.model.serviceName == "SPORT"
                        ? Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(0xff2F74C6),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45.withOpacity(0.1),
                            spreadRadius: 0.1,
                            blurRadius: 5,
                            offset: Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image(
                          color: Colors.white,
                          image: AssetImage("assets/images/sport.png"),
                        ),
                      ),
                    )
                        : widget.model.serviceName == "HEALTH"
                        ? Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(0xff19B4BF),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45.withOpacity(0.1),
                            spreadRadius: 0.1,
                            blurRadius: 5,
                            offset: Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image(
                          color: Colors.white,
                          image:
                          AssetImage("assets/images/health.png"),
                        ),
                      ),
                    )
                        : widget.model.serviceName == "DIET"
                        ? Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(0xff87D39A),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black45.withOpacity(0.1),
                            spreadRadius: 0.1,
                            blurRadius: 5,
                            offset: Offset(0,
                                3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image(
                          color: Colors.white,
                          image: AssetImage(
                              "assets/images/diet.png"),
                        ),
                      ),
                    )
                        : widget.model.serviceName == "SKIN"
                        ? Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(0xffF8C6C4),
                        borderRadius:
                        BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45
                                .withOpacity(0.1),
                            spreadRadius: 0.1,
                            blurRadius: 5,
                            offset: Offset(0,
                                3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image(
                          color: Colors.white,
                          image: AssetImage(
                              "assets/images/skin.png"),
                        ),
                      ),
                    )
                        : widget.model.serviceName ==
                        "CANCER MARKER"
                        ? GridIconMenuWidget(
                      image: "assets/images/cancer.png",
                    )
                        : widget.model.serviceName ==
                        "DRUGS RESPONSE"
                        ? GridIconMenuWidget(
                      image:
                      "assets/images/drugs.png",
                    )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}