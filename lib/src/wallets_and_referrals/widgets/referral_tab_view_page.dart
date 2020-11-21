import 'package:flutter/material.dart';

class RefferalTabViewPage extends StatefulWidget {
  @override
  _RefferalTabViewPageState createState() => _RefferalTabViewPageState();
}

class _RefferalTabViewPageState extends State<RefferalTabViewPage> {
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
                          child: Text("Referral Anda")),
                      SizedBox(height: 5),
                      Container(
                          child: Text("Total 10 Referral",
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
              itemCount: 5,
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
                            child: Text('Value of nama'),
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
                            child: Text('Value of posisi'),
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
                            child: Text('Value of kualifikasi peringkat'),
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
                            child: Text('Value of Peringkat saat ini'),
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
