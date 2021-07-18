import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/card_insurance_item.dart';
import 'package:new_klikdna/src/patient_card/widgets/custom_dialog_confirm.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class AsuransiPage extends StatefulWidget {


  @override
  _AsuransiPageState createState() => _AsuransiPageState();
}

class _AsuransiPageState extends State<AsuransiPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();


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
        elevation: 0.2,
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
                    height: 150,
                    child: Image.asset(
                        "assets/images/no_patient_card.png"),
                  ),
                  Text(
                      "Belum ada Kartu Asuransi tersimpan",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 14)),
                  SizedBox(height: 12),
                  Text(
                    "Yuk, tambah kartu asuransi kamu agar lebih mudah saat melihat data yang disimpan",
                    textAlign:
                    TextAlign.center,
                    style: TextStyle(
                        fontWeight:
                        FontWeight.w300,
                        fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        )
        : Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 18),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: prov.listAsuransi.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kartu Asuransi ${index+1}", style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500
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
                    SizedBox(height: 12),
                    CardInssuranceItem(
                        model: prov.listAsuransi[index]),
                  ],
                );
              }),
        ),
      ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ButtonWidget(
            height: 50,
            btnText: "Tambah Kartu Asuransi",
            color: MyColors.dnaGreen,
            btnAction: (){
              //Provider.of<AsuransiProvider>(context, listen: false).showModalAddInsuranceCard(context);
              Navigator.pushReplacementNamed(context, "add_asuransi_page");
            },
          ),
        )
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
