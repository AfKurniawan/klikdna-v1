import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final Widget btnText;
  final IconData myIcon;
  final Color iconColor;
  final Color outlineColor;
  final Color outlineTextColor;
  final Color btnTextColor;
  final double height;
  final double width;

  OutlineButtonWidget({
    @required this.btnAction,
    @required this.btnText,
    this.myIcon,
    this.iconColor,
    this.outlineColor,
    this.outlineTextColor,
    this.height,
    this.btnTextColor,
    this.width
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnAction,
      splashColor: MyColors.dnaGreen,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: outlineColor,
              width: 1.5
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // OJO DIKEKI ICON NDAK RA CENTER
                //Icon(myIcon, color: iconColor),
                SizedBox(width: 10),
                btnText
              ],
            ),
          ),
        ),
      ),
    );
  }
}
