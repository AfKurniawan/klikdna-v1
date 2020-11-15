import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardSlider extends StatelessWidget {
  final String title, desc, svgSrc;
  final Function press;
  const DashboardSlider({
    Key key,
    this.title,
    this.desc,
    this.svgSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provide you the total height and width of the screen
    Size size = MediaQuery.of(context).size;
    var mediaquery = MediaQuery.of(context);
    return Container(
      width: size.width - 20,
      margin: EdgeInsets.only(top: 10, bottom: 20),
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
              svgSrc,
              width: size.width - 40,
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