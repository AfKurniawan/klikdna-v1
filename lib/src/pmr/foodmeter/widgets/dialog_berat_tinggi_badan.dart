import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/src/patient_card/providers/new_patient_card_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/picker_data.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class BottomSheetBeratTinggiBadan extends StatefulWidget {
  const BottomSheetBeratTinggiBadan({Key key}) : super(key: key);

  @override
  _BottomSheetBeratTinggiBadanState createState() => _BottomSheetBeratTinggiBadanState();
}

class _BottomSheetBeratTinggiBadanState extends State<BottomSheetBeratTinggiBadan> {

  FixedExtentScrollController tbSelectController;
  FixedExtentScrollController bbSelectController;

  TextEditingController bbController = new TextEditingController();
  TextEditingController tbController = new TextEditingController();

  bool isEnabled = false;

  final _formKey = GlobalKey<FormState>();

  _showNewBeratPicker(BuildContext context) {
    List<int> selectedData = [50];
    Picker(
        adapter: NumberPickerAdapter(data: [
          //  NumberPickerColumn(begin: 0, end: 999, postfix: Text("\$"), suffix: Icon(Icons.insert_emoticon)),
          NumberPickerColumn(begin: 20, end: 150, jump: 1),
        ]),
        hideHeader: true,
        title: Text("Berat"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        confirmText: "Ok",
        cancelText: "Batal",
        magnification: 1,
        changeToFirst: true,
        selecteds: selectedData,
        onConfirm: (Picker picker, List value) {
          bbController.text = picker.getSelectedValues().last.toString();
          print(picker.getSelectedValues().first);
        }
    ).showDialog(context);
  }

  _showNewTinggiPicker(BuildContext context) {
    List<int> selectedData = [40];
    Picker(
        adapter: NumberPickerAdapter(data: [
          //  NumberPickerColumn(begin: 0, end: 999, postfix: Text("\$"), suffix: Icon(Icons.insert_emoticon)),
          NumberPickerColumn(begin: 120, end: 230, jump: 1),
        ]),
        hideHeader: true,
        title: Text("Berat"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        confirmText: "Ok",
        cancelText: "Batal",
        magnification: 1,
        changeToFirst: true,
        selecteds: selectedData,
        onConfirm: (Picker picker, List value) {
          tbController.text = picker
              .getSelectedValues()
              .last
              .toString();
          print(picker
              .getSelectedValues()
              .first);
        }
    ).showDialog(context);
  }


  @override
  Widget build(BuildContext context) {
    final bbValidator = RequiredValidator(errorText: "Harap isi Berat");
    final tbValidator = RequiredValidator(errorText: "Harap isi Tinggi");
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacementNamed(context, "main_page", arguments: 1);
              return false;
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 24),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Isi Berat dan Tinggi Kamu",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    fontFamily: "Roboto"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Isilah berat dan tinggi kamu dengan benar untuk mendapatkan\nhasil rekomendasi pada food meter",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    fontFamily: "Roboto"))),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: TextFormField(
                                  validator: bbValidator,
                                  style: TextStyle(
                                    color: MyColors.dnaBlack,
                                  ),
                                  controller: bbController,
                                  readOnly: true,
                                  onTap: () {
                                    _showNewBeratPicker(context);
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: Colors.grey),
                                      labelText: "Berat",
                                      labelStyle: TextStyle(color: Colors.grey),
                                      alignLabelWithHint: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColors.dnaGreen, width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red[300], width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red[300], width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      focusColor: MyColors.dnaGreen,
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white54, fontSize: 12)),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: TextFormField(
                                  style: TextStyle(
                                    color: MyColors.dnaBlack,
                                  ),
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    _showNewTinggiPicker(context);
                                  },
                                  readOnly: true,
                                  validator: tbValidator,
                                  controller: tbController,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: Colors.grey),
                                      labelText: "Tinggi",
                                      labelStyle: TextStyle(color: Colors.grey),
                                      alignLabelWithHint: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyColors.dnaGreen, width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red[300], width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red[300], width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.5),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                      ),
                                      focusColor: MyColors.dnaGreen,
                                      hintText: "",
                                      hintStyle: TextStyle(
                                          color: Colors.white54, fontSize: 12)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 19),

                  SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left:16, right: 16),
                    child: Material(
                        color: MyColors.dnaGreen,
                        borderRadius: BorderRadius.circular(10),
                        child: bbController.text.isEmpty || tbController.text.isEmpty
                            ? InkWell(
                          onTap: () {

                          },
                          splashColor: Colors.white,
                          child: Ink(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200]),
                            child: Center(
                              child: Text(
                                "Simpan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                            : InkWell(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              Provider.of<NewPatientCardProvider>(context, listen: false).updateBeratBadan(context, tbController.text,
                                  bbController.text);
                            }

                          },
                          splashColor: Colors.white,
                          child: Ink(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.dnaGreen),
                            child: Center(
                              child: Text(
                                "Simpan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
