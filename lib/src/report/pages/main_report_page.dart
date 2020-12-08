import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/src/report/widgets/button_icon_widget.dart';
import 'package:new_klikdna/src/report/widgets/grid_icon_menu_widget.dart';
import 'package:new_klikdna/src/report/widgets/kit_list_service2_widget.dart';
import 'package:new_klikdna/src/report/widgets/kit_list_service_widget.dart';
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
                                  width: MediaQuery.of(context).size.width -100,
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Hello",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300)),
                                          Text("${prov.name}",
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500
                                            ),
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
                                    child: model.photoView == null ?
                                    Image.asset("assets/images/no_image.png", height: 62, width: 62, fit: BoxFit.cover)
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
                                    fontSize: 16,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.dnaGrey))),
                        Consumer<ReportProvider>(
                          builder: (context, sample, _) {
                            return sample.listDetail.length == 0
                                ? Container(
                              color: Colors.blue,
                                    height: MediaQuery.of(context).size.height / 5,
                                    child: Text("Belum Ada Report",
                                        style: TextStyle(color: Colors.grey)),
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
                        Consumer<ReportProvider>(
                          builder: (context, sample, _) {
                            return sample.listDetail.length == 0
                                ? Container(
                              height: MediaQuery.of(context).size.height / 6,
                              child: Text("Belum Ada Report",
                                  style: TextStyle(color: Colors.grey)),
                            ) :
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: sample.listDetail2.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return KitService2ItemWidget(
                                      model: sample.listDetail2
                                          .elementAt(index));
                                });
                          },
                        ),

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


