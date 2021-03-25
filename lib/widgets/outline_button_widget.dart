import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final String btnText;
  final Icon myIcon;
  final Color filledColor;
  final Color outlineTextColor;
  final double height;
  final double width;

  OutlineButtonWidget({
    @required this.btnAction,
    @required this.btnText,
    this.myIcon,
    this.filledColor,
    this.outlineTextColor,
    this.height,
    this.width
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnAction,
      splashColor: MyColors.dnaGreen,
      focusColor: Colors.red,
      hoverColor: Colors.red,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: MyColors.dnaGreen,
                width: 1.5
            ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  btnText,
                  style: TextStyle(
                      color: outlineTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
