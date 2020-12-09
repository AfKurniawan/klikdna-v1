import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventSlider extends StatelessWidget {
  final String title, desc, svgSrc;
  final Function press;
  final double width;
  final double height ;
  final EdgeInsetsGeometry margin;
  
  const EventSlider({
    Key key,
    this.title,
    this.desc,
    this.svgSrc,
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            color: Color(0xFFB0CCE1).withOpacity(0.32),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.asset(
              svgSrc,
              //width: size.width - 40,
              fit: BoxFit.cover,
              height: mediaquery.size.width < 600 ? size.height / 4 : size.height / 3,
              // height: 150,
            ),
          ),
        ),
      ),
    );
  }
}