import 'package:flutter/material.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/src/patient_card/providers/asuransi_provider.dart';
import 'package:new_klikdna/src/patient_card/widgets/custom_dialog_confirm.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class AsuransiItemWidget extends StatefulWidget {
  final Asuransi model;

  const AsuransiItemWidget({
    Key key, this.model
  }) : super(key: key);

  @override
  _AsuransiItemWidgetState createState() => _AsuransiItemWidgetState();
}

class _AsuransiItemWidgetState extends State<AsuransiItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:0, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 2,
              color: MyColors.grey
          )
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Asuransi"),
                    SizedBox(height: 10),
                    Text("Nomor Polis"),
                    SizedBox(height: 10),
                    Text("Pemegang Polis"),
                    SizedBox(height: 10),
                    Text("Nama Peserta"),
                    SizedBox(height: 10),
                    Text("Nomor Kartu"),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(":"),
                    SizedBox(height: 10),
                    Text(":"),
                    SizedBox(height: 10),
                    Text(":"),
                    SizedBox(height: 10),
                    Text(":"),
                    SizedBox(height: 10),
                    Text(":"),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model.nomorAsuransi == null ? "-" : widget.model.nomorAsuransi),
                    SizedBox(height: 10),
                    Text(widget.model.nomorPolis == null ? "-" : widget.model.nomorPolis),
                    SizedBox(height: 10),
                    Text(widget.model.pemegangPolis == null ? "-" : widget.model.pemegangPolis),
                    SizedBox(height: 10),
                    Text(widget.model.nomorKartu == null ? "-" : widget.model.nomorKartu),
                    SizedBox(height: 10),
                    Text(widget.model.namaPeserta == null ? "-" : widget.model.namaPeserta),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15.0, right: 15, bottom: 15, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    child: Text("Ubah", style: TextStyle(color: MyColors.dnaGreen)),
                  onTap: (){
                      Navigator.of(context).pushNamed("edit_asuransi_page", arguments: widget.model);
                  },
                ),
                GestureDetector(
                    child: Text("Hapus", style: TextStyle(color: MyColors.kPrimaryColor)),
                  onTap: (){
                      showDialogKonfirmasiHapus(context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> showDialogKonfirmasiHapus(BuildContext context) async {
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
            Provider.of<AsuransiProvider>(context, listen: false).deleteAsuransi(context, widget.model.id);
          },
        ));
  }
}