
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_klikdna/src/account/models/account_model.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/profile/providers/profile_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class DetailProfilePage extends StatefulWidget {
  final AccountModel model;

  DetailProfilePage({Key key, this.model}) : super(key: key);

  @override
  _DetailProfilePageState createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  @override
  void initState() {
    Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
//      title: Consumer<ProfileProvider>(
//        builder: (context, model, _){
//          return Text("${model.name}");
//        },
        title: Text(
          "Detil Profil",
          style: TextStyle(color: Colors.black),
        ),

        elevation: 0,
        backgroundColor: Colors.transparent,
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
        // actions: <Widget>[
        //   FadeAnimation(
        //     1,
        //     IconButton(
        //       icon: IconBagdeWidget(
        //         imageicon: "assets/icons/notif_icon.png",
        //         color: MyColors.dnaGreen,
        //         width: 20,
        //         height: 28,
        //         count: "0",
        //       ),
        //       color: MyColors.grey,
        //       onPressed: () {
        //         Navigator.pushNamed(context, "cart_page");
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Consumer<AccountProvider>(
                            builder: (context, model, _) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child:  Image.asset(
                                    "assets/images/no_image.png",
                                    width: 80,
                                    fit: BoxFit.cover,
                                    height: 80,
                                    // height: 150,
                                  )
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Consumer<AccountProvider>(
                        builder: (context, model, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prov.name == null ? "" : prov.name,
                                style: TextStyle(
                                    color: MyColors.dnaGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              // Text(
                              //   prov.mobile,
                              //   style: TextStyle(
                              //       color: MyColors.dnaGreen, fontSize: 16),
                              // ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: OutlineButtonAndIconWidget(
                //         btnText: "Kode QR",
                //         color: Colors.transparent,
                //         height: 50,
                //         textColor: MyColors.dnaGreen,
                //         myIcon: ImageIcon(
                //             AssetImage("assets/icons/qr_icon.png"),
                //             color: MyColors.dnaGreen),
                //         btnAction: () {},
                //       ),
                //     ),
                //     SizedBox(
                //       width: 16,
                //     ),
                //     Expanded(
                //       child: ButtonAndIconWidget(
                //         btnText: "Pindai",
                //         myIcon: ImageIcon(
                //             AssetImage("assets/icons/scan_icon.png"),
                //             color: Colors.white),
                //         color: MyColors.dnaGreen,
                //         btnAction: () {
                //           Provider.of<ProfileProvider>(context, listen: false)
                //               .scanBarcode(context);
                //           //prov.scanBarcode(context);
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Akun",
                  style: TextStyle(
                      color: Color(0xff242424),
                      fontSize: 22,
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
                        Text("Lihat Profil", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tentang",
                  style: TextStyle(
                      color: Color(0xff242424),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.alignLeft),
                  title: Text("Syarat dan Ketentuan"), // ke halaman lorem ipsum
                  contentPadding: EdgeInsets.only(top: 0),
                  onTap: () {
                    //Provider.of<DetailProfileProvider>(context, listen: false).syaratKetentuan();
                    Navigator.of(context).pushNamed("lorem_ipsum_page");
                  },
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.shieldAlt),
                  title: Text("Kebijakan Privasi"), // ke halaman lorem ipsum
                  contentPadding: EdgeInsets.only(top: 0),
                  onTap: (){
                    Navigator.of(context).pushNamed("lorem_ipsum_page");
                    //Provider.of<ProfileProvider>(context, listen: false).kebijakanPrivasi();
                  },
                ),
                // ListTile(
                //   leading: Icon(FontAwesomeIcons.newspaper),
                //   title: Text("Lembar Persetujuan"),
                //   contentPadding: EdgeInsets.only(top: 0),
                //   onTap: (){
                //     Provider.of<DetailProfileProvider>(context, listen: false).lembarPersetujuan();
                //   },
                // ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.lightbulb),
                  title: Text("Cara Menggunakan"),
                  contentPadding: EdgeInsets.only(top: 0),
                  onTap: (){
                    Navigator.of(context).pushNamed("lorem_ipsum_page");
                  },
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.only(left: 2),
                  leading:
                  ImageIcon(AssetImage("assets/images/logo.png"), size: 30),
                  title: Text("Kontak KlikDNA"),
                  childrenPadding: EdgeInsets.only(left: 40),
                  children: [
                    ListTile(
                      leading: Icon(FontAwesomeIcons.phone, size: 18),
                      title: Text("Telepon"),
                      onTap: () {
                        Provider.of<ProfileProvider>(context, listen: false).makeCallPhone(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.whatsapp, size: 18),
                      title: Text("Whatsapp"),
                      onTap: () {
                        Provider.of<ProfileProvider>(context, listen: false).openWhatsapp(context);
                      },
                    ),
                    // ListTile(
                    //   leading: Icon(FontAwesomeIcons.telegramPlane, size: 20),
                    //   title: Text("Telegram"),
                    //   onTap: () {
                    //     Provider.of<DetailProfileProvider>(context, listen: false).openTelegram(context);
                    //   },
                    // ),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.envelopeOpen, size: 18),
                      title: Text("Email"),
                      onTap: () {
                        Provider.of<ProfileProvider>(context, listen: false).sendEmail(context);
                      },
                    ),
                  ],
                ),
                ListTile(
                  leading:
                  Icon(FontAwesomeIcons.powerOff, color: Colors.grey[400]),
                  title:
                  Text("Keluar", style: TextStyle(color: Colors.grey[400])),
                  contentPadding: EdgeInsets.only(top: 0),
                  onTap: () {
                    Provider.of<ProfileProvider>(context, listen: false).logout(context);
                    //context.read()<ProfileProvider>().logout(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
