import 'package:flutter/material.dart';

class FontSizes {
  static double scale = 1.2;
  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
  static double get title => 16 * scale;
  static double get titleM => 18 * scale;
  static double get sizeXXl => 28 * scale;
}

class TextStyles {
  static TextStyle get title =>TextStyle(fontSize: FontSizes.title);
  static TextStyle get titleM =>TextStyle(fontSize: FontSizes.titleM);
  static TextStyle get titleNormal => title.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get titleMedium => titleM.copyWith(fontWeight: FontWeight.w300);
  static TextStyle get bold => TextStyle(fontSize: FontSizes.sizeXXl, fontWeight: FontWeight.bold);

  static TextStyle get body => TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300);
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
}

Color mainColor = Color.fromRGBO(255, 204, 0, 1);

//Style
final headerStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
final titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
final titleStyle2 = TextStyle(fontSize: 16, color: Colors.black45);
final subtitleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

//Decoration
final roundedRectangle12 = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(12),
);

final roundedRectangle4 = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(4),
);

final roundedRectangle40 = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
);

//class FontSizes {
//  static double scale = 1.2;
//  static double get body => 14 * scale;
//  static double get bodySm => 12 * scale;
//  static double get title => 16 * scale;
//  static double get titleM => 18 * scale;
//  static double get sizeXXl => 28 * scale;
//}
//
//class TextStyles {
//  static TextStyle get title =>TextStyle(fontSize: FontSizes.title);
//  static TextStyle get titleM =>TextStyle(fontSize: FontSizes.titleM);
//  static TextStyle get titleNormal => title.copyWith(fontWeight: FontWeight.w500);
//  static TextStyle get titleMedium => titleM.copyWith(fontWeight: FontWeight.w300);
//  static TextStyle get h1Style => TextStyle(fontSize: FontSizes.sizeXXl, fontWeight: FontWeight.bold);
//
//  static TextStyle get body => TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300);
//  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
//}