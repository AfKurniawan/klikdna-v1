import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class MyTheme {
  const MyTheme();
  static ThemeData lightTheme = ThemeData(
    backgroundColor: MyColors.background,
    primaryColor: MyColors.dnaGreen,
  );

  static double fullWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static double fullHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

}