import 'package:flutter/material.dart';
import 'package:new_klikdna/src/asuransi/widgets/asuransi_items_widget.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
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
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: prov.listAsuransi.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AsuransiItemWidget(
                    model: prov.listAsuransi[index]);
              }),
        ),
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
}
