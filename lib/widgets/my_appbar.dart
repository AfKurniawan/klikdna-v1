import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class MyAppbar extends StatelessWidget {
  final String title ;
  const MyAppbar({
    Key key, this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MyColors.dnaGrey,
            size: 20,
          ),
          onPressed: () {
            //Navigator.pushReplacementNamed(context, "detail_report_page");
            Navigator.of(context).pop();
          }),
      actions: [
      ],
    );
  }
}