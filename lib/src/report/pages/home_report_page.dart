import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/src/report/widgets/button_icon_widget.dart';
import 'package:new_klikdna/src/report/widgets/kit_list_service2_widget.dart';
import 'package:new_klikdna/src/report/widgets/kit_list_service_widget.dart';
import 'package:new_klikdna/src/report/widgets/member_item_widget.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

class HomeReportPage extends StatefulWidget {

  @override
  _HomeReportPageState createState() => _HomeReportPageState();
}

class _HomeReportPageState extends State<HomeReportPage> {
  String persoinId;
  Future _future;
  Future _getSample;
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
    _getSample = Provider.of<ReportProvider>(context, listen: false)
        .getSample(context, prefs.getString("personId"));
  }

  getAccount() {
    Provider.of<AccountProvider>(context, listen: false)
        .getUserAccount(context);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final prov = Provider.of<MemberProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColors.dnaGreen,
        title: Text("Report", style: TextStyle(color: Colors.white)),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, "detail_report_page");
              Navigator.of(context).pop();
            }),

      ),
      body: Stack(
              children: <Widget>[
                Container(
                  //color: MyColors.dnaGreen,
                  height: 160,
                  decoration: BoxDecoration(
                    color: MyColors.dnaGreen,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Consumer<AccountProvider>(
                              builder: (context, prov, _) {
                                return Container(
                                  height: 80,
                                  //color: Colors.blue,
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Hello",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300)),
                                          Text(
                                            "${prov.name}",
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text("ini dashboard report DNA kamu",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Consumer<PatientCardProvider>(
                              builder: (context, model, _) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: model.photoView == null
                                        ? Image.asset(
                                            "assets/images/no_image.png",
                                            height: 62,
                                            width: 62,
                                            fit: BoxFit.cover)
                                        : Image.memory(
                                            model.photoView,
                                            width: 62,
                                            fit: BoxFit.cover,
                                            height: 62,
                                            // height: 150,
                                          ));
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 140),
                  child: Container(
                      padding: EdgeInsets.only(top: 20),
                      //alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Consumer<ReportProvider>(
                        builder: (context, sample, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20),
                                  child: Text("Pilih Pengguna",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.dnaGrey))),
                              buildListMember(width, prov),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: ButtonIconWidget(
                                  myIcon: Icon(LineariconsFree.download,
                                      color: Colors.white),
                                  //myIcon: Image.asset("assets/icons/download_icon.png"),
                                  btnText: "Download Report",
                                  color: MyColors.dnaGreen,
                                  btnAction: () {
                                    Provider.of<ReportProvider>(context,
                                            listen: false)
                                        .showModalDownload(context);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text("Report Kamu",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.dnaGrey))),
                              buildReportList(width, sample),

                            ],
                          );
                        },
                      )),
                ),
              ],
            ),
    );
  }

  Widget buildReportList(double width, ReportProvider sample) {
    return FutureBuilder(
        future: _getSample,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (sample.listDetail2.length == 0) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(child: Text("Belum ada report")));
            } else {
              return  Column(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: sample.listDetail.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return KitServiceItemWidget(
                            model: sample.listDetail
                                .elementAt(index));
                      }),
                  SizedBox(height: 20),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: sample.listDetail2.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return KitService2ItemWidget(
                            model: sample.listDetail2.elementAt(index));
                      })

                ],
              );
            }
          } else {
            return  SizedBox(
              height: MediaQuery.of(context).size.height / 3,
                child: Center(child: SpinKitDoubleBounce(color: Colors.grey, size: 30)));
          }
        });
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
                          return MemberItemWidget(
                              member: prov.listMember[index]);
                        }),
              );
            }
          } else {
            return SizedBox(height: 125);
          }
        });
  }
}
