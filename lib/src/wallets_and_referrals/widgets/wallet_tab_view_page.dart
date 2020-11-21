import 'package:flutter/material.dart';

class WalletTabViewPage extends StatefulWidget {
  @override
  _WalletTabViewPageState createState() => _WalletTabViewPageState();
}

class _WalletTabViewPageState extends State<WalletTabViewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: Text("Total Komisi Langsung")),
                      SizedBox(height: 5),
                      Container(
                          child: Text("IDR 10.000.000",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  Container(
                    child: Image.asset("assets/icons/sorting_wallet_referral.png",
                      height: 20,
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
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
                            child: Text('Tanggal'),
                          ),
                          height: 35,
                        ),
                        Container(
                          color: Color(0xffF5FFFF),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Value of tanggal'),
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
                            child: Text('Value of nominal'),
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
                            child: Text('Value of Nama mitra'),
                          ),
                          height: 35,
                        ),
                      ]),
                    ],
                  ),
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
