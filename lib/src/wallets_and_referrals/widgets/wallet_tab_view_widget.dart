import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:provider/provider.dart';

class WalletTabViewWidget extends StatelessWidget {
  const WalletTabViewWidget({
    Key key,
    @required this.future,
  }) : super(key: key);

  final Future future;

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletReferralProvider>(
      builder: (child, wallet, _){
        return SingleChildScrollView(
            child: wallet.isTai == true
                ? Container(
                height: MediaQuery.of(context).size.height /1.3,
                child: Center(child: Platform.isIOS ? CupertinoActivityIndicator(radius: 12) : CircularProgressIndicator(strokeWidth: 2)))
                : wallet.listWalletData.length == 0 ?  Container(
            height: MediaQuery.of(context).size.height /1.3,
            child: Center(child: Text("Tidak Ada Data")))
            : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:18.0, right: 18, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text("Saldo Anda")),
                          SizedBox(height: 5),
                          Consumer<WalletReferralProvider>(
                            builder: (child, prov, _){
                              return Container(
                                  child: Text(prov.totalsum == null ? "" : "IDR ${prov.totalsum.split(".")[0].replaceAll(",", ".")}",
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
                Consumer<WalletReferralProvider>(
                  builder: (child, wallet, _){
                    return FutureBuilder(
                      future: future,
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
                              return Container(
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
                                          child: Text('$fnominal'),
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
                                          child: Text('${wallet.listWalletData[index].type}'),
                                        ),
                                        height: 35,
                                      ),
                                      Container(
                                        color: Color(0xffF5FFFF),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('$fsaldo'),
                                        ),
                                        height: 35,
                                      ),
                                    ]),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                    );
                  },
                ),
                SizedBox(height: 30),
              ],
            ));
      },
    );
  }
}

