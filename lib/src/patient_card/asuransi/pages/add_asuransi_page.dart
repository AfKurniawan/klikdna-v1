import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:provider/provider.dart';

class AddAsuransiPage extends StatefulWidget {
  @override
  _AddAsuransiPageState createState() => _AddAsuransiPageState();
}

class _AddAsuransiPageState extends State<AddAsuransiPage> {

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  List<String> walletType = [
    "Jiwa",
    "Kesehatan"
  ];

  String tipeValue = "Jiwa" ;
  String result;

  void _handleRadioValueChange(BuildContext context, String value) {
    tipeValue = value;
    switch (tipeValue) {
      case "Jiwa":
        result = "Jiwa";
        print("RESULT $result");
        break;
      case "Kesehatan":
        result = "Kesehatan";
        print("RESULT $result");
        break;
    }
  }

  List<String> listNamaAsuransi = [
    "AIA",
    "ALLIANZ",
    "AXA MANDIRI",
    "CIGNA",
    "FWD",
    "GENERALI",
    "PRUDENTIAL",
    "MANULIFE",
    "SEQUIS LIFE",
    "JIWASRAYA",
    "SINARMAS",
    "BNI LIFE",
    "LIPPO INSURANCE",
    "AXA",
    "TAKAFUL",
    "BUMIPUTERA",
    "AVRIST",
    "CHUBB",
    "ADIRA INSURANCE",
    "EQUITY",
    "AIA",
    "MUG"
  ];

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AsuransiProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Tambah Asuransi",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: MyColors.dnaGrey,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleAutoCompleteTextField(
                    key: key,
                    suggestions: listNamaAsuransi,
                    controller: prov.addNamaAsuransiController,
                    decoration: InputDecoration(
                        labelText: "Nama Asuransi",
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.dnaGreen, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red[300], width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red[300], width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusColor: MyColors.dnaGreen,
                        hintText: "",
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ),
                  SizedBox(height: 20),
                  Text("Jenis Asuransi"),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    height: 60,
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(''),
                              value: tipeValue,
                              underline: Container(),
                              items: walletType.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(
                                    value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  _handleRadioValueChange(context, value);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  FormWidget(
                    hint: "",
                    obscure: false,
                    labelText: "Nomor Polis",
                    textEditingController: prov.addNomorPolisController,
                    keyboardType: TextInputType.number,
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  FormWidget(
                    hint: "",
                    obscure: false,
                    labelText: "Pemegang Polis",
                    textEditingController: prov.addPemegangPolisController,
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  FormWidget(
                    hint: "",
                    obscure: false,
                    labelText: "Nama Peserta",
                    textEditingController: prov.addNamaPesertaController,
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  FormWidget(
                    hint: "",
                    obscure: false,
                    labelText: "Nomor Kartu",
                    keyboardType: TextInputType.number,
                    textEditingController: prov.addNomorKartuController,
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ButtonWidget(
            btnText: "Simpan",
            height: 60,
            color: MyColors.dnaGreen,
            btnAction: (){

              Provider.of<AsuransiProvider>(context, listen: false).addAsuransi(context, tipeValue);

            },
          ),
        )
    );
  }
}
