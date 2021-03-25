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
          //color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              color: Colors.grey[500].withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Referral Anda",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 5),
                              Consumer<WalletReferralProvider>(
                                builder: (child, ref, _) {
                                  return Container(
                                      child: Text(
                                          ref.listReferralData.length == 0
                                              ? "Total 0 Referral"
                                              : "Total ${ref.listReferralData.length} Referral",
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)));
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
                  : Consumer<WalletReferralProvider>(
                          builder: (child, wallet, _) {
                            return FutureBuilder(
                                future: widget.future,
                                builder: (context, snapshot) {
                                  return buildListView(wallet);
                                });
                          },
                        ),
             // SizedBox(height: 10),
            ],
          ),
        ));
      },
    );
  }

  ListView buildListView(WalletReferralProvider wallet) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: wallet.listReferralData.length == 0
          ? 0
          : wallet.listReferralData.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
                width: 139,
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    gradient: LinearGradient(
                      colors:
                          wallet.listReferralData[index].par.contains("Star")
                              ? MyColors.startCardColor
                              : wallet.listReferralData[index].par
                                      .contains("Referral")
                                  ? MyColors.startCardColor
                                  : wallet.listReferralData[index].par
                                          .contains("Mitra")
                                      ? MyColors.mitraCardColor
                                      : wallet.listReferralData[index].par.contains("Producer")
                                      ? MyColors.producerCardColor
                                      : wallet.listReferralData[index].par.contains("Leader")
                                      ? MyColors.leaderCardColor
                                      : wallet.listReferralData[index].par.contains("Builder")
                                      ? MyColors.builderCardColor
                                      : wallet.listReferralData[index].status.contains("Belum")
                                          ? MyColors.tidakAktifColor
                                          : MyColors.mitraCardColor,
                    )),
                child: wallet.listReferralData[index].status.contains("Selesai")
                    ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(
                            wallet.listReferralData[index].rank == "" ||
                                    wallet.listReferralData[index].par == ""
                                ? "${wallet.listReferralData[index].type}"
                                : "${wallet.listReferralData[index].par}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500
                            )),
                      ),
                    )
                    : Align(
                  alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                            wallet.listReferralData[index].rank == "" ||
                                    wallet.listReferralData[index].par == ""
                                ? "${wallet.listReferralData[index].status}"
                                : "${wallet.listReferralData[index].par}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    )),
            SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 96,
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
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${wallet.listReferralData[index].name}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Posisi",
                            style: TextStyle(
                          color: MyColors.lightblack,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Roboto",
                              fontSize: 12
                        )),
                        wallet.listReferralData[index].status == "Belum Aktif" ? Text("-") :
                        Text(wallet.listReferralData[index].position == "right" ? "Kanan/Right"
                            : wallet.listReferralData[index].position == "left" ? "Kiri/Left"
                            : "${wallet.listReferralData[index].position}",
                            style: TextStyle(
                            color: MyColors.lightblack,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Roboto",
                                fontSize: 12
                        ))
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kualifikasi Peringkat",
                            style: TextStyle(
                            color: MyColors.lightblack,
                              fontWeight: FontWeight.w300,
                              fontSize: 12
                        )),
                        wallet.listReferralData[index].status.contains("Belum") ?
                        Text("Belum Aktif",
                            style: TextStyle(
                                color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                            ))
                            : Text(wallet.listReferralData[index].rank == "" ||
                            wallet.listReferralData[index].par == ""
                            ? "${wallet.listReferralData[index].type}"
                            : "${wallet.listReferralData[index].rank}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                    fontSize: 14,
                                    color: wallet.listReferralData[index].rank.contains("Star")
                                        ? MyColors.starColor
                                        : wallet.listReferralData[index].rank.contains("Producer")
                                        ? MyColors.dnaGreen
                                        : wallet.listReferralData[index].rank.contains("Leader")
                                        ? MyColors.leaderColor
                                        : wallet.listReferralData[index].rank.contains("Builder")
                                        ? MyColors.builderColor
                                        : wallet.listReferralData[index].type.contains("Mitra")
                                      ? MyColors.mitraColor
                                        : MyColors.grey),
                        )
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
  }
}

class noDataWidget extends StatelessWidget {
  const noDataWidget({
    Key key,
    @required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 1.6,
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
                    "Tidak ada data referral",
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
        ));
  }
}
