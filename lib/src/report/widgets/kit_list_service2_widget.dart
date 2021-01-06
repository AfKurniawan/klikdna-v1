import 'package:flutter/material.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/widgets/grid_icon_menu_widget.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class KitService2ItemWidget extends StatefulWidget {
  final Detail model;
  final Member member;

  KitService2ItemWidget({Key key, this.model, this.member}) : super(key: key);

  @override
  _KitService2ItemWidgetState createState() => _KitService2ItemWidgetState();
}

class _KitService2ItemWidgetState extends State<KitService2ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                          ? Color(0xffff69f2)
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
                  right: 30.0, top: 8, bottom: 8, left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.model.serviceName ==
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
                  widget.model.serviceName ==
                      "CANCER MARKER"
                      ? Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Color(0xffff91f5),
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
                            "assets/images/cancer.png"),
                      ),
                    ),
                  )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}