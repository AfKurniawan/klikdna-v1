import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/src/patient_card/providers/new_patient_card_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class BottomSheetBBTB extends StatefulWidget {
  const BottomSheetBBTB({
    Key key,
  }) : super(key: key);

  @override
  _BottomSheetBBTBState createState() => _BottomSheetBBTBState();
}

class _BottomSheetBBTBState extends State<BottomSheetBBTB> {

  FixedExtentScrollController tbSelectController;
  FixedExtentScrollController bbSelectController;

  TextEditingController bbController = new TextEditingController();
  TextEditingController tbController = new TextEditingController();

  int _selectedValue = 70;
  int _selectedValueTb = 100;
  bool isEnabled = false;


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final bbValidator = RequiredValidator(errorText: "Harap isi Berat");
    final tbValidator = RequiredValidator(errorText: "Harap isi Tinggi");
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
              children: [
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ],
                ),
                SizedBox(height: 19),
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
                              //_showBBPicker(context);
                              _showNewBeratPicker();
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
                              _showTbPicker(context);
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
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                      color: MyColors.dnaGreen,
                      borderRadius: BorderRadius.circular(10),
                      child: isEnabled == false
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
          );
        },
      ),
    );
  }

  _showBBPicker(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Berat'),
          content: Container(
            height: 350,
            width: 350.0,
            child: Column(
              children: <Widget>[
                Text('Kilogram'),
                Container(
                  height: MediaQuery.of(ctx).size.height / 4,
                  color: Colors.transparent,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1,
                    useMagnifier: true,
                    diameterRatio: 1,
                    scrollController: bbSelectController,
                    children: List<Widget>.generate(131, (int index) {
                      int i = index + 20 ;
                      return Center(
                        child: Text("$i"),
                      );
                    }),
                    onSelectedItemChanged: (int i) {
                      setState(() {
                        _selectedValue = i + 20;
                        isEnabled = true ;
                      });
                    },
                  ),
                ),
                SizedBox(height: 40),
                CupertinoButton(
                  child: Text('OK'),
                  onPressed: () {
                    bbController.text = _selectedValue.toString();
                    isEnabled = true ;
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showTbPicker(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tinggi'),
          content: Container(
            height: 380,
            width: 350.0,
            child: Column(
              children: <Widget>[
                Text('Centimeter'),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  color: Colors.transparent,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1,
                    useMagnifier: true,
                    diameterRatio: 1,
                    scrollController: tbSelectController,
                    children: List<Widget>.generate(150, (int index) {
                      int i = index + 170;
                      return Center(
                        child: Text("$i"),
                      );
                    }),
                    onSelectedItemChanged: (i) {
                      _selectedValueTb = i + 100;
                      isEnabled = true ;
                    },
                  ),
                ),
                SizedBox(height: 50),
                CupertinoButton(
                  child: Text('OK'),
                  onPressed: () {
                    tbController.text = _selectedValueTb.toString();
                    isEnabled = true ;
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static const PickerData = '''
[
    [
        1,
        2,
        3,
        4
    ],
    [
        11,
        22,
        33,
        44
    ],
    [
        "aaa",
        "bbb",
        "ccc"
    ]
]
    ''';

  _showNewBeratPicker() {
    showPickerDialog(BuildContext context) {
      Picker(
          adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(PickerData)),
          hideHeader: true,
          title: Text("Select Data"),
          selectedTextStyle: TextStyle(color: Colors.blue),
          onConfirm: (Picker picker, List value) {
            print(value.toString());
            print(picker.getSelectedValues());
          }
      ).showDialog(context);
    }
  }
}