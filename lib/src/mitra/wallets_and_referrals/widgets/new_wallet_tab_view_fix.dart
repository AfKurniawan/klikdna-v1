import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/models/wallet_model.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewWalletTabViewFix extends StatefulWidget {

  @override
  _NewWalletTabViewFixState createState() => _NewWalletTabViewFixState();
}

class _NewWalletTabViewFixState extends State<NewWalletTabViewFix> {

  bool isLoading ;
  bool isError ;
  List<Wallet> listWalletData = [];
  int sum = 0;
  var totalFormattedCommision = new NumberFormat.currency(name: "", locale: "en_US");
  var totalsum ;
  var komisi = "";
  String  dropdownValueFirst="One";

  ScrollController controller;
  final _all = <Wallet>[];
  final _saved = new Set<Wallet>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Wallet> _healthDataList = [];

  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime(2020, 01, 01);

  List<Wallet> healthData;

  final items = List<Wallet>();

  int present = 0;
  int perPage = 2;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchData();
    controller = new ScrollController()..addListener(_scrollListener);
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }



  fetchData() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, onResponse);
  }


  Future<void> onResponse() async {
    getWalletData();
    setState(() {
      controller = new ScrollController()..addListener(_scrollListener);
      isLoading = false;
      _all.addAll(_healthDataList);
      if((present + perPage )> _all.length) {
        items.addAll(
            _healthDataList.getRange(present, _all.length));
      } else {
        items.addAll(
            _all.getRange(present, present + perPage));
      }
      present = present + perPage;
    });

  }




  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      loadMore();
    }
  }

  loadMore() {
    setState(() {
      if((present + perPage )> _all.length) {
        items.addAll(
            listWalletData.getRange(present, _all.length));
      } else {
        items.addAll(
            _all.getRange(present, present + perPage));
      }
      present = present + perPage;
    });

  }



  Future<List<Wallet>> getWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    print("LOADING $isLoading");

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

      var allArray = json.decode(response.body);
      var dataArray = allArray['data'] as List;

      setState(() {
        controller = new ScrollController()..addListener(_scrollListener);
        listWalletData = dataArray.map<Wallet>((j) => Wallet.fromJson(j)).toList();
        isLoading = false ;
        isError = false ;

        if(listWalletData.length == 0){
          sum = 0;
        } else {
          sum = listWalletData.map((e) => e.nominal).reduce((value, element) => value + element);
        }


        print("Sum : $sum");
        totalsum = totalFormattedCommision.format(sum);
        komisi = prefs.getString("commission");
        print("SUM $totalsum");
        print("JUMLAH KOMISI $komisi");
      });


    } else {

      setState(() {
        isError = true ;
        isLoading = false ;
      });

    }

  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: controller,
        child: Consumer<WalletReferralProvider>(
          builder: (context, wallet, _){
            return listWalletData.length == 0 ? Container()
            : Container(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 20, left: 12, right: 12, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Colors.grey[700].withOpacity(0.32),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: wallet.tipeValue == "Semua Data" ?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              komisi == null
                                  ? "0"
                                  : "IDR ${komisi.split(".")[0].replaceAll("-", "")}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: MyColors.dnaGreen2,
                                  fontWeight:
                                  FontWeight.bold)),
                          SizedBox(height: 5),
                          Text("Saldo Anda"),
                        ],
                      )
                     : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 5),
                                wallet.tipeValue.contains("Referral")
                                    ? Container(
                                    child: Text(totalsum == null ? "0" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.dnaBadge,
                                            fontWeight: FontWeight.bold)))
                                    : wallet.tipeValue.contains("Royalti")
                                    ? Container(
                                    child: Text(totalsum == null ? "" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.dnaBadge,
                                            fontWeight: FontWeight.bold)))
                                    : wallet.tipeValue.contains("Tim")
                                    ? Container(
                                    child: Text(totalsum == null ? "" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.dnaBadge,
                                            fontWeight: FontWeight.bold)))
                                    : wallet.tipeValue.contains("Penarikan")
                                    ? Container(child: Text(totalsum == null ? "" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}", style: TextStyle(fontSize: 16, color: MyColors.dnaBadge, fontWeight: FontWeight.bold)))
                                    : wallet.tipeValue.contains("National")
                                    ? Container(child: Text(totalsum == null ? "" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}", style: TextStyle(fontSize: 16, color: MyColors.dnaBadge, fontWeight: FontWeight.bold)))
                                    : Container(child: Text("0", style: TextStyle(fontSize: 16, color: MyColors.dnaBadge, fontWeight: FontWeight.bold))),
                                SizedBox(height: 5),
                                wallet.tipeValue.contains("Referral")
                                    ? Text("Komisi Referral")
                                    : wallet.tipeValue.contains("Tim")
                                    ? Text("Komisi Tim")
                                    : wallet.tipeValue.contains("Royalti")
                                    ? Text("Komisi Royalti")
                                    : wallet.tipeValue.contains("National")
                                    ? Text("National Sharing")
                                    : wallet.tipeValue.contains("Star Maker")
                                    ? Text("Star Maker")
                                    : wallet.tipeValue.contains("Penarikan")
                                    ? Text("Penarikan")
                                    : "",
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 2,
                              color: Colors.grey,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text(
                                        komisi == null
                                            ? ""
                                            : "IDR ${komisi.split(".")[0].replaceAll("-", "")}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.dnaGreen2,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(height: 5),
                                Text("Saldo Anda"),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Text("Transaksi",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(height: 5),
                            Container(
                                child: Text(
                                    "Total ${listWalletData.length} Transaksi"))
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Provider.of<WalletReferralProvider>(context, listen: false).showBottomSheetFilter(context);
                          },
                          splashColor: Colors.blueGrey,
                          child: Container(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/icons/sorting_wallet_referral.png",
                                height: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  isLoading == true
                      ? Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Center(
                          child: SpinKitDoubleBounce(color: Colors.grey)))
                      : listWalletData.length == 0
                      ? Container(
                      height: MediaQuery.of(context).size.height / 1.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height / 30),
                          Container(
                            child: Image.asset(
                                "assets/images/no_patient_card.png",
                                width: 200),
                          ),
                          Container(
                            width: 300,
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
                              mainAxisSize: MainAxisSize
                                  .min, // To make the card compact
                              children: <Widget>[
                                Text(
                                  "Tidak ada data transaksi",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listWalletData.length == 0
                        ? 0
                        : listWalletData.length,
                    itemBuilder: (context, index) {
                      var formatTgl = DateFormat('dd MMMM yyyy', "id_ID");
                      var parsedDate = DateTime.parse(listWalletData[index].created).toLocal();
                      String dateCreated = '${formatTgl.format(parsedDate)}';
                      String fnominal = NumberFormat.currency(name: '')
                          .format(listWalletData[index].nominal)
                          .split(".")[0]
                          .replaceAll(",", ".");
                      return listWalletData[index].status.contains("Selesai")
                          ? Container(
                          color: Color(0xffEDF0F4),
                          padding: EdgeInsets.only(top: 18),
                          child: wallet.tipeValue.contains("Semua")
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// COLOR
                              // #FF7D67  < National Sharing
                              // #006971 < Referal
                              // #B5CCD5 < Tim
                              // #359389 < Royalti

                              Container(
                                width: 156,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: listWalletData[index].type
                                      .contains("Tim")
                                      ? Color(0xffB5CCD5)
                                      : listWalletData[index].type
                                      .contains("Referral")
                                      ? Color(0xff006971)
                                      : listWalletData[index].type
                                      .contains("Royalti")
                                      ? Color(0xff359389)
                                      : listWalletData[index].type.contains("Withdraw")
                                      ? Color(0xffD7516A)
                                      : listWalletData[index].type.contains("Star")
                                      ? Color(0xff006971)
                                      : listWalletData[index].type.contains("National")
                                      ? Color(0xffFF7D67)
                                      : Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                ),
                                child: Center(
                                  child: Text(
                                      "${listWalletData[index].type}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 70,
                                margin: EdgeInsets.only(
                                    bottom: 10, left: 18, right: 18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                      color: Colors.grey[700].withOpacity(0.5),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("$dateCreated", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                          Text("${listWalletData[index].from}", style: TextStyle(fontSize: 10))
                                        ],
                                      ),
                                      listWalletData[index].type.contains("Withdraw")
                                          ? Row(
                                        children: [
                                          Icon(Icons.arrow_downward,
                                              size: 15,
                                              color: Colors.redAccent),
                                          SizedBox(width: 3),
                                          Text("Out",
                                              style: TextStyle(
                                                  color: Colors.redAccent))
                                        ],
                                      )
                                          : Row(
                                        children: [
                                          Icon(Icons.arrow_upward,
                                              size: 15,
                                              color: Colors.green),
                                          SizedBox(width: 3),
                                          Text("In",
                                              style: TextStyle(
                                                  color: Colors.green))
                                        ],
                                      ),
                                      Text(
                                          'IDR $fnominal'.replaceAll("-", ""),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 156,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: listWalletData[index].type.contains("Tim")
                                      ? Color(0xffB5CCD5)
                                      : listWalletData[index].type.contains("Referral")
                                      ? Color(0xff29656C)
                                      : listWalletData[index].type.contains("Royalti")
                                      ? Color(0xffEF846E)
                                      : listWalletData[index].type.contains("Star")
                                      ? Color(0xff006971)
                                      : listWalletData[index].type.contains("Withdraw")
                                      ? Color(0xffD7516A)
                                      : listWalletData[index].type.contains("National")
                                      ? Color(0xffFF7D67)
                                      : Colors.white12,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 13.0, left: 10),
                                  child: Text(
                                      listWalletData[index].type.contains("Withdraw")
                                          ? "Penarikan"
                                          : "${listWalletData[index].type}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 75,
                                margin: EdgeInsets.only(
                                    bottom: 10, left: 18, right: 18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 3,
                                      color:
                                      Colors.grey[700].withOpacity(0.32),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("$dateCreated", style: TextStyle(fontWeight: FontWeight.bold)),
                                          //Text("${wallet.listWalletData[index].from}", style: TextStyle(fontSize: 12))
                                        ],
                                      ),
                                      listWalletData[index].type.contains("Withdraw")
                                          ? Row(
                                        children: [
                                          Icon(Icons.arrow_downward,
                                              size: 15,
                                              color: Colors.redAccent),
                                          SizedBox(width: 3),
                                          Text("Out",
                                              style: TextStyle(
                                                  color: Colors.redAccent))
                                        ],
                                      )
                                          : Row(
                                        children: [
                                          Icon(Icons.arrow_upward,
                                              size: 15,
                                              color: Colors.green),
                                          SizedBox(width: 3),
                                          Text("In",
                                              style: TextStyle(
                                                  color: Colors.green))
                                        ],
                                      ),
                                      Text(
                                          'IDR $fnominal'.replaceAll("-", ""),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ))
                          : Container(color: Colors.blue, height: 0);
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          },
        ));
  }
}
