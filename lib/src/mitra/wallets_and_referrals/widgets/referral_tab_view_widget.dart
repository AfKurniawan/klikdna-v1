import 'package:flutter/material.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:provider/provider.dart';

class RefferalTabViewWidget extends StatefulWidget {
  @override
  _RefferalTabViewWidgetState createState() => _RefferalTabViewWidgetState();
}

class _RefferalTabViewWidgetState extends State<RefferalTabViewWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:18.0, right: 18, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text("Referral Anda")),
                  SizedBox(height: 5),
                  Consumer<WalletReferralProvider>(
                    builder: (child, ref, _){
                      return Container(
                          child: Text(ref.listReferralData.length == 0 ? "Total 0 Referral" : "Total ${ref.listReferralData.length} Referral",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)));
                    },
                  ),
                ],
              ),
            ),
            Consumer<WalletReferralProvider>(
              builder: (child, ref, _){
                return ListView.builder(
                  itemCount: ref.listReferralData.length == 0 ? 0 : ref.listReferralData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
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
                                child: Text('Nama'),
                              ),
                              height: 35,
                            ),
                            Container(
                              color: Color(0xffF5FFFF),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${ref.listReferralData[index].name}'),
                              ),
                              height: 35,
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Posisi'),
                              ),
                              height: 35,
                            ),
                            Container(
                              color: Color(0xffF5FFFF),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${ref.listReferralData[index].position}'),
                              ),
                              height: 35,
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Kualifikasi Peringkat'),
                              ),
                              height: 35,
                            ),
                            Container(
                              color: Color(0xffF5FFFF),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${ref.listReferralData[index].rank}'),
                              ),
                              height: 35,
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Peringkat saat ini'),
                              ),
                              height: 35,
                            ),
                            Container(
                              color: Color(0xffF5FFFF),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${ref.listReferralData[index].par}'),
                              ),
                              height: 35,
                            ),
                          ]),
                        ],
                      ),
                    );
                  },
                );
            },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
