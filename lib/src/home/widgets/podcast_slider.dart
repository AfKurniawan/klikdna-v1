
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodcastSlider extends StatelessWidget {
  final String title, desc, imgSrc;
  final Function press;
  final double width;
  final double height ;
  final EdgeInsetsGeometry margin;

  const PodcastSlider({
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 1,
            color: Colors.grey[900].withOpacity(0.32),
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
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}