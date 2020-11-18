import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class LihatProfilePage extends StatefulWidget {
  @override
  _LihatProfilePageState createState() => _LihatProfilePageState();
}

class _LihatProfilePageState extends State<LihatProfilePage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, prov, _){
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                "Profil",
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
                    //Navigator.pushReplacementNamed(context, "detail_report_page");
                    Navigator.of(context).pop();
                  }),
            ),
            body: prov.isLoading == true
                ? Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(strokeWidth: 2))
                : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                        color: MyColors.dnaGreen,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: new ColorFilter.mode(
                                MyColors.dnaGreen.withOpacity(0.2),
                                BlendMode.dstATop),
                            image: AssetImage(
                                "assets/images/header_background.png"))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // ClipRRect(
                          //         borderRadius: BorderRadius.circular(50),
                          //         child: prov.photoView == null ?
                          //         Image.asset("assets/images/no_image.png", height: 100, width: 100, fit: BoxFit.cover)
                          //             : Image.memory(
                          //           prov.photoView,
                          //           width: 100,
                          //           fit: BoxFit.cover,
                          //           height: 100,
                          //           // height: 150,
                          //         )
                          // )
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset("assets/images/no_image.png",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover))

                        ],
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama"),
                          SizedBox(height: 10),
                          Text(prov.vfirstname == null ? "-" : "${prov.vfirstname} ${prov.vlastname}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("Tanggal Lahir"),
                          SizedBox(height: 10),
                          Text(prov.vbirthdate == null ? "-" : "${prov.vbirthdate}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("Jenis Kelamin"),
                          SizedBox(height: 10),
                          Text(prov.vgender == null ? "-" : "${prov.vgender}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("Email"),
                          SizedBox(height: 10),
                          Text(prov.vprofilEmail == null ? "-" : "${prov.vprofilEmail}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("No. Ponsel"),
                          SizedBox(height: 10),
                          Text(prov.vphone == null ? "-" : "${prov.vphone}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("Alamat"),
                          SizedBox(height: 10),
                          Text(
                              prov.vaddress == null ? "-"
                                  : prov.vaddress, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text("Alamat Web Replika"),
                          SizedBox(height: 10),
                          Text(prov.vreferralUrl == null ? "-" : "${prov.vreferralUrl}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 8),
                  // Container(
                  //   color: Colors.white,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 18.0, top: 10, right: 18, bottom: 10),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text("Jenis Kelamin"),
                  //         SizedBox(height: 10),
                  //         Text(prov.gender == null ? "-"  : prov.gender == "male" ? "Pria" : prov.gender == "female" ? "Wanita"
                  //             : prov.gender,
                  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )

        );
      },

    );
  }
}
