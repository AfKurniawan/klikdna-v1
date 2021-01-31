import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:new_klikdna/src/member/providers/member_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_and_icon_widget.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/dialogs/row_button_pop_dialog_widget.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;


class NewMainReportPage extends StatefulWidget {
  static const String id = "/report_page";

  @override
  _NewMainReportPageState createState() => _NewMainReportPageState();
}

class _NewMainReportPageState extends State<NewMainReportPage> {


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final prov = Provider.of<MemberProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Report", style: TextStyle(color: Colors.white, fontSize: 14)),
        centerTitle: true,
        elevation: 0,
      ),
      body: prov.isLoading == true
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(strokeWidth: 2))
          : Stack(
        children: <Widget>[
          Container(
            height: 80,
            decoration: BoxDecoration(
                color: MyColors.dnaGreen,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed("home_report_page");
                      },
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 4),
                              blurRadius: 10,
                              color: Color(0xFFB0CCE1).withOpacity(0.62),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Genetics Indonesia",
                                  style: TextStyle(
                                      fontSize: 14
                                  )),
                              Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        child: ButtonAndIconWidget(
          btnText: "Lab Lainnya",
          btnAction: (){
            showPopDialog(context);
          },
          color: MyColors.dnaGreen,
          height: 50,
          widht: 200,
          myIcon: Icons.add_circle_rounded,
          iconColor: Colors.white,
        ),
      ),
    );
  }

}

Future<void> showPopDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) => RowButtonPopDialogWidget(
        title: "",
        description: "Tampilkan file data genomik kamu ?",
        filledButtonText: "Lanjutkan",
        filledButtonaction: (){

        },
        disabledButtonText: "Tidak",
        disabledButtonAction: (){
          Navigator.of(context).pop();
        },
      ));
}
