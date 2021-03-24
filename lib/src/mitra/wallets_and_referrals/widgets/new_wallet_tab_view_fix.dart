import 'dart:convert';
import 'dart:ui';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/models/wallet_model.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/styles/text_styles.dart';
import 'package:new_klikdna/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewWalletTabViewFix extends StatefulWidget {
  final Future future;

  NewWalletTabViewFix({Key key, @required this.future}) : super(key: key);

  @override
  _NewWalletTabViewFixState createState() => _NewWalletTabViewFixState();
}

class _NewWalletTabViewFixState extends State<NewWalletTabViewFix> {
  var items = List<Wallet>();

  int present = 0;
  int perPage = 4;

  @override
  void initState() {
    super.initState();
    getWalletDatax();
  }

  List<Wallet> walletMapMapArray = [];
  List<Wallet> walletArray;

  int sum = 0;
  var totalFormattedCommision =
      new NumberFormat.currency(name: "", locale: "en_US");
  var totalsum;
  var komisi = "";
  List<Wallet> listWalletData = [];

  bool isLoading;
  Future<List<Wallet>> getWalletDatax() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    print("LOADING $isLoading");

    var url = AppConstants.GET_WALLET_URL;
    var body = json.encode({"accesskey": prefs.getString("accesskey")});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseJson = WalletModel.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      var allArray = json.decode(response.body);
      var dataArray = allArray['data'] as List;

      setState(() {
        walletMapMapArray =
            dataArray.map<Wallet>((j) => Wallet.fromJson(j)).toList();
        listWalletData =
            walletMapMapArray.where((i) => i.status == "Selesai").toList();
        isLoading = false;
        if (listWalletData.length != 0) {
          items.addAll(listWalletData.getRange(present, present + perPage));
          present = present + perPage;
        }
      });

      if (items.length == 0) {
        sum = 0;
      } else {
        sum = items
            .map((e) => e.nominal)
            .reduce((value, element) => value + element);
      }

      print("Sum : $sum");

      totalsum = totalFormattedCommision.format(sum);
      komisi = prefs.getString("commission");

      print("SUM $totalsum");
      print("JUMLAH KOMISI $komisi");
    } else {
      isLoading = false;
    }
  }

  var count;
  var filterSum;
  bool isFiltered = false;

  Future<WalletModel> filterWalletDataxx(BuildContext context) async {
    listWalletData.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    print("TYPE RESSSSS--> $result");

    print("LIST WALLET DATA --> ${listWalletData.length}");

    var url = AppConstants.GET_WALLET_URL;
    var body = json.encode({
      "accesskey": prefs.getString("accesskey"),
      "type_id": result,
      "datefrom": datefromController.text,
      "dateto": datetoController.text
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseJson = WalletModel.fromJson(json.decode(response.body));

    if (response.statusCode == 200) {
      setState(() {
        var allArray = json.decode(response.body);
        var dataArray = allArray['data'] as List;
        walletMapMapArray =
            dataArray.map<Wallet>((j) => Wallet.fromJson(j)).toList();
        listWalletData =
            walletMapMapArray.where((i) => i.status == "Selesai").toList();

        isLoading = false;
        isFiltered = true ;

        print(
            "LIST WALLET DATA AFTER FILTERING >>>>>>>>>>> ${listWalletData.length} AND STATUS FILTERED >> $isFiltered");

        if (listWalletData.length == 0) {
          sum = 0;
        } else {
          sum = listWalletData
              .map((e) => e.nominal)
              .reduce((value, element) => value + element);
        }

        print("Sum : $sum");

        totalsum = totalFormattedCommision.format(sum);

        komisi = prefs.getString("commission");

        print("SUM FILTER $totalsum");
        print("JUMLAH KOMISI FILTER $komisi");


        if(datefromController.text.isNotEmpty || datetoController.text.isNotEmpty){
          var formatTgl = DateFormat('dd MMMM yyyy', "id_ID");
          var parsedDateFrom = DateTime.parse(datefromController.text).toLocal();
          var parsedDateTo = DateTime.parse(datetoController.text).toLocal();
         setState(() {
           datefrom = '${formatTgl.format(parsedDateFrom)}';
           dateto = '${formatTgl.format(parsedDateTo)}';
         });

        }


      });
    } else {
      isLoading = false;
    }

    return responseJson;
  }

  clearFilter() {
    datefromController.clear();
    datetoController.clear();
    tipeValue = "Semua Data";
  }

  clearDateFilter() {
    datefromController.clear();
    datetoController.clear();
  }

  String datefrom;
  String dateto;

  formatDate(){

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
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
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
                                child: Text(
                                  "Filter",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
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
                                    suffixIcon: Icon(Icons.event_note,
                                        color: Colors.grey),
                                    labelText: "Mulai Tanggal",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    alignLabelWithHint: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.dnaGreen, width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red[300], width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red[300], width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusColor: MyColors.dnaGreen,
                                    hintText: "",
                                    hintStyle: TextStyle(
                                        color: Colors.white54, fontSize: 12)),
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
                                    suffixIcon: Icon(Icons.event_note,
                                        color: Colors.grey),
                                    labelText: "Sampai Tanggal",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    alignLabelWithHint: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyColors.dnaGreen, width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red[300], width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red[300], width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    focusColor: MyColors.dnaGreen,
                                    hintText: "",
                                    hintStyle: TextStyle(
                                        color: Colors.white54, fontSize: 12)),
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
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
                                  items: walletType.map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(
                                        value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    setState(() {
                                      _handleRadioValueChange(context, value);
                                      print("VALUEEEE $value");
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height > 780
                              ? MediaQuery.of(context).size.height / 4
                              : MediaQuery.of(context).size.height / 7),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Material(
                          color: MyColors.dnaGreen,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              filterWalletDataxx(context);
                              Navigator.of(context).pop();
                              print("VALUEEEE $tipeValue");
                            },
                            splashColor: Colors.white,
                            child: Ink(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: MyColors.dnaGreen),
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
            ),
          );
        });
  }

  String tipeValue = "Semua Data";
  String result;
  List<Wallet> walletlength = [];

  List<String> walletType = [
    "Semua Data",
    "Komisi Referral",
    "Komisi Tim",
    "Komisi Royalti",
    "National Sharing",
    "Withdraw"
  ];

  void _handleRadioValueChange(BuildContext context, String value) {
    tipeValue = value;
    switch (tipeValue) {
      case "Semua Data":
        result = "";
        getWalletDatax();
        filterWalletDataxx(context);
        print("RESULT $result");
        break;
      case "Komisi Referral":
        result = "1";
        totalsum = "...";
        filterWalletDataxx(context);
        print("RESULT $result");
        break;
      case "Komisi Tim":
        result = "2";
        totalsum = "...";
        filterWalletDataxx(context);
        print("RESULT $result");
        break;
      case "Komisi Royalti":
        result = "3";
        totalsum = "...";
        filterWalletDataxx(context);
        print("RESULT $result");
        break;
      case "National Sharing":
        result = "4";
        totalsum = "...";
        filterWalletDataxx(context);
        print("RESULT $result");
        break;
      case "Withdraw":
        result = "5";
        totalsum = "...";
        filterWalletDataxx(context);
        print("RESULT $result");
        break;
    }
  }

  void loadMore() async {
    print("LOAD MORE");
    setState(() {
      if (listWalletData.length < (present + perPage)) {
        items.addAll(listWalletData.getRange(present, listWalletData.length));
      } else {
        items.addAll(listWalletData.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletReferralProvider>(
      builder: (context, wallet, _) {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              loadMore();
            }
            return true;
          },
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                        padding:
                        EdgeInsets.only(left: 18.0, right: 18, top: 20),
                        child: listWalletData.length == 0
                            ? Container()
                            : tipeValue == "Semua Data"
                            ? allDataSaldoCard(context)
                            : isFiltered == true ? filteredDataSaldoCard(context, wallet) : allDataSaldoCard(context)),
                    buildFilterButtonRow(context),
                    buildFutureBuilder(),
                    SizedBox(height: 30),
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget buildFutureBuilder() {
    print("ITEM LENGHT --> ${items.length}");
    print("PRESENT LENGHT --> $present");
    print("PER PAGE LENGHT --> $perPage");
    var mediaQuery = MediaQuery.of(context);
    WalletReferralProvider wallet;
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (isLoading == true) {
          return Container(
              height: mediaQuery.size.height / 1.5, child: LoadingWidget());
        } else if (snapshot.hasData || listWalletData.length > 0) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listWalletData.length < perPage
                ? listWalletData.length
                : (present <= listWalletData.length)
                ? items.length + 1
                : listWalletData.length,
            itemBuilder: (context, index) {
              var formatTgl = DateFormat('dd MMMM yyyy', "id_ID");
              var parsedDate =
              DateTime.parse(listWalletData[index].created).toLocal();
              String dateCreated = '${formatTgl.format(parsedDate)}';
              String fnominal = NumberFormat.currency(name: '')
                  .format(listWalletData[index].nominal)
                  .split(".")[0]
                  .replaceAll(",", ".");
              return (index == items.length)
                  ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SpinKitDoubleBounce(
                  size: 30,
                  color: MyColors.dnaGreen,
                ),
              )
                  : Container(
                //color: Color(0xffEDF0F4),
                  padding: EdgeInsets.only(top: 18),
                  child: tipeValue.contains("Semua")
                      ? allWalletData(index, context, dateCreated, fnominal)
                      : filteredWalledData(
                      index, context, dateCreated, fnominal));
            },
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18),
            child: Column(
              children: [
                isFiltered == true ? filteredDataSaldoCard(context, wallet) : allDataSaldoCard(context),
                Row(
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
                                    fontSize: 16, fontWeight: FontWeight.w500))),
                        SizedBox(height: 5),
                        Container(
                            child: Text(
                                "Total ${listWalletData.length == 0 ? 0 : listWalletData.length} Transaksi",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                            ))
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showBottomSheetFilter(context);
                        clearFilter();
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
                NoDataWidget(
                  mediaQuery: mediaQuery,
                  height: MediaQuery.of(context).size.height / 2.5,
                  datefrom: datefrom == null ? "" : "$datefrom",
                  dateto: dateto == null ? "" : "$dateto",
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildFilterButtonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18),
      child: Visibility(
        visible: listWalletData.length == 0 || items.length == 0 ? false : true,
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
                            fontSize: 16, fontWeight: FontWeight.w500))),
                SizedBox(height: 8),
                Container(
                    child: datefromController.text.isNotEmpty ? Text("$datefrom - $dateto",
                        style: (TextStyle(fontSize: 12, fontWeight: FontWeight.w300)))
                    : Text(
                        "Total ${listWalletData.length == 0 ? 0 : listWalletData.length} Transaksi",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ))
              ],
            ),
            InkWell(
              onTap: () {
                clearFilter();
                showBottomSheetFilter(context);
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
    );
  }

  Widget filteredDataSaldoCard(BuildContext context, WalletReferralProvider wallet) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 5,
            color: Colors.grey[500].withOpacity(0.2),
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                tipeValue.contains("Referral")
                    ? Container(
                        child: Text(
                            totalsum == null
                                ? "0"
                                : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}",
                            style: TextStyle(
                                fontSize: 16,
                                color: MyColors.dnaBadge,
                                fontWeight: FontWeight.w500)))
                    : tipeValue.contains("Royalti")
                        ? Container(
                            child: Text(totalsum == null ? "" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyColors.dnaBadge,
                                    fontWeight: FontWeight.w500)))
                        : tipeValue.contains("Tim")
                            ? Container(
                                child: Text(totalsum == null ? "" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: MyColors.dnaBadge,
                                        fontWeight: FontWeight.w500)))
                            : tipeValue.contains("Withdraw")
                                ? Container(
                                    child: Text(totalsum == null ? "" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.dnaBadge,
                                            fontWeight: FontWeight.w500)))
                                : tipeValue.contains("National")
                                    ? Container(
                                        child: Text(totalsum == null ? "" : "IDR ${totalsum.split(".")[0].replaceAll("-", "")}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: MyColors.dnaBadge,
                                                fontWeight: FontWeight.w500)))
                                    : Container(
                                          child: Text("0",
                                             style: TextStyle(fontSize: 16,
                                                 color: MyColors.dnaBadge,
                                                 fontWeight: FontWeight.w500))),
                SizedBox(height: 8),
                Text(
                  tipeValue.contains("Referral")
                      ? "Komisi Referral"
                      : tipeValue.contains("Tim")
                      ? "Komisi Tim"
                      : tipeValue.contains("Royalti")
                      ? "Komisi Royalti"
                      : tipeValue.contains("National")
                      ? "National Sharing"
                      : tipeValue.contains("Star")
                      ? "Bonus Star Maker"
                      : tipeValue.contains("Withdraw")
                      ? "Withdraw"
                      : "-", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                )
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
                SizedBox(height: 5),
                Container(
                    child: Text(isFiltered == true ? "IDR ${komisi.split(".")[0].replaceAll("-", "")}"
                       : listWalletData.length == 0
                            ? "0"
                            : "IDR ${komisi.split(".")[0].replaceAll("-", "")}",
                        style: TextStyle(
                            fontSize: 16,
                            color: MyColors.dnaGreen2,
                            fontWeight: FontWeight.w500))),
                SizedBox(height: 8),
                Text("Saldo Anda", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget allDataSaldoCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 5,
            color: Colors.grey[500].withOpacity(0.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Text(
                    listWalletData.length == 0
                        ? "IDR 0"
                        : "IDR ${komisi.split(".")[0].replaceAll("-", "")}",
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColors.dnaGreen2,
                        fontWeight: FontWeight.w500))),
            SizedBox(height: 5),
            Text("Saldo Anda", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
          ],
        ),
      ),
    );
  }

  Widget allWalletData(int index, BuildContext context, String dateCreated, String fnominal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 146,
          height: 35,
          decoration: BoxDecoration(
            color: listWalletData[index].type.contains("Tim")
                ? Color(0xffB5CCD5)
                : listWalletData[index].type.contains("Referral")
                    ? Color(0xff006971)
                    : listWalletData[index].type.contains("Royalti")
                        ? Color(0xff359389)
                        : listWalletData[index].type.contains("Withdraw")
                            ? Color(0xffD7516A)
                            : listWalletData[index].type.contains("Star")
                                ? Color(0xff006971)
                                : listWalletData[index]
                                        .type
                                        .contains("National")
                                    ? Color(0xffFF7D67)
                                    : Colors.grey,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text("${listWalletData[index].type}",
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          margin: EdgeInsets.only(bottom: 10, left: 18, right: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                color: Colors.grey[500].withOpacity(0.2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                listWalletData[index].from == ""
                    ? Text("$dateCreated",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$dateCreated",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                          Text("${listWalletData[index].from}",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300))
                        ],
                      ),
                listWalletData[index].type.contains("Withdraw")
                    ? Row(
                        children: [
                          Icon(Icons.arrow_downward,
                              size: 15, color: Colors.redAccent),
                          SizedBox(width: 3),
                          Text("Out", style: TextStyle(color: Colors.redAccent, fontSize: 12))
                        ],
                      )
                    : Row(
                        children: [
                          Icon(Icons.arrow_upward,
                              size: 15, color: Colors.green),
                          SizedBox(width: 3),
                          Text("In", style: TextStyle(color: Colors.green, fontSize: 12))
                        ],
                      ),
                Text('IDR $fnominal'.replaceAll("-", ""),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget filteredWalledData(int index, BuildContext context, String dateCreated, String fnominal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: 35,
          decoration: BoxDecoration(
            color: listWalletData[index].type.contains("Tim")
                ? Color(0xffB5CCD5)
                : listWalletData[index].type.contains("Referral")
                    ? Color(0xff29656C)
                    : listWalletData[index].type.contains("Royalti")
                        ? Color(0xff359389)
                        : listWalletData[index].type.contains("Star")
                            ? Color(0xff006971)
                            : listWalletData[index].type.contains("Withdraw")
                                ? Color(0xffD7516A)
                                : listWalletData[index]
                                        .type
                                        .contains("National")
                                    ? Color(0xffFF7D67)
                                    : Colors.white12,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text("${listWalletData[index].type}",
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          margin: EdgeInsets.only(bottom: 10, left: 15, right: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 5,
                color: Colors.grey[500].withOpacity(0.2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                listWalletData[index].from == ""
                    ? Text("$dateCreated",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$dateCreated",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                          Text("${listWalletData[index].from}",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300))
                        ],
                      ),
                        listWalletData[index].type.contains("Withdraw")
                    ? Row(
                        children: [
                          Icon(Icons.arrow_downward,
                              size: 15, color: Colors.redAccent),
                          SizedBox(width: 3),
                          Text("Out", style: TextStyle(color: Colors.redAccent))
                        ],
                      )
                    : Row(
                        children: [
                          Icon(Icons.arrow_upward,
                              size: 15, color: Colors.green),
                          SizedBox(width: 3),
                          Text("In", style: TextStyle(color: Colors.green))
                        ],
                      ),
                Text('IDR $fnominal'.replaceAll("-", ""),
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key key, @required this.mediaQuery, this.height, this.dateto, this.datefrom})
      : super(key: key);

  final MediaQueryData mediaQuery;
  final double height;
  final String dateto;
  final String datefrom;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Container(
              child:
                  Image.asset("assets/images/no_patient_card.png", width: 200),
            ),
            Container(
              width: mediaQuery.size.width > 600
                  ? mediaQuery.size.width / 2
                  : mediaQuery.size.width / 1,
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
                    "Tidak ada data transaksi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //Text(datefrom == null || dateto == null ? "" : "$datefrom  $dateto")
                ],
              ),
            ),
          ],
        ));
  }
}
