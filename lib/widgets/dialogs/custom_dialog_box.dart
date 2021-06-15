import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;
  final double level ;

  const CustomDialogBox({Key key, this.title, this.descriptions, this.text, this.img, this.level}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: AppConstants.padding,top: AppConstants.avatarRadius
                + AppConstants.padding, right: AppConstants.padding,bottom: AppConstants.padding
            ),
            margin: EdgeInsets.only(top: AppConstants.avatarRadius),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.padding),
                boxShadow: [
                  BoxShadow(color: Colors.black26,offset: Offset(0,10),
                      blurRadius: 10
                  ),
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                SizedBox(height: 15,),
                Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                SizedBox(height: 22,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Bottono",style: TextStyle(fontSize: 18),)),
                ),
              ],
            ),
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: .26,
                        spreadRadius: widget.level * 1.5,
                        color: Colors.black.withOpacity(.05))
                  ],
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () => null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}