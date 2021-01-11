import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPromoWidget extends StatelessWidget {
  final String title, desc, svgSrc;
  final Function press;
  final double width;
  final double height ;
  final double radius;
  final EdgeInsetsGeometry margin;
  
  const DetailPromoWidget({
    Key key,
    this.title,
    this.desc,
    this.svgSrc,
    this.press,
    this.width,
    this.height,
    this.radius,
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
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            child: Image.network(
              svgSrc,
              //width: size.width - 40,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: mediaquery.size.width < 600 ? size.height / 3 : size.height / 2,
              // height: 150,
            ),
          ),
        ),
      ),
    );
  }
}