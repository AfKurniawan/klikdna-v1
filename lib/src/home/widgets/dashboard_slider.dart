
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardSlider extends StatelessWidget {
  final String title, desc, imgSrc;
  final Function press;
  final double width;
  final double height ;
  final EdgeInsetsGeometry margin;

  const DashboardSlider({
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
    return Container(
      width: width,
      height: height,
      margin: margin,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: [
      //     BoxShadow(
      //       offset: Offset(0, 4),
      //       blurRadius: 20,
      //       color: Color(0xFFB0CCE1).withOpacity(0.32),
      //     ),
      //   ],
      // ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: imgSrc,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}