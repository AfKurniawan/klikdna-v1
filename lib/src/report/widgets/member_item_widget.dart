import 'package:flutter/material.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:provider/provider.dart';

class MemberItemWidget extends StatelessWidget {
  final Member member;

  MemberItemWidget({Key key, this.member}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ReportProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        print("Widget: ${member.personId}");
        prov.getSample(context, member.personId);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/dummy_user.jpeg',
                //model.name,
                fit: BoxFit.fill,
                height: width * 0.2,
                width: width * 0.2,
              ),
            ),
            // SizedBox(
            //   height: 4,
            // ),
            Text(member.name)
          ],
        ),
      ),
    );
  }
}