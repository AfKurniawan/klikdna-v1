
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0.3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoActivityIndicator(
            radius: 15,
          ),
        ),
      ),
    );
  }
}