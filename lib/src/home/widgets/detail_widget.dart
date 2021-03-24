
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  final String title, desc, svgSrc;
  final Function press;
  final double width;
  final double height ;
  final double radiusTr;
  final double radiusTl;
  final EdgeInsetsGeometry margin;
  
  const DetailWidget({
    Key key,
    this.title,
    this.desc,
    this.svgSrc,
    this.press,
    this.width,
    this.height,
    this.radiusTl,
    this.radiusTr,
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
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusTl), topRight: Radius.circular(radiusTr)),
            child: CachedNetworkImage(
              imageUrl: svgSrc,
              fit: BoxFit.fitHeight,
              alignment: Alignment.topLeft,
              height: height,
              // height: 150,
            ),
          ),
        ),
      ),
    );
  }
}