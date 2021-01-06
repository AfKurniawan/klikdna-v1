import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';


class DetailProfilePage extends StatefulWidget {
  @override
  _DetailProfilePageState createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  @override
  void initState() {
    Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
    Provider.of<PatientCardProvider>(context, listen: false).getPatientCard(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, prov, _){
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Detail Profil",
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: MyColors.grey,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "main_page",
                      arguments: 0);
                }),
          ),
          body: prov.isLoading == true ?
          Center(
              child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(strokeWidth: 2)
          ) :
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "detail_profile_page");
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 6,
                    color: Colors.white,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 1000),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 5),
                                  shape: BoxShape.circle),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset("assets/images/no_image.png",
                                      height: 64, width: 64)),
                            ),
                          ),

                          Text(
                            prov.vfirstname == null ? "" : "${prov.vfirstname} ${prov.vlastname}",
                            style: TextStyle(
                                color: MyColors.dnaGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              Navigator.pushNamed(context, "detail_profile_page");
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 5,
                  color: Colors.grey[100],
                ),
                // Container(
                //   color: Colors.white,
                //   width: MediaQuery.of(context).size.width,
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 20),
                //     child: Text("ANGGOTA KELUARGAMU",
                //         style: TextStyle(
                //             color: MyColors.dnaGrey, fontWeight: FontWeight.bold)),
                //   ),
                // ),
                Container(
                  height: 5,
                  color: Colors.grey[100],
                ),
                //listLinkedAccountWidget(context, prov),
              ],
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: EdgeInsets.only(left: 20.0, right: 20, top: 5, bottom: 10),
          //   child: OutlineButtonWidget(
          //     btnText: "Logout",
          //     height: 45,
          //     outlineTextColor: MyColors.dnaGreen,
          //     btnAction: () async {
          //       //Navigator.pushNamed(context, "add_linked_account_page");
          //       SharedPreferences prefs = await SharedPreferences.getInstance();
          //       prefs.clear();
          //       Navigator.pushReplacementNamed(context, "login_page");
          //     },
          //   ),
          // ),
        );
      },
    );
  }
}
