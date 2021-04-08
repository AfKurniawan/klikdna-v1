import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class HasilRekomendasi extends StatefulWidget {
  final Rekomendasi model;

  HasilRekomendasi({Key key, this.model}) : super(key: key);

  @override
  _HasilRekomendasiState createState() => _HasilRekomendasiState();
}

class _HasilRekomendasiState extends State<HasilRekomendasi> {
  double imgWidth;

  Uint8List targetlUinit8List;
  Uint8List originalUnit8List;

  @override
  void setState(fn) {
    
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<DetailReportProvider>(
      builder: (context, prov, _) {
        return  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 20, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Rekomendasi Untuk Kamu",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.dnaGrey)),
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: prov.listRecomendasi.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var document;
                              String judul;
                              document = parse(prov.listRecomendasi[index].judulRekomendasi);
                              judul = parse(document.body.text)
                                  .documentElement
                                  .text;
                              String gambar = "${prov.listRecomendasi[index].gambarRekomendasi}";

                              prov.calculateImageDimension("$gambar")
                                  .then((value){
                                 print("IMAGE  $gambar");
                              });

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0,
                                        right: 18,
                                        bottom: 18,
                                        top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [prov.listRecomendasi[index].ikonRekomendasi == "" || prov.listRecomendasi[index]
                                                        .ikonRekomendasi ==
                                                    null
                                            ? Container()
                                            : Image.network(
                                                "${prov.listRecomendasi[index].ikonRekomendasi}",
                                                height: 25,
                                                width: 25,
                                              ),
                                        SizedBox(width: 20),
                                        Flexible(
                                            child: Text("$judul",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: MyColors.dnaGrey))),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 60, right: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Image.network(
                                        "${prov.listRecomendasi[index].gambarRekomendasi}",
                                        width: prov.width < 800
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5
                                            : MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20)
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
