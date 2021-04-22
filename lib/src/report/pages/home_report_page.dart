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
import 'package:new_klikdna/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

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
    super.initState();
  }

  getAccount() async {
    _future = Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
     _future = Provider.of<MemberProvider>(context, listen: false).getMember(context, Provider.of<AccountProvider>(context, listen: false).userId);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final prov = Provider.of<MemberProvider>(context);
    final acc = Provider.of<AccountProvider>(context);
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
              prov.getNamexx(context, acc.name, acc.userId);
            }),

      ),
      body: Consumer<ReportProvider>(
        builder: (context, report, _){
          return Stack(
            children: <Widget>[
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: MyColors.dnaGreen,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Consumer<AccountProvider>(
                        builder: (context, account, _) {
                          return account.verifyAccessReport == 0 ? Container()
                          : Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width /1.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hello,",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w300)),
                                  SizedBox(width: 5),
                                  Text(prov.newMemberName == "" ?
                                      "${account.name}" : "${prov.newMemberName}",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w700)),

                                  SizedBox(height: 5),
                                  Text("Ini Dashboard report\nDNA kamu.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 94,
                        child: Center(
                          child: Consumer<PatientCardProvider>(
                            builder: (context, model, _) {
                              return acc.verifyAccessReport == 0 ? Container()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: model.photoView == null ?
                                  Image.asset("assets/images/no_image.png", height: 72, width: 72, fit: BoxFit.cover)
                                      : Image.memory(
                                    model.photoView,
                                    width: 72,
                                    fit: BoxFit.cover,
                                    height: 72,
                                    // height: 150,
                                  ));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 125),
                child: Container(
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Consumer<ReportProvider>(
                      builder: (context, sample, _) {
                        return acc.verifyAccessReport == 0 ? Container(padding: EdgeInsets.only(top: 40),
                            height: MediaQuery.of(context).size.height / 1.7,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          child: Center(
                            child: Text("Harap menghubungi Support Genetics Indonesia\nuntuk menampilkan Report kamu",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w300
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                          : Column(
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
                            sample.notfound == true ? Container()
                            : Padding(
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
                            sample.notfound == true ?
                                Container()
                            : Padding(
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
          );
        },
      ),
    );
  }

  Widget buildReportList(double width, ReportProvider sample) {
    var mediaQuery = MediaQuery.of(context);
    return FutureBuilder(
        future: _getSample,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
                height: MediaQuery.of(context).size.height / 1.8,
                child: Center(
                    child: SpinKitDoubleBounce(color: Colors.grey)));
          } else if (sample.listDetail2.length == 0) {
            return NoDataWidget(mediaQuery: mediaQuery);
          } else {
            return Column(
              children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: sample.listDetail2.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return KitServiceItemWidget(
                          model: sample.listDetail2
                              .elementAt(index));
                    }),
                SizedBox(height: 20),

              ],
            );
          }

        });
  }

  Widget buildListMember(double width, MemberProvider prov) {
    return FutureBuilder(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (prov.listMember.length == 0) {
              return SizedBox(
                  height: width * 0.33,
                  child: Center(child: Text("Belum ada member")));
            } else {
              return SizedBox(
                height: width * 0.33,
                child: prov.listMember.length == 0
                    ? Center(child: Text("Belum ada member"))
                    : prov.isLoading == true ? LoadingWidget()

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
          } else if(snap.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                Container(
                  height: 125,
                  child: Center(
                      child: CupertinoActivityIndicator(radius: 10)),
                ),
              ],
            );
          } else {
            return SizedBox(height: 125);
          }
        });
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key key,
    @required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Container(
              width: mediaQuery.size.width / 1,
              padding: EdgeInsets.only(
                bottom: 16,
                left: 16,
                right: 16,
              ),
              decoration: new BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text(
                    "Harap menghubungi Support Genetics Indonesia\nuntuk menampilkan report kamu",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
