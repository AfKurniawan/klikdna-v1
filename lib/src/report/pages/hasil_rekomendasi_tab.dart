import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class HasilRekomendasi extends StatefulWidget {
  @override
  _HasilRekomendasiState createState() => _HasilRekomendasiState();
}

class _HasilRekomendasiState extends State<HasilRekomendasi> {


  double imgWidth;

  @override
  void setState(fn) {

    if (mounted) super.setState(fn);
  }





  @override
  Widget build(BuildContext context) {
    return Consumer<DetailReportProvider>(
      builder: (context, prov, _){
        return prov.lr.length == 0 || prov.kosong == true ?
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tidak ada data"),
                ],
              )
          ),
        )
            : SingleChildScrollView(
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
                      itemCount: prov.lr.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var document;
                        String judul ;
                        document = parse(prov.lr[index].judulRekomendasi);
                        judul = parse(document.body.text).documentElement.text;
                        String gambar = "${prov.lr[index].gambarRekomendasi}";
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  prov.lr[index].ikonRekomendasi == "" || prov.lr[index].ikonRekomendasi == null ?
                                  Container()
                                      : Image.network(
                                    "${prov.lr[index].ikonRekomendasi}",
                                    height: 25,
                                    width: 25,
                                  ),
                                  SizedBox(width: 20),
                                  Flexible(
                                      child: Text("$judul",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: MyColors.dnaGrey)
                                      )
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            gambar == "" || gambar == null ?
                            Center()
                                : Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20),
                              child: prov.lr[index].gambarRekomendasi == null ?
                              Container()
                                  : Container(
                                // color: Colors.blueGrey,
                                  child: prov.imgHeight > 400 || prov.imgWidth > 400 ?
                                  Container(
                                    margin: EdgeInsets.only(left: 40, right: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                          imageUrl: "${prov.lr[index].gambarRekomendasi}",
                                          fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width),
                                    ),
                                  )
                                      : Container(
                                    margin: EdgeInsets.only(left: 40, right: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: CachedNetworkImage(
                                        imageUrl: "${prov.lr[index].gambarRekomendasi}",
                                        fit: BoxFit.fitWidth,
                                        width: 170,
                                        height: 180,
                                      ),
                                    ),
                                  )
                              ),
                            ),
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