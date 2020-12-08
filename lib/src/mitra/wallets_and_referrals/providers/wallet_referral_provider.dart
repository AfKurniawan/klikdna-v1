import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/models/referral_model.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/models/wallet_model.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;


class WalletReferralProvider with ChangeNotifier {

  bool isTai ;
  bool isError ;
  List<Wallet> listWalletData = [];
  int sum = 0;
  var totalFormattedCommision = new NumberFormat.currency(name: "", locale: "en_US");
  var totalsum ;
  var komisi = "";
  String  dropdownValueFirst="One";

  Future<WalletModel> getWalletData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isTai = true;
    notifyListeners();
    print("ISTAI $isTai");

    var url = AppConstants.GET_WALLET_URL;
    var body = json.encode({
      "accesskey" : prefs.getString("accesskey")
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseJson = WalletModel.fromJson(json.decode(response.body));

    if(response.statusCode == 200){

      //print("RESPONSE BODY GET WALLET: ${response.body}");

      var allArray = json.decode(response.body);
      var dataArray = allArray['data'] as List;
      listWalletData = dataArray.map<Wallet>((j) => Wallet.fromJson(j)).toList();
      isTai = false ;
      isError = false ;


      sum = listWalletData.map((e) => e.nominal).reduce((value, element) => value + element);

      print("Sum : $sum");

      totalsum = totalFormattedCommision.format(sum);

      komisi = prefs.getString("commission");



      notifyListeners();
      print("SUM $totalsum");
      print("JUMLAH KOMISI $komisi");


    } else {
      isError = true ;
      isTai = false ;
      notifyListeners();

    }

    return responseJson;
  }


  Future<WalletModel> filterWalletData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isTai = true;
    notifyListeners();
    print("ISLOADING $isTai");

    var url = AppConstants.GET_WALLET_URL;
    var body = json.encode({
      "accesskey" : prefs.getString("accesskey"),
      "type_id": result,
      "datefrom": datefromController.text,
      "dateto" : datetoController.text
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseJson = WalletModel.fromJson(json.decode(response.body));

    if(response.statusCode == 200){


      print("RESPONSE BODY GET WALLET: ${response.body}");

      var allArray = json.decode(response.body);
      var dataArray = allArray['data'] as List;

      listWalletData = dataArray.map<Wallet>((j) => Wallet.fromJson(j)).toList();
      isTai = false ;
      isError = false ;

      var myStatus = listWalletData.map((e) => e.status);

      myStatus.forEach((w){
        if(w.contains("Selesai"))
          sum = listWalletData.map((e) => e.nominal).reduce((value, element) => value + element);
          totalsum = totalFormattedCommision.format(sum);
      });

      notifyListeners();


    } else {
      isError = true ;
      isTai = false ;
      notifyListeners();

    }


    return responseJson;
  }

  clearFilter(){
    datefromController.clear();
    datetoController.clear();
    tipeValue = "Semua Data" ;
    notifyListeners();
  }

  clearDateFilter(){
    datefromController.clear();
    datetoController.clear();
    notifyListeners();
  }





  TextEditingController datefromController = new TextEditingController();
  TextEditingController datetoController = new TextEditingController();
  String searchDialogSource;


  showBottomSheetFilter(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Container(
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Filter", style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),)),
                        ),
                        Row(
                          children: [
                            Text("Batalkan"),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                clearDateFilter();
                              },
                              icon: Icon(Icons.clear),
                            )
                          ],
                        ),

                      ],
                    ),

                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Filter Tanggal",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: DateTimeField(
                              style: TextStyle(
                                color: MyColors.dnaBlack,
                              ),
                              format: format,
                              controller: datefromController,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.event_note, color: Colors.grey),
                                  labelText: "Mulai Tanggal",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  alignLabelWithHint: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyColors.dnaGreen, width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red[300], width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red[300], width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusColor: MyColors.dnaGreen,
                                  hintText: "",
                                  hintStyle:
                                  TextStyle(color: Colors.white54, fontSize: 12)),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: DateTimeField(
                              style: TextStyle(
                                color: MyColors.dnaBlack,
                              ),
                              format: format,
                              controller: datetoController,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.event_note, color: Colors.grey),
                                  labelText: "Sampai Tanggal",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  alignLabelWithHint: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyColors.dnaGreen, width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red[300], width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red[300], width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 1.5),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  focusColor: MyColors.dnaGreen,
                                  hintText: "",
                                  hintStyle:
                                  TextStyle(color: Colors.white54, fontSize: 12)),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 60,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Semua Data'),
                                value: tipeValue,
                                underline: Container(),
                                items: deviceTypes.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value,
                                      style: TextStyle(fontWeight: FontWeight.normal),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    _handleRadioValueChange(value);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height > 780 ? MediaQuery.of(context).size.height / 4 : MediaQuery.of(context).size.height / 7),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Material(
                        color: MyColors.dnaGreen,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: (){
                            filterWalletData(context);
                            clearDateFilter();
                            Navigator.of(context).pop();
                          },
                          splashColor: Colors.white,
                          child: Ink(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: MyColors.dnaGreen

                            ),
                            child: Center(
                              child: Text(
                                "Tampilkan Hasil",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }


  String tipeValue = "Semua Data" ;
  String result;

  List<String> deviceTypes = ["Semua Data", "Komisi Referral", "Komisi Tim", "Komisi Royalti", "National Sharing", "Withdraw"];

  void _handleRadioValueChange(String value) {
      tipeValue = value;
      switch (tipeValue) {
        case "Semua Data":
          result = "";
          print("RESULT $result");
          break;
        case "Komisi Referral":
          result = "1";
          print("RESULT $result");
          break;
        case "Komisi Tim":
          result = "2";
          print("RESULT $result");
          break;
        case "Komisi Royalti":
          result = "3";
          print("RESULT $result");
          break;
        case "National Sharing":
          result = "4";
          print("RESULT $result");
          break;
        case "Withdraw":
          result = "5";
          print("RESULT $result");
          break;
      }
      notifyListeners();
  }

  List<Referral> listReferralData = [];
  bool isReferralError ;
  Future<ReferralModel> getReferralData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();

    var url = AppConstants.GET_REFERRAL_URL;
    var body = json.encode({
      "accesskey" : prefs.getString("accesskey"),
      "type_id": result,
      "datefrom": datefromController.text,
      "dateto" : datetoController.text
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseReferral = ReferralModel.fromJson(json.decode(response.body));

    if(response.statusCode == 200){

      //print("RESPONSE BODY GET REFERRAL: ${response.body}");
      var allArray = json.decode(response.body);
      var dataArray = allArray['data'] as List;
      listReferralData = dataArray.map<Referral>((j) => Referral.fromJson(j)).toList();
      isReferralError = false ;
      notifyListeners();


    } else {
      isReferralError = true ;
      notifyListeners();

    }

    return responseReferral;
  }



}