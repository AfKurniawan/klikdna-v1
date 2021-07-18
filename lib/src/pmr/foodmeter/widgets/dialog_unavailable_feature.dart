import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
class BottomSheetUnavailableFeature extends StatelessWidget {

  const BottomSheetUnavailableFeature({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/no_data.png"),
                Text("Oopss Fitur Pindai Belum Dapat Digunakan",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,

                  ),
                ),
                SizedBox(height: 8),
                Text("Cek aplikasi secara berkala untuk mendapatkan update",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w300,

                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 18, right: 18),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.white,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: MyColors.dnaGreen
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Kembali",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}



