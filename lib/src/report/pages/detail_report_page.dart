import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/src/report/widgets/detail_service_item.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class DetailReportPage extends StatefulWidget {
  final Detail model;
  final ReportData sample;

  DetailReportPage({Key key, this.model, this.sample}) : super(key: key);

  @override
  _DetailReportPageState createState() => _DetailReportPageState();
}

class _DetailReportPageState extends State<DetailReportPage> {
  String personId = "";
  String name;
  @override
  void initState() {
    name = Provider.of<DetailReportProvider>(context, listen: false).name;
    //Provider.of<TokenProvider>(context, listen: false).getApiToken();
    Provider.of<DetailReportProvider>(context, listen: false)
        .getDetailReport(context, widget.model.reportId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "${widget.model.serviceName} Report",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: MyColors.dnaGreen,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, "detail_report_page");
              Navigator.of(context).pop();
              clearSelectedFilter();
            }),
      ),
      body: prov.isLoading == true
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(strokeWidth: 2))
          : Stack(
              children: <Widget>[
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: MyColors.dnaGreen,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, right: 18, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Consumer<MemberProvider>(
                          builder: (context, account, _) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Hai",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300)),
                                    SizedBox(width: 5),
                                    Text(
                                        account.newMemberName == ""
                                            ? "${account.name}"
                                            : "${account.newMemberName}",
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text(
                                      "Berikut ini merupakan hasil report\nDNA ${widget.model.serviceName} kamu.",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
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
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: model.photoView == null
                                        ? Image.asset(
                                            "assets/images/no_image.png",
                                            height: 72,
                                            width: 72,
                                            fit: BoxFit.cover)
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
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Hasil Kamu",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.dnaGrey)),
                                Row(
                                  children: [
                                    Text("Urutkan",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.dnaGrey)),
                                    SizedBox(width: 10),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
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
                                      child: IconButton(
                                        onPressed: () {
                                          showFilterBottomSheet(context);
                                        },
                                        icon: Icon(Icons.sort, size: 20),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                        SizedBox(height: 20),
                        Consumer<DetailReportProvider>(
                          builder: (context, sample, _) {
                            return sample.isLoading == true
                                ? Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Center(
                                        child: Platform.isIOS
                                            ? CupertinoActivityIndicator()
                                            : CircularProgressIndicator(
                                                strokeWidth: 2)))
                                : sample.searchResult.length != 0
                                    ? buildSearchList(sample, widget.model)
                                    : buildListView(sample, widget.model);
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

  /// NOTE BESAR: DETAIL BELUM SESUAI DENGAN LIST

  ListView buildListView(DetailReportProvider sample, Detail detail) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sample.reportDetail.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return DetailServiceItem(
              model: sample.reportDetail.elementAt(index), detail: detail);
        });
  }

  Widget buildSearchList(DetailReportProvider sample, Detail detail) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sample.searchResult.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          print("SEACRH RESULT: ${sample.searchResult.length}");
          return sample.searchResult.length == 0
              ? Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: Center(
                    child: Text("Belum Ada Report",
                        style: TextStyle(color: Colors.grey)),
                  ),
                )
              : DetailServiceItem(
                  model: sample.searchResult.elementAt(index), detail: detail);
        });
  }

  onCheckedValue(String text, bool checked) async {
    final sample = Provider.of<DetailReportProvider>(context, listen: false);
    sample.searchResult.clear();
    if (text == '1' && checked == true) {
      setState(() {
        sample.reportDetail.sort((a, b) => a.namaModul.compareTo(b.namaModul));
      });
    } else if (text == '1' && checked == false) {
      setState(() {
        sample.reportDetail.sort((b, a) => a.namaModul.compareTo(b.namaModul));
      });
    } else if (text == "2" && checked == true) {
      setState(() {
        sample.reportDetail.sort((b, a) => a.hasilKamu.compareTo(b.hasilKamu));
      });
    } else if (text == "2" && checked == false) {
      setState(() {
        sample.reportDetail.sort((a, b) => a.hasilKamu.compareTo(b.hasilKamu));
        print("FILTER @ NOT CHECKED");
      });
    }
  }

  List<CheckBoxData> checkboxDataListOne = [
    new CheckBoxData(
      id: '1',
      displayId: 'Alphabet',
      checked: false,
    ),
  ];

  List<CheckBoxData> checkboxDataListTwo = [
    new CheckBoxData(
      id: '1',
      displayId: 'Alphabet',
      checked: false,
    ),
    new CheckBoxData(id: '2', displayId: 'Resiko', checked: false),
  ];

  clearSelectedFilter() {
    checkboxDataListTwo.clear();
    checkboxDataListTwo.clear();
  }

  // Health dan Sport tidak ada filter Resiko selainnya ada filter

  void showFilterBottomSheet(context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter state) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Urutkan Berdasarkan: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.model.serviceName == "HEALTH" || widget.model.serviceName == "SKIN"
                            ? Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: checkboxDataListOne.map<Widget>(
                                  (data) {
                                    return Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          CheckboxListTile(
                                            value: data.checked,
                                            title: Text(data.displayId),
                                            onChanged: (bool val) {
                                              state(() {
                                                data.checked = !data.checked;
                                                onCheckedValue(
                                                    data.id, data.checked);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: checkboxDataListTwo.map<Widget>(
                                  (data) {
                                    return Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          CheckboxListTile(
                                            value: data.checked,
                                            title: Text(data.displayId),
                                            onChanged: (bool val) {
                                              state(() {
                                                data.checked = !data.checked;
                                                onCheckedValue(
                                                    data.id, data.checked);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              )
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CheckBoxData {
  String id;
  String displayId;
  bool checked;

  CheckBoxData({
    this.id,
    this.displayId,
    this.checked,
  });

  factory CheckBoxData.fromJson(Map<String, dynamic> json) => CheckBoxData(
        id: json["id"] == null ? null : json["id"],
        displayId: json["displayId"] == null ? null : json["displayId"],
        checked: json["checked"] == null ? null : json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "displayId": displayId == null ? null : displayId,
        "checked": checked == null ? null : checked,
      };
}
