import 'package:flutter/material.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:provider/provider.dart';

class MemberItemWidget extends StatefulWidget {
  final Member member;

  MemberItemWidget({Key key, this.member}) : super (key: key);

  @override
  _MemberItemWidgetState createState() => _MemberItemWidgetState();
}

class _MemberItemWidgetState extends State<MemberItemWidget> {


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ReportProvider>(context);
    final detailprov = Provider.of<DetailReportProvider>(context);
    var width = MediaQuery.of(context).size.width;
    final mem = Provider.of<MemberProvider>(context);
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        prov.getMemberSample(context, widget.member.personId);
        mem.getNamexx(context, widget.member.name, widget.member.userId);
        mem.getMemberId(context, widget.member.personId);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/no_image.png',
                //model.name,
                fit: BoxFit.fill,
                height: width * 0.2,
                width: width * 0.2,
              ),
            ),
            // SizedBox(
            //   height: 4,
            // ),
            Container(
              height: 40,
              width: 80,
              child: Align(
                alignment: Alignment.center,
                child: Center(
                  child: Text(widget.member.name == null ? "" : widget.member.name.length > 10 ? "${widget.member.name.substring(0, 7)}": "${widget.member.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}