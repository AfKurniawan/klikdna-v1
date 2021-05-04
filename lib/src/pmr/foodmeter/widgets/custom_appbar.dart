import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.iconArrowColor,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Food Meter",
          style: TextStyle(
              fontFamily: "Roboto",
              color: MyColors.blackPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset("assets/images/logo.png", width: 19),
          )
        ],
      ),
      body: Container(
        height: preferredSize.height,
        color: Colors.white,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}