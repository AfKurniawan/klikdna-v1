import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final String btnText;
  final Icon myIcon;
  final Color color;
  final double height;
  final double widht;

  ButtonWidget({
    @required this.btnAction,
    @required this.btnText,
    this.height,
    this.widht,
    this.myIcon,
    this.color
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnAction,
      splashColor: Colors.white,
      child: Ink(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: color
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
                      color: Colors.white,
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