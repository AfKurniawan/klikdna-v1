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
                children: [
                  FormWidget(
                    hint: "",
                    obscure: false,
                    labelText: "Nama Asuransi",
                    textEditingController: prov.addNamaAsuransiController,
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  FormWidget(
                    hint: "",
                    obscure: false,
                    labelText: "Nomor Polis",
                    textEditingController: prov.addNomorPolisController,
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
              Provider.of<AsuransiProvider>(context, listen: false).addAsuransi(context);
            },
          ),
        )
    );
  }
}
