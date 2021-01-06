import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class SlideTileWidget extends StatelessWidget {

  final String imagePath, title, desc;

  SlideTileWidget({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.background,
        padding: EdgeInsets.symmetric(horizontal: 40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imagePath),
            SizedBox(
              height: 40,
            ),
            Text(title, textAlign: TextAlign.center,style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: MyColors.dnaBlack
            ),),
            SizedBox(
              height: 20,
            ),
            Text(desc, textAlign: TextAlign.center,style: TextStyle(
              height: 1.5,
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: MyColors.dnaGrey
            ))
          ],
        ),
      ),
    );
  }
}
