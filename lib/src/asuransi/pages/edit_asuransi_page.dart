import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:provider/provider.dart';

class EditAsuransiPage extends StatefulWidget {
  Asuransi model;

  EditAsuransiPage({Key key, this.model}) : super (key: key);

  @override
  _EditAsuransiPageState createState() => _EditAsuransiPageState();
}

class _EditAsuransiPageState extends State<EditAsuransiPage> {


  @override
  void initState() {
    Provider.of<AsuransiProvider>(context, listen: false).getAsuransi(context, widget.model.id);
    //Provider.of<PatientCardProvider>(context, listen: false).getPatientCard(context);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    print("ASURAN ID: ${widget.model.id}");

    final prov = Provider.of<AsuransiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Edit Asuransi",
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
      body: prov.isLoading == true ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                FormWidget(
                  hint: "",
                  obscure: false,
                  labelText: "Nama Asuransi",
                  textEditingController: prov.namaAsuransiController,
                  labelStyle: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                FormWidget(
                  hint: "",
                  obscure: false,
                  labelText: "Nomor Polis",
                  textEditingController: prov.nomorPolisController,
                  labelStyle: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                FormWidget(
                  hint: "",
                  obscure: false,
                  labelText: "Pemegang Polis",
                  textEditingController: prov.pemegangPolisController,
                  labelStyle: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                FormWidget(
                  hint: "",
                  obscure: false,
                  labelText: "Nama Peserta",
                  textEditingController: prov.namaPesertaController,
                  labelStyle: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                FormWidget(
                  hint: "",
                  obscure: false,
                  labelText: "Nomor Kartu",
                  textEditingController: prov.nomorKartuController,
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
            Provider.of<AsuransiProvider>(context, listen: false).updateAsuransi(context);
          },
        ),
      )
    );
  }
}
