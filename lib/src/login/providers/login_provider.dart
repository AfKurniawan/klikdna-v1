import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    int commission;
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
            userid = responseJson.user.id;
            prefs.setInt("userid", responseJson.user.id);
            ///MEMBER
            number = responseJson.user.member.number;
            firstname = responseJson.user.member.firstname;
            prefs.setString("firstname", responseJson.user.member.firstname);
            lastname = responseJson.user.member.lastname;
            prefs.setString("lastname", responseJson.user.member.lastname);
            birthdate = responseJson.user.member.birthdate;
            gender = responseJson.user.member.gender;
            address = responseJson.user.member.address;
            kelurahan = responseJson.user.member.kelurahan;
            subdistrict = responseJson.user.member.subdistrict;
            city = responseJson.user.member.city;
            province = responseJson.user.member.province;
            zipcode = responseJson.user.member.zipcode;
            phone = responseJson.user.member.phone;
            leftcv = responseJson.user.member.leftcv;
            rightcv = responseJson.user.member.rightcv;
            leftpointreward = responseJson.user.member.leftpointreward;
            rightpointreward = responseJson.user.member.rightpointreward;
            commission = responseJson.user.member.commission;
            rank = responseJson.user.member.rank;
            par = responseJson.user.member.par;
            expired = responseJson.user.member.expired;
            highestrank = responseJson.user.member.highestrank;
            timone = responseJson.user.member.timone;
            timtwo = responseJson.user.member.timtwo;
            totalcommission = responseJson.user.member.totalcommission;
            type = responseJson.user.member.type;



            ///SPONSOR
            sponsorfirstname = responseJson.user.sponsor.firstname;
            sponsorlastname = responseJson.user.sponsor.lastname;
            sponsorgender = responseJson.user.sponsor.gender;
            sponsoraddress = responseJson.user.sponsor.address;
            sponsorkelurahan = responseJson.user.sponsor.kelurahan;
            sponsorsubdistrict = responseJson.user.sponsor.subdistrict;
            sponsorcity = responseJson.user.sponsor.city;
            sponsorprovince = responseJson.user.sponsor.province;
            sponsorphone = responseJson.user.sponsor.phone;

            ///WEBVIEWS
            dashboard = responseJson.user.webviews.dashboard;
            tree = responseJson.user.webviews.tree;
            referral = responseJson.user.webviews.referral;
            cv = responseJson.user.webviews.cv;
            pointreward = responseJson.user.webviews.pointreward;
            kebijakanPrivacy = responseJson.user.webviews.kebijakanPrivacy;
            ketentuanPengguna = responseJson.user.webviews.ketentuanPengguna;

            ///WALLETS
            method = responseJson.user.jsondata.wallets.method;
            walleturl = responseJson.user.jsondata.wallets.url;

            ///PARAMS OPTIONAL
            accesskey = responseJson.user.jsondata.referrals.params.accesskey;
            typeId = responseJson.user.jsondata.referrals.params.typeId;
            datefrom = responseJson.user.jsondata.referrals.params.datefrom;
            dateto = responseJson.user.jsondata.referrals.params.dateto;

            print("RESPONSE STATUS = ${responseJson.user.message}");

            Navigator.of(context).pushReplacementNamed("main_page");

            notifyListeners();


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




}