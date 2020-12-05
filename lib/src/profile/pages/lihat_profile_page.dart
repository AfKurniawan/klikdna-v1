import 'dart:io';

import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'package:provider/provider.dart';

class LihatProfilePage extends StatefulWidget {
  @override
  _LihatProfilePageState createState() => _LihatProfilePageState();
}

class _LihatProfilePageState extends State<LihatProfilePage> {
  bool isExpanded = false;

  String _radioValue;
  String result;
  final format = DateFormat("yyyy-MM-dd");

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _handleRadioValueChange(String value) {

    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case "Laki-Laki":
          result = "L";
          break;
        case "Wanita":
          result = "W";
          break;
      }
    });
  }

  @override
  void initState() {
    _radioValue = Provider.of<LoginProvider>(context, listen: false).vgender;
    print("RADIO VALUE: $_radioValue");
    Provider.of<TokenProvider>(context, listen: false).getApiToken();
    Provider.of<PatientCardProvider>(context, listen: false).getPatientCard(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, prov, _){
        return Scaffold(
          key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                "Profil",
                style: TextStyle(color: Colors.grey, fontSize: 16),
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
            ),
            body: prov.isLoading == true
                ? Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(strokeWidth: 2))
                : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 94,
                    decoration: BoxDecoration(
                        color: MyColors.dnaGreen,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: new ColorFilter.mode(
                                MyColors.dnaGreen.withOpacity(0.2),
                                BlendMode.dstATop),
                            image: AssetImage(
                                "assets/images/header_background.png"))),
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
                  ),

                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 10),
                          Text(prov.vallName == null ? "-" : "${prov.vallName}",
                              style: TextStyle(fontSize: 14)),
                          SizedBox(height: 20),
                          Text("Tanggal Lahir", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 10),
                          Text(prov.vbirthdate == null ? "-" : "${prov.vbirthdate}",
                              style: TextStyle(fontSize: 14)),
                          SizedBox(height: 20),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Jenis Kelamin"),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Radio(
                                      value: "Laki-Laki",
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                      focusColor: MyColors.dnaGreen,
                                      activeColor: MyColors.dnaGreen,
                                    ),
                                    Text("Pria"),
                                    SizedBox(width: 20),
                                    Radio(
                                      value: "Wanita",
                                      groupValue: _radioValue,
                                      focusColor: MyColors.dnaGreen,
                                      activeColor: MyColors.dnaGreen,
                                    ),
                                    Text("Wanita")
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("Email", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 10),
                          Text(prov.vprofilEmail == null ? "-" : "${prov.vprofilEmail}",
                              style: TextStyle(fontSize: 14)),
                          SizedBox(height: 20),
                          Text("Nomor Ponsel", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 10),
                          Text(prov.vphone == null ? "-" : "${prov.vphone}",
                              style: TextStyle(fontSize: 14)),
                          SizedBox(height: 20),
                          Text("Alamat", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 10),
                          Text(
                              prov.vallAddress == null ? "-"
                                  : "${prov.vallAddress}", style: TextStyle(fontSize: 14)),
                          SizedBox(height: 20),
                          Text("Alamat ID Digo", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(prov.vreferralUrl == null ? "-" : "${prov.vreferralUrl}",
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(width: 30),
                              IconButton(
                                icon: Icon(Icons.content_copy, size: 15, color: Colors.grey),
                                onPressed: () {
                                  ClipboardManager.copyToClipBoard("${prov.vreferralUrl}")
                                      .then((result) {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text('Alamat ID Digo berhasil di Copy'),
                                          duration: Duration(seconds: 3),
                                        ));
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 8),
                ],
              ),
            )

        );
      },

    );
  }
}
