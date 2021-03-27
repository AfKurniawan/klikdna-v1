import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class HasilKamu extends StatefulWidget {
  final ReportDetail model;

  HasilKamu({Key key, this.model}) : super(key: key);
  @override
  _HasilKamuState createState() => _HasilKamuState();
}

class _HasilKamuState extends State<HasilKamu> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text("Hasil Genetik Kamu",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColors.dnaGrey)),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 4),
                      blurRadius: 10,
                      color: Color(0xFFB0CCE1).withOpacity(0.62),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Berikut ini merupakan hasil tes kamu:",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 20),
                      HtmlWidget("${widget.model.deskripsiHasil}"),
                      SizedBox(height: 20),
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: widget.model.gambarHasil,
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Tentang ${widget.model.namaModul}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColors.dnaGrey)),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 4),
                      blurRadius: 10,
                      color: Color(0xFFB0CCE1).withOpacity(0.62),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: HtmlWidget("${widget.model.deskripsi}"),
                ),
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}