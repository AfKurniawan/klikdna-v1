import 'package:flutter/material.dart';

class ButtonAndIconWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final String btnText;
  final IconData myIcon;
  final Color color;
  final double height;
  final double widht;
  final Color iconColor;

  ButtonAndIconWidget({
    @required this.btnAction,
    @required this.btnText,
    this.height,
    this.widht,
    this.myIcon,
    this.iconColor,
    this.color
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnAction,
      splashColor: Colors.white,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: color
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  btnText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 30),
                Icon(myIcon, color: iconColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}