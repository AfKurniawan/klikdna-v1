import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/login/models/login_model.dart';
import 'package:new_klikdna/src/login/widgets/login_error_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier{


    bool obscureText = true;

    void toggle() {
        obscureText = !obscureText;
        notifyListeners();
    }


    bool isLoading ;
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    SharedPreferences prefs;
    String buttonText = "Masuk";


    /// USER ID
    int userid;
    String profilEmail;
    String referralUrl;

    ///MEMBER
    String number;
    String firstname;
    String lastname;
    String birthdate;
    String gender;
    String address;
    String kelurahan;
    String subdistrict;
    String city;
    String province;
    String zipcode;
    String phone;
    int leftcv;
    int rightcv;
    int leftpointreward;
    int rightpointreward;
    var commission = ".00";
    String rank;
    String par;
    String expired;
    var highestrank;
    int timone;
    int timtwo;
    int totalcommission;
    String type;

    ///SPONSOR
    String sponsorfirstname;
    String sponsorlastname;
    String sponsorgender;
    String sponsoraddress;
    String sponsorkelurahan;
    String sponsorsubdistrict;
    String sponsorcity;
    String sponsorprovince;
    String sponsorphone;

    /// WEBVIEWS
    String dashboard, tree, generasi, referral, cv, pointreward, kebijakanPrivacy, ketentuanPengguna;

    /// WALLETS
    String method, walleturl;

    ///PARAMS
    String accesskey, typeId, datefrom, dateto;


    var formattedCommission = new NumberFormat.currency(name: "");



    Future<LoginModel> loginAction(BuildContext context) async {
        prefs = await SharedPreferences.getInstance();
        isLoading = true;
        notifyListeners();
        String email = emailController.text;
        String password = passwordController.text;

        var url = AppConstants.LOGIN_URL;
        var body = json.encode({
            "email" : email,
            "password": password
        });

        Map<String, String> headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
        };

        final response = await http.post(url, body: body, headers: headers);
        final responseJson = LoginModel.fromJson(json.decode(response.body));

        if(responseJson.user.code == 200){
            print("RESPONSE BODY: ${response.body}");
            isLoading = false ;
            prefs.setBool('isLogin', true);

            /// USER
            number = responseJson.user.member.number;
            prefs.setString("number", responseJson.user.member.number);

            userid = responseJson.user.id;
            prefs.setInt("userid", responseJson.user.id);
            ///MEMBER
            number = responseJson.user.member.number;
            prefs.setString("number", responseJson.user.member.number);

            firstname = responseJson.user.member.firstname;
            prefs.setString("firstname", responseJson.user.member.firstname.toUpperCase());

            lastname = responseJson.user.member.lastname;
            prefs.setString("lastname", responseJson.user.member.lastname.toUpperCase());

            birthdate = responseJson.user.member.birthdate;
            prefs.setString("birthdate", responseJson.user.member.birthdate.substring(0, 10));

            gender = responseJson.user.member.gender;
            prefs.setString("gender", responseJson.user.member.gender);

            address = responseJson.user.member.address;
            prefs.setString("address", responseJson.user.member.address);

            kelurahan = responseJson.user.member.kelurahan;
            prefs.setString("kelurahan", responseJson.user.member.kelurahan);

            subdistrict = responseJson.user.member.subdistrict;
            prefs.setString("subdistrict", responseJson.user.member.subdistrict);

            city = responseJson.user.member.city;
            prefs.setString("city", responseJson.user.member.city);

            province = responseJson.user.member.province;
            prefs.setString("province", responseJson.user.member.province);

            zipcode = responseJson.user.member.zipcode;
            prefs.setString("zipcode", responseJson.user.member.zipcode);

            phone = responseJson.user.member.phone;
            prefs.setString("phone", responseJson.user.member.phone);

            leftcv = responseJson.user.member.leftcv;
            prefs.setInt("leftcv", responseJson.user.member.leftcv);

            rightcv = responseJson.user.member.rightcv;
            prefs.setInt("rightcv", responseJson.user.member.rightcv);

            leftpointreward = responseJson.user.member.leftpointreward;
            prefs.setInt("leftpointreward", responseJson.user.member.leftpointreward);

            rightpointreward = responseJson.user.member.rightpointreward;
            prefs.setInt("rightpointreward", responseJson.user.member.leftpointreward);

            commission = formattedCommission.format(responseJson.user.member.commission);
            prefs.setString("commission", formattedCommission.format(responseJson.user.member.commission));

            rank = responseJson.user.member.rank;
            prefs.setString("rank", responseJson.user.member.rank);

            par = responseJson.user.member.par;
            prefs.setString("par", responseJson.user.member.par);

            expired = responseJson.user.member.expired;
            prefs.setString("expired", responseJson.user.member.expired);

            highestrank = responseJson.user.member.highestrank;
            prefs.setString("highestrank", responseJson.user.member.highestrank);

            timone = responseJson.user.member.timone;
            prefs.setInt("timone", responseJson.user.member.timone);

            timtwo = responseJson.user.member.timtwo;
            prefs.setInt("timtwo", responseJson.user.member.timtwo);

            totalcommission = responseJson.user.member.totalcommission;
            prefs.setInt("totalcommission", responseJson.user.member.totalcommission);

            type = responseJson.user.member.type;
            prefs.setString("type", responseJson.user.member.type);

            profilEmail = responseJson.user.email;
            prefs.setString("profilemail", responseJson.user.email);

            referralUrl = responseJson.user.referralUrl;
            prefs.setString("referralurl", responseJson.user.referralUrl);



            ///SPONSOR
            sponsorfirstname = responseJson.user.sponsor.firstname;
            prefs.setString("sponsorfirstname", responseJson.user.sponsor.firstname);

            sponsorlastname = responseJson.user.sponsor.lastname;
            prefs.setString("sponsorlastname", responseJson.user.sponsor.lastname);

            sponsorgender = responseJson.user.sponsor.gender;
            prefs.setString("sponsorgender", responseJson.user.sponsor.gender);

            sponsoraddress = responseJson.user.sponsor.address;
            prefs.setString("sponsoraddress", responseJson.user.sponsor.address);

            sponsorkelurahan = responseJson.user.sponsor.kelurahan;
            prefs.setString("sponsorkelurahan", responseJson.user.sponsor.kelurahan);

            sponsorsubdistrict = responseJson.user.sponsor.subdistrict;
            prefs.setString("sponsorsubdistrict", responseJson.user.sponsor.subdistrict);

            sponsorcity = responseJson.user.sponsor.city;
            prefs.setString("sponsorcity", responseJson.user.sponsor.city);

            sponsorprovince = responseJson.user.sponsor.province;
            prefs.setString("sponsorprovince", responseJson.user.sponsor.province);

            sponsorphone = responseJson.user.sponsor.phone;
            prefs.setString("sponsorphone", responseJson.user.sponsor.phone);

            ///WEBVIEWS
            dashboard = responseJson.user.webviews.dashboard;
            prefs.setString("dashboard", responseJson.user.webviews.dashboard);

            tree = responseJson.user.webviews.tree;
            prefs.setString("tree", responseJson.user.webviews.tree);

            referral = responseJson.user.webviews.referral;
            prefs.setString("referral", responseJson.user.webviews.referral);

            cv = responseJson.user.webviews.cv;
            prefs.setString("cv", responseJson.user.webviews.cv);

            pointreward = responseJson.user.webviews.pointreward;
            prefs.setString("pointreward", responseJson.user.webviews.pointreward);

            kebijakanPrivacy = responseJson.user.webviews.kebijakanPrivacy;
            prefs.setString("kebijakanPrivacy", responseJson.user.webviews.kebijakanPrivacy);

            ketentuanPengguna = responseJson.user.webviews.ketentuanPengguna;
            prefs.setString("ketentuanPengguna", responseJson.user.webviews.ketentuanPengguna);

            ///WALLETS
            method = responseJson.user.jsondata.wallets.method;
            prefs.setString("method", responseJson.user.jsondata.wallets.method);

            walleturl = responseJson.user.jsondata.wallets.url;
            prefs.setString("walleturl", responseJson.user.jsondata.wallets.url);

            ///PARAMS OPTIONAL
            accesskey = responseJson.user.jsondata.referrals.params.accesskey;
            prefs.setString("accesskey", responseJson.user.jsondata.referrals.params.accesskey);

            typeId = responseJson.user.jsondata.referrals.params.typeId;
            prefs.setString("typeId", responseJson.user.jsondata.referrals.params.typeId);

            datefrom = responseJson.user.jsondata.referrals.params.datefrom;
            prefs.setString("datefrom", responseJson.user.jsondata.referrals.params.datefrom);

            dateto = responseJson.user.jsondata.referrals.params.dateto;
            prefs.setString("dateto", responseJson.user.jsondata.referrals.params.dateto);

            notifyListeners();

            print("RESPONSE STATUS = ${responseJson.user.message}");

            getMitraData();

            Navigator.of(context).pushReplacementNamed("main_page");




        } else if(responseJson.user.code == 400) {

            print("ERRORRRRRR");

            isLoading = false;
            notifyListeners();
            showErrorDialogOTP(context);

        }
        return responseJson;
    }

    Future<void> showErrorDialogOTP(BuildContext context) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) => LoginErrorWidget(
                title: "Kesalahan Autentikasi",
                description: "Terjadi kesalahan Autentikasi, Cek email atau password Anda",
                filledButtonText: "Oke",
                filledButtonaction: (){
                    Navigator.of(context).pushReplacementNamed("login_page");
                },
            ));
    }


    /// USER ID
    int vuserid;
    String vprofilEmail;
    String vreferralUrl;

    ///MEMBER
    String vnumber;
    String vfirstname;
    String vlastname;
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
    int vtimone;
    int vtimtwo;
    int vtotalcommission;
    String vtype;

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

    getMitraData() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        vnumber = prefs.getString("number");

        vuserid = prefs.getInt("userid");

        ///MEMBER

        vfirstname = prefs.getString("firstname");
        vlastname = prefs.getString("lastname");
        vbirthdate = prefs.getString("birthdate");
        vgender = prefs.getString("gender");
        vaddress = prefs.getString("address");
        vkelurahan = prefs.getString("kelurahan");
        vsubdistrict = prefs.getString("subdistrict");
        vcity = prefs.get("city");
        vprovince = prefs.getString("province");
        vzipcode = prefs.getString("zipcode");
        vphone = prefs.getString("vphone");
        vleftcv = prefs.getInt("leftcv");
        vrightcv = prefs.getInt("rightcv");
        vleftpointreward = prefs.getInt("leftpointreward");
        vrightpointreward = prefs.getInt("rightpointreward");
        vcommission = prefs.getString("commission");
        vrank = prefs.getString("rank");
        vpar = prefs.getString("par");
        vexpired = prefs.getString("expired");
        vhighestrank = prefs.getString("highestrank");
        vtimone = prefs.getInt("timone");
        vtimtwo = prefs.getInt("timtwo");
        vtotalcommission = prefs.getInt("totalcommission");
        vtype = prefs.getString("type");
        vprofilEmail = prefs.getString("profilemail");
        vreferralUrl = prefs.getString("referralurl");

        ///SPONSOR
        vsponsorfirstname = prefs.getString("sponsorfirstname");
        vsponsorlastname = prefs.getString("sponsorlastname");
        vsponsorgender = prefs.getString("sponsorgender");
        vsponsoraddress = prefs.getString("sponsoraddress");
        vsponsorkelurahan = prefs.getString("sponsorkelurahan");
        vsponsorsubdistrict = prefs.getString("sponsorsubdistrict");
        vsponsorcity = prefs.getString("sponsorcity");
        vsponsorprovince = prefs.getString("sponsorprovince");
        vsponsorphone = prefs.getString("sponsorphone");

        ///WEBVIEWS
        vdashboard = prefs.getString("dashboard");
        vtree = prefs.getString("tree");
        vreferral = prefs.getString("referral");
        vcv = prefs.getString("cv");
        vpointreward = prefs.getString("pointreward");
        vkebijakanPrivacy = prefs.getString("kebijakanPrivacy");
        vketentuanPengguna = prefs.getString("ketentuanPengguna");

        ///WALLETS
        vmethod = prefs.getString("method");
        vwalleturl = prefs.getString("walleturl");

        ///PARAMS OPTIONAL
        vaccesskey = prefs.getString("accesskey");
        vtypeId = prefs.getString("typeId");
        vdatefrom = prefs.getString("datefrom");
        vdateto = prefs.getString("dateto");

        notifyListeners();


    }




}