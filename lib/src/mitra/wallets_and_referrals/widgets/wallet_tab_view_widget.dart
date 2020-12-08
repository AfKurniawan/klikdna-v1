import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class WalletTabViewWidget extends StatefulWidget {
  const WalletTabViewWidget({
    Key key,
    @required this.future,
  }) : super(key: key);

  final Future future;

  @override
  _WalletTabViewWidgetState createState() => _WalletTabViewWidgetState();
}

class _WalletTabViewWidgetState extends State<WalletTabViewWidget> {

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<WalletReferralProvider>(
      builder: (child, wallet, _){
        return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:18.0, right: 18, top: 20),
                    child: wallet.listWalletData.length == 0 ? Container()
                   : Container(
                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Container(
                                  child: Text(
                                      wallet.tipeValue == "Semua Data"
                                          ?  "Saldo Anda"
                                          : wallet.tipeValue == null
                                          ?  "Saldo Anda"
                                          : "${wallet.tipeValue}")
                               ),
                                  SizedBox(height: 5),
                                  Consumer<WalletReferralProvider>(
                                    builder: (child, prov, _){
                                     return wallet.tipeValue.contains("Referral")
                                           ? Container(
                                         child: Text(prov.totalsum == null ? "" : "IDR ${prov.totalsum.split(".")[0].replaceAll("-", "")}",
                                             style: TextStyle(
                                                 fontSize: 16, fontWeight: FontWeight.bold)))
                                           : wallet.tipeValue.contains("Royalti")
                                            ? Container(
                                           child: Text(prov.totalsum == null ? "" : "IDR ${prov.totalsum.split(".")[0].replaceAll("-", "")}",
                                               style: TextStyle(
                                                   fontSize: 16, fontWeight: FontWeight.bold)))
                                           : wallet.tipeValue.contains("Tim")
                                           ? Container(
                                           child: Text(prov.totalsum == null ? "" : "IDR ${prov.totalsum.split(".")[0].replaceAll("-", "")}",
                                               style: TextStyle(
                                                   fontSize: 16, fontWeight: FontWeight.bold)))
                                           : wallet.tipeValue.contains("Withdraw")
                                              ? Container(
                                           child: Text(prov.totalsum == null ? "" : "IDR ${prov.totalsum.split(".")[0].replaceAll("-", "")}",
                                               style: TextStyle(
                                                   fontSize: 16, fontWeight: FontWeight.bold)))
                                           : Container(
                                           child: Text(prov.komisi == null ? "" : "IDR ${prov.komisi.split(".")[0].replaceAll("-", "")}",
                                               style: TextStyle(
                                                   fontSize: 16, fontWeight: FontWeight.bold)));

                                    },
                                  ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Provider.of<WalletReferralProvider>(context, listen: false).showBottomSheetFilter(context);
                            },
                            splashColor: Colors.blueGrey,
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/icons/sorting_wallet_referral.png",
                                  height: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                   ),
                  ),
                    wallet.isTai == true
                    ? Container(
                    height: MediaQuery.of(context).size.height /1.3,
                    child: Center(child: Platform.isIOS ? CupertinoActivityIndicator(radius: 12) : CircularProgressIndicator(strokeWidth: 2)))
                    : wallet.listWalletData.length == 0 ?  Container(
                    height: MediaQuery.of(context).size.height /1.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height / 30 ),
                        Container(
                          child: Image.asset("assets/images/no_patient_card.png" , width: 200),
                        ),
                        Container(
                          width: mediaQuery.size.width > 600 ? mediaQuery.size.width /2 : mediaQuery.size.width / 1,
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
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              SizedBox(height: 16.0),
                              InkWell(
                                onTap: (){
                                  Provider.of<WalletReferralProvider>(context, listen: false).showBottomSheetFilter(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: MyColors.dnaGreen

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            "Ulangi",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
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
                    )
                    )
                  : Consumer<WalletReferralProvider>(
                    builder: (child, wallet, _){
                      return FutureBuilder(
                        future: widget.future,
                        builder: (context, snapshot){
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: wallet.listWalletData.length == 0 ? 0 : wallet.listWalletData.length,
                              itemBuilder: (context, index){
                                var formatTgl = DateFormat('dd MMMM yyyy');
                                var parsedDate = DateTime.parse(wallet.listWalletData[index].created);
                                String dateCreated = ('${formatTgl.format(parsedDate)}');
                                String fnominal = NumberFormat.currency(name: '').format(wallet.listWalletData[index].nominal).split(".")[0].replaceAll(",", ".");
                                String fsaldo = NumberFormat.currency(name: '').format(wallet.listWalletData[index].saldo).split(".")[0].replaceAll(",", ".");
                                return wallet.listWalletData[index].status.contains("Selesai") ? Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left:18.0, right: 18, top: 18),
                                  child: Table(
                                    border: TableBorder.all(color: Colors.black),
                                    children: [
                                       TableRow(children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Tanggal'),
                                          ),
                                          height: 35,
                                        ),
                                        Container(
                                          color: Color(0xffF5FFFF),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('$dateCreated'),
                                          ),
                                          height: 35,
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Nominal'),
                                          ),
                                          height: 35,
                                        ),
                                        Container(
                                          color: Color(0xffF5FFFF),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('$fnominal'.replaceAll("-", "")),
                                          ),
                                          height: 35,
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Nama Mitra'),
                                          ),
                                          height: 35,
                                        ),
                                        Container(
                                          color: Color(0xffF5FFFF),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${wallet.listWalletData[index].from}'),
                                          ),
                                          height: 35,
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Jenis'),
                                          ),
                                          height: 35,
                                        ),
                                        Container(
                                          color: Color(0xffF5FFFF),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${wallet.listWalletData[index].type}') ,
                                          ),
                                          height: 35,
                                        ),
                                      ]),
                                    ],
                                  ),
                                ) : Container(color: Colors.blue, height: 0);
                              },
                            );
                          }
                      );
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


