import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class NewReferralTabView extends StatefulWidget {
  const NewReferralTabView({
    Key key,
    @required this.future,
  }) : super(key: key);

  final Future future;




  @override
  _NewReferralTabViewState createState() => _NewReferralTabViewState();
}

class _NewReferralTabViewState extends State<NewReferralTabView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<WalletReferralProvider>(
      builder: (context, referral, _) {
        return SingleChildScrollView(
            child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                child: referral.listReferralData.length == 0
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
                              Text("Referral Anda",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Consumer<WalletReferralProvider>(
                                builder: (child, ref, _) {
                                  return  Container(
                                      child: Text(ref.listReferralData.length == 0 ? "Total 0 Referral" : "Total ${ref.listReferralData.length} Referral",
                                          style: TextStyle(
                                              fontSize: 16))
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              referral.isLoading == true
                  ? Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Center(
                          child: Platform.isIOS
                              ? CupertinoActivityIndicator(radius: 12)
                              : CircularProgressIndicator(strokeWidth: 2)))
                  : referral.listWalletData.length == 0
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
                                    itemCount: wallet.listReferralData.length == 0 ? 0
                                        : wallet.listReferralData.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 20),
                                                  Container(
                                                    width: 156,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(25),
                                                          bottomRight: Radius.circular(25)
                                                      ),
                                                      gradient: LinearGradient(
                                                        colors: wallet.listReferralData[index].rank.contains("Star")
                                                        ? MyColors.startCardColor
                                                            : wallet.listReferralData[index].rank.contains("Referral")
                                                        ? MyColors.startCardColor
                                                            : wallet.listReferralData[index].type.contains("Royalti")
                                                        ? MyColors.presidentAndDirectorColor
                                                            : wallet.listReferralData[index].status.contains("Belum")
                                                        ? MyColors.tidakAktifColor
                                                            : MyColors.mitraCardColor,
                                                      )
                                                    ),
                                                    child: wallet.listReferralData[index].status.contains("Selesai")

                                                    ? Padding(
                                                      padding: const EdgeInsets.only(top: 13.0, left: 10),
                                                      child: Text(wallet.listReferralData[index].rank == "" || wallet.listReferralData[index].par == ""
                                                          ? "${wallet.listReferralData[index].type}"
                                                          : "${wallet.listReferralData[index].rank}", style: TextStyle(
                                                          color: Colors.white, fontSize: 16
                                                      )),
                                                    )
                                                        : Padding(
                                                      padding: const EdgeInsets.only(top: 13.0, left: 10),
                                                      child: Text(wallet.listReferralData[index].rank == "" || wallet.listReferralData[index].par == ""
                                                          ? "${wallet.listReferralData[index].status}"
                                                          : "${wallet.listReferralData[index].rank}", style: TextStyle(
                                                          color: Colors.white, fontSize: 16
                                                      )),
                                                    )
                                                  ),
                                                  SizedBox(height: 10),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    //height: 100,
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text("${wallet.listReferralData[index].name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("Posisi"),
                                                              Text("${wallet.listReferralData[index].position}")
                                                            ],

                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("Kualifikasi Peringkat"),
                                                              Text(wallet.listReferralData[index].rank == "" || wallet.listReferralData[index].par == ""
                                                                      ? "${wallet.listReferralData[index].type}"
                                                                      : "${wallet.listReferralData[index].rank}")

                                                            ],

                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              );
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
