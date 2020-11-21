import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/src/report/widgets/button_icon_widget.dart';
import 'package:new_klikdna/src/report/widgets/grid_icon_menu_widget.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

class ReportPage extends StatefulWidget {
  static const String id = "/report_page";

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String persoinId;
  Future _future;
  @override
  void initState() {
     getAccount();
     getPersonId();
    super.initState();
  }

  getPersonId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Provider.of<ReportProvider>(context, listen: false)
        .getSample(context, prefs.getString("personId"));

    _future = Provider.of<MemberProvider>(context, listen: false)
        .getMember(context, prefs.getString("personId"));
  }

  getAccount() {
    Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final prov = Provider.of<MemberProvider>(context);
    final report = Provider.of<ReportProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: prov.isLoading == true
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(strokeWidth: 2))
          : Stack(
              children: <Widget>[
                Container(
                  //color: MyColors.dnaGreen,
                  height: 200,
                  decoration: BoxDecoration(
                    color: MyColors.dnaGreen,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Hello",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                SizedBox(width: 5),
                                Consumer<LoginProvider>(
                                  builder: (context, prov, _) {
                                    return Container(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: Text("${prov.vfirstname} ${prov.vlastname}",
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                          ],
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              print("DABADla");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 4)),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/no_image.png'),
                                radius: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 170),
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: report.listDetail.length == 0 && prov.listMember.length <= 0
                        ? Container(
                            child: Center(
                              child: Text("Belum ada member maupun report"),
                            ),
                          )

                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 30),
                            child: Text("Pilih Pengguna",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.dnaGrey))),
                        buildListMember(width, prov),
                         Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: ButtonIconWidget(
                            myIcon: Icon(LineariconsFree.download, color: Colors.white),
                            //myIcon: Image.asset("assets/icons/download_icon.png"),
                            btnText: "Download Report",
                            color: MyColors.dnaGreen,
                            btnAction: () {
                              Provider.of<ReportProvider>(context, listen: false).showModalDownload(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Text("Report Kamu",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.dnaGrey))),
                        Consumer<ReportProvider>(
                          builder: (context, sample, _) {
                            return sample.listDetail.length == 0
                                ? Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: Center(
                                      child: Text("Belum Ada Report",
                                          style: TextStyle(color: Colors.grey)),
                                    ),
                                  ) :
                            ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: sample.listDetail.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return KitServiceItemWidget(
                                          model: sample.listDetail
                                              .elementAt(index));
                                    });
                          },
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildListMember(double width, MemberProvider prov) {
    return FutureBuilder(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (prov.listMember.length <= 0) {
              return SizedBox(
                  height: width * 0.33,
                  child: Center(child: Text("Belum ada member")));
            } else {
              return SizedBox(
                height: width * 0.33,
                child: prov.listMember.length == 0
                    ? Center(child: Text("Belum ada member"))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: prov.listMember.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return MemberItemWidget(member:
                              prov.listMember[index]);
                        }),
                );
            }
          } else {
            return Platform.isIOS
                ? SizedBox(
                    height: width * 0.33,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : SizedBox(
                    height: width * 0.33,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
          }
        });
  }
}

class MemberItemWidget extends StatelessWidget {
  final Member member;

  MemberItemWidget({Key key, this.member}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ReportProvider>(context);
    var width = MediaQuery.of(context).size.width;
    final mem = Provider.of<MemberProvider>(context);
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        print("Widget: ${member.personId}");
        prov.getSample(context, member.personId);
        mem.getName(context, member.name);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/no_image.png',
                //model.name,
                fit: BoxFit.fill,
                height: width * 0.2,
                width: width * 0.2,
              ),
            ),
            // SizedBox(
            //   height: 4,
            // ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width /3,
              child: Align(
                alignment: Alignment.center,
                child: Center(
                  child: Text(member.name == null ? "" : "${member.name}",
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 30),
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
                                fontSize: 20,
                                color: widget.model.serviceName == "HEALTH" ? MyColors.healthGreen
                                    : widget.model.serviceName == "SPORT" ? MyColors.sportBlue
                                    : widget.model.serviceName == "DIET" ? MyColors.dietGreen
                                    : widget.model.serviceName == "SKIN" ? MyColors.skinPink
                                    : MyColors.dnaGreen
                            )),
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
