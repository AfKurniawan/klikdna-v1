import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class NewWalletTabView extends StatefulWidget {
  const NewWalletTabView({
    Key key,
    @required this.future,
  }) : super(key: key);

  final Future future;




  @override
  _NewWalletTabViewState createState() => _NewWalletTabViewState();
}

class _NewWalletTabViewState extends State<NewWalletTabView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<WalletReferralProvider>(
      builder: (context, wallet, _) {
        return SingleChildScrollView(
            child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                child: wallet.listWalletData.length == 0
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 30),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(wallet.tipeValue == "Semua Data"
                                  ? "Saldo Anda"
                                  : wallet.tipeValue == null
                                      ? "Saldo Anda"
                                      : "Total ${wallet.tipeValue}"),
                              SizedBox(height: 5),
                              Consumer<WalletReferralProvider>(
                                builder: (child, prov, _) {
                                  return wallet.tipeValue.contains("Referral")
                                      ? Container(
                                          child: Text(
                                              prov.totalsum == null
                                                  ? ""
                                                  : "IDR ${prov.totalsum.split(".")[0].replaceAll("-", "")}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)))
                                      : wallet.tipeValue.contains("Royalti")
                                          ? Container(
                                              child: Text(
                                                  prov.totalsum == null
                                                      ? ""
                                                      : "IDR ${prov.totalsum.split(".")[0].replaceAll("-", "")}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)))
                                          : wallet.tipeValue.contains("Tim")
                                              ? Container(
                                                  child: Text(
                                                      prov.totalsum == null
                                                          ? ""
                                                          : "IDR ${prov.totalsum.split(".")[0].replaceAll("-", "")}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold)))
                                              : wallet.tipeValue
                                                      .contains("Withdraw")
                                                  ? Container(child: Text(prov.totalsum == null ? "" : "IDR ${prov.totalsum.split(".")[0].replaceAll("-", "")}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
                                                  : Container(child: Text(prov.komisi == null ? "" : "IDR ${prov.komisi.split(".")[0].replaceAll("-", "")}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
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
                                "Total ${wallet.listWalletData.length} Transaksi"))
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<WalletReferralProvider>(context,
                                listen: false)
                            .showBottomSheetFilter(context);
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
              wallet.isLoading == true
                  ? Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Center(
                          child: Platform.isIOS
                              ? CupertinoActivityIndicator(radius: 12)
                              : CircularProgressIndicator(strokeWidth: 2)))
                  : wallet.listWalletData.length == 0
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
                                  mainAxisSize: MainAxisSize
                                      .min, // To make the card compact
                                  children: <Widget>[
                                    Text(
                                      "Tidak ada data",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Untuk jenis atau tanggal yang dipilih",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: MyColors.dnaGrey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(height: 16.0),
                                    InkWell(
                                      onTap: () {
                                        Provider.of<WalletReferralProvider>(
                                                context,
                                                listen: false)
                                            .showBottomSheetFilter(context);
                                      },
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width / 2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: MyColors.dnaGreen),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Text(
                                                  "Ulangi",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ))
                      : Consumer<WalletReferralProvider>(
                          builder: (child, wallet, _) {
                            return FutureBuilder(
                                future: widget.future,
                                builder: (context, snapshot) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: wallet.listWalletData.length == 0
                                        ? 0
                                        : wallet.listWalletData.length,
                                    itemBuilder: (context, index) {
                                      var formatTgl =
                                          DateFormat('dd MMMM yyyy');
                                      var parsedDate = DateTime.parse(
                                          wallet.listWalletData[index].created);
                                      String dateCreated =
                                          ('${formatTgl.format(parsedDate)}');
                                      String fnominal =
                                          NumberFormat.currency(name: '')
                                              .format(wallet
                                                  .listWalletData[index]
                                                  .nominal)
                                              .split(".")[0]
                                              .replaceAll(",", ".");
                                      return wallet.listWalletData[index].status
                                              .contains("Selesai")
                                          ? Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  right: 18,
                                                  top: 18),
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
                                                          height: 45,
                                                          decoration: BoxDecoration(
                                                            color: wallet.listWalletData[index].type.contains("Tim") 
                                                                ? Color(0xffB5CCD5)
                                                                : wallet.listWalletData[index].type.contains("Referral")
                                                                ? Color(0xff006971)
                                                                : wallet.listWalletData[index].type.contains("Royalti")
                                                                ? Color(0xff359389)
                                                                : wallet.listWalletData[index].type.contains("Withdraw")
                                                                ? Color(0xffD7516A)
                                                                : wallet.listWalletData[index].type.contains("National")
                                                                ? Color(0xffFF7D67)
                                                                : Colors.white12,
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius.circular(25),
                                                                bottomRight: Radius.circular(25)
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 13.0, left: 10),
                                                            child: Text(wallet.listWalletData[index].type.contains("Withdraw") ? "Penarikan" : "${wallet.listWalletData[index].type}", style: TextStyle(
                                                                color: Colors.white, fontSize: 16
                                                            )),
                                                          ),
                                                        ),
                                                        SizedBox(height: 30),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          height: 70,
                                                          margin: EdgeInsets.only(bottom: 10, left: 18, right: 18),
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
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text("$dateCreated"),
                                                                Row(
                                                                  children: [
                                                                    wallet.listWalletData[index].type.contains("Withdraw")
                                                                        ? Icon(Icons.arrow_circle_down,
                                                                          size: 20,
                                                                          color: Colors.redAccent)
                                                                        : Icon(Icons.arrow_circle_up,
                                                                          size: 20,
                                                                          color: Colors.green)


                                                                  ],
                                                                ),
                                                                Text('IDR $fnominal'.replaceAll("-", ""),
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold
                                                                )),
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
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: wallet.listWalletData[index].type.contains("Tim")
                                                          ? Color(0xffB5CCD5)
                                                          : wallet.listWalletData[index].type.contains("Referral")
                                                          ? Color(0xff29656C)
                                                          : wallet.listWalletData[index].type.contains("Royalti")
                                                          ? Color(0xffEF846E)
                                                          : wallet.listWalletData[index].type.contains("Withdraw")
                                                          ? Color(0xffD7516A)
                                                          : Colors.white12,
                                                      borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(25),
                                                          bottomRight: Radius.circular(25)
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 13.0, left: 10),
                                                      child: Text(wallet.listWalletData[index].type.contains("Withdraw") ? "Penarikan" : "${wallet.listWalletData[index].type}", style: TextStyle(
                                                            color: Colors.white, fontSize: 16
                                                      )),
                                                    ),
                                                  ),
                                                  SizedBox(height: 30),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 70,
                                                    margin: EdgeInsets.only(bottom: 10, left: 18, right: 18),
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
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text("$dateCreated"),
                                                          Row(
                                                            children: [
                                                              wallet.listWalletData[index].type.contains("Withdraw")
                                                                  ? Icon(Icons.arrow_circle_down,
                                                                  size: 20,
                                                                  color: Colors.redAccent)
                                                                  : Icon(Icons.arrow_circle_up,
                                                                  size: 20,
                                                                  color: Colors.green)


                                                            ],
                                                          ),
                                                          Text('IDR $fnominal'.replaceAll("-", ""),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              )
                                      )
                                          : Container(
                                              color: Colors.blue, height: 0);
                                    },
                                  );
                                });
                          },
                        ),
              SizedBox(height: 30),
            ],
          ),
        ));
      },
    );
  }
}
