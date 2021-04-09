import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class DetailServiceItem extends StatefulWidget {
  final ReportDetail model;
  final Detail detail;
  final Rekomendasi rekomendasi;

  DetailServiceItem({Key key, this.model, this.detail, this.rekomendasi}) : super(key: key);

  @override
  _DetailServiceItemState createState() => _DetailServiceItemState();
}

class _DetailServiceItemState extends State<DetailServiceItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 15),
      child: Container(
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
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            Navigator.of(context).pushNamed('hasil_report_page', arguments: widget.model);

          },
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget.model.gambarJudul == null ? Container() :
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 14.0, top: 10, bottom: 20),
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 40,
                      width: 40,
                      child: CachedNetworkImage(
                          imageUrl: widget.model.gambarJudul),
                    ),
                  ),
                  Expanded(

                    child: widget.detail.serviceName.contains("DIET") || widget.detail.serviceName.contains("SPORT")
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.model.namaModul,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: MyColors.dnaGrey)),
                      ],
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.model.namaModul}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: MyColors.dnaGrey)),
                        Text( "Beresiko ${widget.model.hasilKamu}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: widget.model.hasilKamu == "Tinggi"
                                    ? Color(0xffED2226)
                                    : widget.model.hasilKamu == "Sedang"
                                    ? Color(0xffF9D01D)
                                    : Color(0xff8CC33F))
                        ),
                      ],
                    ),
                  ),
                  // Spacer(),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.grey,),
                      onPressed: (){

                      }
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}