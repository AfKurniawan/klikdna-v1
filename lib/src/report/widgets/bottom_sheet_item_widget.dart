import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/report/models/report_model.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class BottomSheetItemWidget extends StatefulWidget {
  final Detail model;

  BottomSheetItemWidget({Key key, this.model}) : super(key: key);

  @override
  _BottomSheetItemWidgetState createState() => _BottomSheetItemWidgetState();
}

class _BottomSheetItemWidgetState extends State<BottomSheetItemWidget> {


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ReportProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(0),

        ),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: widget.model.serviceName == "HEALTH" ? MyColors.healthGreen
                    : widget.model.serviceName == "SPORT" ? MyColors.sportBlue
                    : widget.model.serviceName == "DIET" ? MyColors.dietGreen
                    : widget.model.serviceName == "SKIN" ? MyColors.skinPink
                    : widget.model.serviceName.contains("CANCER") ? MyColors.cancerPink
                    : MyColors.dnaGreen,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(0.1),
                    spreadRadius: 0.1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  color: Colors.white,
                  image: widget.model.serviceName == "SPORT" ? AssetImage("assets/images/sport.png")
                      : widget.model.serviceName == "HEALTH" ? AssetImage("assets/images/health.png")
                      : widget.model.serviceName == "DIET" ? AssetImage("assets/images/diet.png")
                      : widget.model.serviceName == "SKIN" ? AssetImage("assets/images/skin.png")
                      : widget.model.serviceName.contains("CANCER") ? AssetImage("assets/images/cancer.png")
                      : AssetImage("assets/images/no_image.png"),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(
              "${widget.model.serviceName}",
              style: TextStyle(
                  color: Color(0xff555555),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Spacer(),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: MyColors.dnaGreen,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45.withOpacity(0.1),
                        spreadRadius: 0.1,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                      icon: Icon(LineariconsFree.download),
                      color: Colors.white,
                      onPressed: () {
                        prov.getLinkPdf(context, widget.model.reportId);
                        prov.showProgressDownload(context);

                      }
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}