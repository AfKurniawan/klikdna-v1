import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
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
  String name ;
  @override
  void initState() {
    Provider.of<DetailReportProvider>(context, listen: false).getDetailReport(context, widget.model.reportId);
    name = Provider.of<AccountProvider>(context, listen: false).name;
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
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Consumer<MemberProvider>(
                          builder: (context, account, _) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width /1.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Hello",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300)),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                              account.newMemberName == ""
                                                  ? name
                                                  : account.newMemberName,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text("Berikut ini merupakan hasil report DNAku ${widget.model.serviceName} kamu.",
                                    style: TextStyle(color: Colors.white),
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
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 120),
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
                                : sample.reportDetail.length == 0
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.7,
                                        child: Center(
                                          child: Text("Belum Ada Report",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ),
                                      )
                                    :  sample.searchResult.length != 0 ? buildSearchList(sample)
                                    : buildListView(sample);
                            //buildListView(sample);
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




  ListView buildListView(DetailReportProvider sample) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sample.reportDetail.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return KitServiceItemWidget(
              model: sample.reportDetail.elementAt(index));
        });
  }

  Widget buildSearchList(DetailReportProvider sample) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sample.searchResult.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          print("SEACRH RESULT: ${sample.searchResult.length}");
          return sample.searchResult.length == 0 ? Container(
            height:
            MediaQuery.of(context).size.height /
                1.7,
            child: Center(
              child: Text("Belum Ada Report",
                  style: TextStyle(
                      color: Colors.grey)),
            ),
          ) : KitServiceItemWidget(
              model: sample.searchResult.elementAt(index));
        });
  }

  onCheckedValue(String text, bool checked) async {
    final sample = Provider.of<DetailReportProvider>(context, listen: false);
    sample.searchResult.clear();
    if(text == '1' && checked == true){
      setState(() {
        sample.reportDetail.sort((a, b) => a.namaModul.compareTo(b.namaModul));
      });
    } else if(text == '1' && checked == false){
      setState(() {
        sample.reportDetail.sort((b, a) => a.namaModul.compareTo(b.namaModul));
      });
    } else if(text == "2" && checked == true) {
      setState(() {
        sample.reportDetail.forEach((item) {
          if (item.hasilKamu.contains('Rendah') && item.hasilKamu.contains('Sedang')) {
            setState(() {
              sample.searchResult.add(item);
              sample.searchResult.sort((a, b) => item.namaModul.compareTo(item.namaModul));
            });
          }
        });
      });
    }






  }

  List<CheckBoxData> checkboxDataList = [
    new CheckBoxData(id: '1', displayId: 'Alphabet', checked: false),
    new CheckBoxData(id: '2', displayId: 'Resiko Rendah - Resiko Tinggi', checked: false),
  ];

  clearSelectedFilter(){
    checkboxDataList.clear();
  }

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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: checkboxDataList.map<Widget>(
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
                                        onCheckedValue(data.id, data.checked);
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      ),
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

class MemberItemWidget extends StatelessWidget {
  final Member member;

  MemberItemWidget({Key key, this.member}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ReportProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        print("Widget: ${member.personId}");
        prov.getSample(context, member.personId);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/dummy_user.jpeg',
                //model.name,
                fit: BoxFit.fill,
                height: width * 0.2,
                width: width * 0.2,
              ),
            ),
            // SizedBox(
            //   height: 4,
            // ),
            Text(member.name)
          ],
        ),
      ),
    );
  }
}

class KitServiceItemWidget extends StatefulWidget {
  final ReportDetail model;

  KitServiceItemWidget({Key key, this.model}) : super(key: key);

  @override
  _KitServiceItemWidgetState createState() => _KitServiceItemWidgetState();
}

class _KitServiceItemWidgetState extends State<KitServiceItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15),
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
                .pushNamed('hasil_report_page', arguments: widget.model);
          },
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  widget.model.gambarJudul == null ? Container() :
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14.0, top: 10, bottom: 20),
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 40,
                      width: 40,
                      child: CachedNetworkImage(
                          imageUrl: widget.model.gambarJudul),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.model.namaModul,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: MyColors.dnaGrey)),
                        Text("Beresiko ${widget.model.hasilKamu}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: widget.model.hasilKamu == "Tinggi"
                                    ? Colors.red
                                    : Colors.lightBlue)),
                      ],
                    ),
                  ),

                  // Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: (){

                    }
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


