import 'package:flutter/material.dart';

class ButtonIconWidget extends StatelessWidget {
  final VoidCallback btnAction;
  final String btnText;
  final Widget myIcon;
  final Color color;

  ButtonIconWidget({
    @required this.btnAction,
    @required this.btnText,
    this.myIcon,
    this.color
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnAction,
      splashColor: Colors.white,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 25),
                Text(
                  btnText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                myIcon,
                SizedBox(width: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
