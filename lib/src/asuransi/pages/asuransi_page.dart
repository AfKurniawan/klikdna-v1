import 'package:flutter/material.dart';
import 'package:new_klikdna/src/asuransi/widgets/asuransi_items_widget.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/card_insurance_item.dart';
import 'package:new_klikdna/src/patient_card/widgets/custom_dialog_confirm.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class AsuransiPage extends StatefulWidget {

  @override
  _AsuransiPageState createState() => _AsuransiPageState();
}

class _AsuransiPageState extends State<AsuransiPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PatientCardProvider>(context);
    return Scaffold(
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
              //Provider.of<AsuransiProvider>(context, listen: false).saveAsuransi(context);
              Navigator.pushReplacementNamed(context, 'add_asuransi_page');
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
