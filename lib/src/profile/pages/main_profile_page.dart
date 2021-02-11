
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_klikdna/src/account/models/account_model.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/src/profile/providers/profile_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class MainProfilePage extends StatefulWidget {
  final AccountModel model;

  MainProfilePage({Key key, this.model}) : super(key: key);

  @override
  _MainProfilePageState createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  @override
  void initState() {
    Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[20],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profil",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),

        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.grey,
              size: 20,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "main_page",
                  arguments: 0);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Consumer<PatientCardProvider>(
                        builder: (context, model, _) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: model.photoView == null ?
                              Image.asset("assets/images/no_image.png", height: 62, width: 62, fit: BoxFit.cover)
                                  : Image.memory(
                                model.photoView,
                                width: 62,
                                fit: BoxFit.cover,
                                height: 62,
                                // height: 150,
                              ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Consumer<LoginProvider>(
                    builder: (context, model, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("${model.vallName}",
                              style: TextStyle(
                                  color: MyColors.dnaBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Text("${model.vphone}",
                              style: TextStyle(
                                  color: MyColors.dnaBlack,
                                  fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 4),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Akun",
                      style: TextStyle(
                          color: Color(0xff242424),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed("lihat_profile_page", arguments: widget.model);
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            ImageIcon(AssetImage("assets/icons/person_icon.png"), size: 25, color: Colors.grey[500]),
                            SizedBox(width: 30),
                            Text("Lihat Profil", style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Consumer<LoginProvider>(
                  builder: (child, model, _){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tentang",
                          style: TextStyle(
                              color: Color(0xff242424),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.alignLeft, size: 20),
                          title: Text("Syarat dan Ketentuan",
                              style: TextStyle(fontSize: 14)), // ke halaman lorem ipsum
                          contentPadding: EdgeInsets.only(top: 0),
                          onTap: () {
                            Provider.of<ProfileProvider>(context, listen: false).syaratKetentuan(model.vketentuanPengguna);
                            //Navigator.of(context).pushNamed("lorem_ipsum_page");
                          },
                        ),
                        ListTile(
                          leading: Icon(FontAwesomeIcons.shieldAlt, size: 20),
                          title: Text("Kebijakan Privasi",
                              style: TextStyle(
                                  fontSize: 14
                              )), // ke halaman lorem ipsum
                          contentPadding: EdgeInsets.only(top: 0),
                          onTap: (){
                            Provider.of<ProfileProvider>(context, listen: false).kebijakanPrivasi(model.vkebijakanPrivacy);
                          },
                        ),
                        // ListTile(
                        //   leading: Icon(FontAwesomeIcons.lightbulb, size: 20),
                        //   title: Text("Cara Menggunakan",
                        //       style: TextStyle(fontSize: 14)),
                        //   contentPadding: EdgeInsets.only(top: 0),
                        //   onTap: (){
                        //     Navigator.of(context).pushNamed("lorem_ipsum_page");
                        //   },
                        // ),
                        ExpansionTile(
                          tilePadding: EdgeInsets.only(left: 2),
                          leading:
                          ImageIcon(AssetImage("assets/images/logo.png"), size: 25),
                          title: Text("Kontak KlikDNA",
                              style: TextStyle(
                                  fontSize: 14
                              )),
                          childrenPadding: EdgeInsets.only(left: 40),
                          children: [
                            ListTile(
                              leading: Icon(FontAwesomeIcons.phone, size: 16),
                              title: Text("Telepon",
                                  style: TextStyle(
                                      fontSize: 14
                                  )),
                              onTap: () {
                                Provider.of<ProfileProvider>(context, listen: false).makeCallPhone(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(FontAwesomeIcons.whatsapp, size: 18),
                              title: Text("Whatsapp",
                                  style: TextStyle(
                                      fontSize: 14
                                  )),
                              onTap: () {
                                Provider.of<ProfileProvider>(context, listen: false).openWhatsapp(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(FontAwesomeIcons.telegram, size: 16),
                              title: Text("Telegram",
                                  style: TextStyle(
                                      fontSize: 14
                                  )),
                              onTap: () {
                                Provider.of<ProfileProvider>(context, listen: false).openTelegram(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(FontAwesomeIcons.envelopeOpen, size: 16),
                              title: Text("Email",
                                  style: TextStyle(
                                      fontSize: 14
                                  )),
                              onTap: () {
                                Provider.of<ProfileProvider>(context, listen: false).sendEmail(context);
                              },
                            ),
                          ],
                        ),
                        ListTile(
                          leading:
                          Icon(FontAwesomeIcons.powerOff, color: Colors.grey[400], size: 18),
                          title:
                          Text("Keluar", style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                          contentPadding: EdgeInsets.only(top: 0),
                          onTap: () {
                            Provider.of<ProfileProvider>(context, listen: false).logout(context);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
