import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/card_insurance_item.dart';
import 'package:new_klikdna/src/patient_card/widgets/custom_dialog_confirm.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:provider/provider.dart';

class AsuransiPage extends StatefulWidget {


  @override
  _AsuransiPageState createState() => _AsuransiPageState();
}

class _AsuransiPageState extends State<AsuransiPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final _formKey = GlobalKey<FormState>();

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

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PatientCardProvider>(context);
    return Scaffold(
      key: globalScaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Asuransi",
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
        child: prov.listAsuransi.length == 0 ?
        Container(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset("assets/images/no_patient_card.png",
                        width: MediaQuery.of(context).size.width / 1.5),
                  ),
                  Text("Belum ada Kartu Asuransi tersimpan",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: prov.listAsuransi.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              int i = 0;
              if(prov.listAsuransi.length > i){
               i = index;
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kartu Asuransi ${index+1}", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        )),
                        Row(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.of(context).pushNamed("edit_asuransi_page", arguments: prov.listAsuransi[index]);
                                },
                                child: Text("Ubah", style: TextStyle(color: MyColors.dnaGreen),)),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: (){
                                showDialogKonfirmasiHapus(context, prov.listAsuransi[index].id);
                              },
                                child: Text("Hapus", style: TextStyle(color: MyColors.grey)))
                          ],
                        )
                      ],
                    ),
                  ),
                  CardInssuranceItem(
                      model: prov.listAsuransi[index]),
                ],
              );
            }),
      ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ButtonWidget(
            height: 60,
            btnText: "Tambah Kartu Asuransi",
            color: MyColors.dnaGreen,
            btnAction: (){
              Provider.of<TokenProvider>(context, listen: false).getApiToken();
              //Navigator.pushReplacementNamed(context, 'add_asuransi_page');
              showModalAddInsuranceCard(context);
            },
          ),
        )
    );
  }

  void showModalAddInsuranceCard(BuildContext context){
    var prov = Provider.of<AsuransiProvider>(context, listen: false);
    final validator = RequiredValidator(errorText: "Form wajib diisi");
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext _) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height - 25,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Tambah Asuransi", style: TextStyle(fontSize: 14)),
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 20),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
               margin: EdgeInsets.only(top: 20),
               // height: MediaQuery.of(context).size.height - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _formKey,
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
                              validator: validator,
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
                              validator: validator,
                              obscure: false,
                              labelText: "Pemegang Polis",
                              textEditingController: prov.addPemegangPolisController,
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            FormWidget(
                              hint: "",
                              obscure: false,
                              validator: validator,
                              labelText: "Nama Peserta",
                              textEditingController: prov.addNamaPesertaController,
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            FormWidget(
                              hint: "",
                              validator: validator,
                              obscure: false,
                              labelText: "Nomor Kartu",
                              keyboardType: TextInputType.number,
                              textEditingController: prov.addNomorKartuController,
                              labelStyle: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10.0),
              child: prov.addNamaAsuransiController.text.isEmpty ?  ButtonWidget(
                btnText: "Simpan",
                height: 50,
                color: MyColors.grey,
              ) : ButtonWidget(
                btnText: "Simpan",
                btnAction: (){
                  //Provider.of<AsuransiProvider>(context, listen: false).addAsuransi(context, addAsuransi);
                  if (_formKey.currentState.validate() && prov.addNamaAsuransiController.text.isNotEmpty) {
                    context.read<AsuransiProvider>().addAsuransi(context, tipeValue);
                  }
                },
                height: 50,
                color: MyColors.dnaGreen,
              ),
            ),
          ),
        );
      },
    );
  }


  Future<void> showDialogKonfirmasiHapus(BuildContext context, int id) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => CustomDialogKonfirmasiWidget(
          title: "Kartu Asuransi ini akan dihapus",
          description: "Apakah kamu yakin akan menghapus Kartu Asuransi ini?",
          filledButtonText: "Batal",
          outlineButtonText: "Hapus",
          filledButtonaction: (){
            Navigator.of(context).pop();

          },
          outlineButtonAction: (){
            Provider.of<AsuransiProvider>(context, listen: false).deleteAsuransi(context, id);
          },
        ));
  }
}
