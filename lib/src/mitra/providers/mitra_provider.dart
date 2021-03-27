import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/login/models/login_model.dart';
import 'package:new_klikdna/src/mitra/widgets/card_type_dua_widget.dart';
import 'package:new_klikdna/src/mitra/widgets/card_type_satu_widget.dart';
import 'package:new_klikdna/src/profile/widgets/cupertino_dialog_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MitraProvider with ChangeNotifier {

  var formattedCommission = new NumberFormat.currency(name: "", locale: "en_US".toString());
  var totalFormattedCommision = new NumberFormat.currency(name: "", locale: "en_US");
  SharedPreferences prefs;
  bool isLoading;

  /// USER ID
  int vuserid;
  String vprofilEmail;
  String vreferralUrl;

  ///AGENT
  String vnik;
  String vnpwp;
  String vreligion;
  String vjob;
  String vstatus;
  bool vverified;
  bool vmaster;
  bool vstockist;


  ///MEMBER
  String vnumber;
  String vfirstname;
  String vlastname;
  String vallName ;
  String vbirthdate;
  String vgender;
  String vaddress;
  String vkelurahan;
  String vsubdistrict;
  String vcity;
  String vprovince;
  String vzipcode;
  String vphone;
  int vleftcv;
  int vrightcv;
  int vleftpointreward;
  int vrightpointreward;
  var vcommission = ".00";
  String vrank;
  String vpar;
  String vexpired;
  var vhighestrank;
  String vtimoneposition;
  String vtimtwoposition;
  int vtimone;
  int vtimtwo;
  var vtotalcommission;
  String vtype;
  String vmonthlycycle;
  String vdailycycle;



  ///SPONSOR
  String vsponsorfirstname;
  String vsponsorlastname;
  String vsponsorgender;
  String vsponsoraddress;
  String vsponsorkelurahan;
  String vsponsorsubdistrict;
  String vsponsorcity;
  String vsponsorprovince;
  String vsponsorphone;

  /// WEBVIEWS
  String vdashboard;
  String vtree;
  String vgenerasi;
  String vreferral;
  String vcv;
  String vpointreward;
  String vkebijakanPrivacy;
  String vketentuanPengguna;

  /// WALLETS
  String vmethod;
  String vwalleturl;

  ///PARAMS
  String vaccesskey;
  String vtypeId;
  String vdatefrom;
  String vdateto;


  String parsedTanggalExpired ;
  var tglLahir ;

  var formatTgl = DateFormat('dd MMM yyyy', "id_ID");
  var formatTglLahir = DateFormat('dd MMMM yyyy', "id_ID");
  var expParsedDate ;
  String vtglLahir ;
  String vallAddress ;
  var responseJson ;

  List<Widget> slideCard = [];

  int current = 0;




  Future<LoginModel> refreshMitraData() async {
    prefs = await SharedPreferences.getInstance();
    isLoading = true;
    notifyListeners();

    var url = AppConstants.LOGIN_URL;
    var body = json.encode({
      "email" : prefs.getString('email'),
      "password": prefs.getString("passing")
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseJson = LoginModel.fromJson(json.decode(response.body));

    if(responseJson.user.code == 200){

      slideCard = [
        CardTypeSatuWidget(),
        CardTypeDuaWidget()
      ];

      isLoading = false ;

      prefs.setBool('isLogin', true);

      /// USER
       vuserid = responseJson.user.id;
       prefs.setInt("mitraID", responseJson.user.id);

       ///

      ///MEMBER
      vnumber = responseJson.user.member.number;
      vfirstname = responseJson.user.member.firstname;
      vlastname = responseJson.user.member.lastname;
      vbirthdate = responseJson.user.member.birthdate.substring(0, 10);
      vgender = responseJson.user.member.gender;
      vaddress = responseJson.user.member.address;
      vkelurahan = responseJson.user.member.kelurahan;
      vsubdistrict = responseJson.user.member.subdistrict;
      vcity = responseJson.user.member.city;
      vprovince = responseJson.user.member.province;
      vzipcode = responseJson.user.member.zipcode;
      vphone = responseJson.user.member.phone;
      vleftcv = responseJson.user.member.leftcv;
      vrightcv = responseJson.user.member.rightcv;
      vleftpointreward = responseJson.user.member.leftpointreward;
      vrightpointreward = responseJson.user.member.rightpointreward;
      vallName = vfirstname + " " + vlastname ;

      if(responseJson.user.member.commission == null) {
        vcommission = responseJson.user.member.commission.toString();
      } else {
        vcommission = formattedCommission.format(responseJson.user.member.commission);
      }


      vrank = responseJson.user.member.rank;
      vpar = responseJson.user.member.par;
      vhighestrank = responseJson.user.member.highestrank.toString();
      vtimoneposition = responseJson.user.member.timoneposition;
      vtimtwoposition = responseJson.user.member.timtwoposition ;
      vtimone = responseJson.user.member.timone;
      vtimtwo = responseJson.user.member.timtwo ;
      vtotalcommission = totalFormattedCommision.format(responseJson.user.member.totalcommission);
      vtype = responseJson.user.member.type;
      vprofilEmail = responseJson.user.email;
      vreferralUrl = responseJson.user.referralUrl;
      vmonthlycycle = responseJson.user.member.monthlycycle.toString();
      vdailycycle = responseJson.user.member.dailycycle.toString();

      ///SPONSOR
      vsponsorfirstname = responseJson.user.sponsor.firstname;
      vsponsorlastname = responseJson.user.sponsor.lastname;
      vsponsorgender = responseJson.user.sponsor.gender;
      vsponsoraddress = responseJson.user.sponsor.address;
      vsponsorkelurahan = responseJson.user.sponsor.kelurahan;
      vsponsorsubdistrict = responseJson.user.sponsor.subdistrict;
      vsponsorcity = responseJson.user.sponsor.city;
      vsponsorphone = responseJson.user.sponsor.phone;
      vsponsorprovince = responseJson.user.sponsor.province;

      ///WEBVIEWS
      vdashboard = responseJson.user.webviews.dashboard;
      vtree = responseJson.user.webviews.tree;
      vreferral =  responseJson.user.webviews.referral;
      vcv = responseJson.user.webviews.cv;
      vpointreward = responseJson.user.webviews.pointreward;
      vkebijakanPrivacy = responseJson.user.webviews.kebijakanPrivacy;
      vketentuanPengguna = responseJson.user.webviews.ketentuanPengguna;

      ///WALLETS
      vmethod = responseJson.user.jsonData.wallets.method;
      vaccesskey = responseJson.user.jsonData.wallets.params.accesskey;
      vwalleturl = responseJson.user.jsonData.wallets.url;

      ///PARAMS OPTIONAL
      vaccesskey = responseJson.user.jsonData.referrals.params.accesskey;

      vtypeId = responseJson.user.jsonData.referrals.params.typeId;

      vdatefrom = responseJson.user.jsonData.referrals.params.datefrom;

      vdateto = responseJson.user.jsonData.referrals.params.dateto;

      if(responseJson.user.member.expired == null) {
        vexpired = "-" ;
      } else {
        vexpired = responseJson.user.member.expired;
      }

          String nulledExpired = responseJson.user.member.expired == null ? "-" : responseJson.user.member.expired;

          if(nulledExpired == "-"){
              expParsedDate = "-" ;
              parsedTanggalExpired = "-" ;
          } else {
              expParsedDate = DateTime.parse(prefs.getString("expired")).toLocal();
              parsedTanggalExpired = ('${formatTgl.format(expParsedDate).substring(0, 11)}');
          }




      notifyListeners();


    } else if(responseJson.user.code == 400) {
      isLoading = false;
      notifyListeners();


    }
    return responseJson;
  }


  void treeWebview(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true, universalLinksOnly: true);
    } else {
      throw 'Could not launch $url';
    }

  }

  void openWhatsapp(BuildContext context, String whatsapp, String name) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoDialogWidget(
          title: "Menghubungi via Whatsapp",
          message:
          'Apakah anda yakin akan menghubungi $name melalui Whatsapp ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('whatsapp://send?phone=62$whatsapp');
            } else {
              launch('whatsapp://send?phone=62$whatsapp');
            }
          },
        );
      },
    );
  }

  void makePhoneCall(BuildContext context, String nomor, String nama) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoDialogWidget(
          title: "Menghubungi via Telepon",
          message:
          'Apakah anda yakin akan menghubungi $nama melalui Telepon ?',
          action: () {
            Navigator.of(context).pop();
            if (Platform.isIOS) {
              launch('tel:$nomor');
            } else {
              launch('tel:$nomor');
            }
          },
        );
      },
    );
  }
}

