import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DummyDashboardSlider extends StatelessWidget {
  final String title, desc, imgSrc;
  final Function press;
  final double width;
  final double height ;
  final EdgeInsetsGeometry margin;

  const DummyDashboardSlider({
    Key key,
    this.title,
    this.desc,
    this.imgSrc,
    this.press,
    this.width,
    this.height,
    this.margin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var mediaquery = MediaQuery.of(context);
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Color(0xFFB0CCE1).withOpacity(0.32),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imgSrc,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}