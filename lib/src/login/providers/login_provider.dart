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


    var formattedCommission = new NumberFormat.currency(name: "", locale: "en_US".toString());

    var totalFormattedCommision = new NumberFormat.currency(name: "", locale: "en_US");

    Future<LoginModel> loginAction(BuildContext context) async {
        prefs = await SharedPreferences.getInstance();
        isLoading = true;
        notifyListeners();

        String email = emailController.text;
        String password = passwordController.text;

        prefs.setString("email", emailController.text);
        prefs.setString('passing', passwordController.text);

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

            isLoading = false ;

            prefs.setBool('isLogin', true);

            /// USER
            prefs.setInt("userid", responseJson.user.id);

            ///AGENT
            prefs.setString("nik", responseJson.user.agent.nik);


            ///MEMBER

            prefs.setString("number", responseJson.user.member.number);

            prefs.setString("firstname", responseJson.user.member.firstname);

            prefs.setString("lastname", responseJson.user.member.lastname);

            prefs.setString("birthdate", responseJson.user.member.birthdate.substring(0, 10));

            prefs.setString("gender", responseJson.user.member.gender);

            prefs.setString("address", responseJson.user.member.address);

            prefs.setString("kelurahan", responseJson.user.member.kelurahan);

            prefs.setString("subdistrict", responseJson.user.member.subdistrict);

            prefs.setString("city", responseJson.user.member.city);

            prefs.setString("province", responseJson.user.member.province);

            prefs.setString("zipcode", responseJson.user.member.zipcode);

            prefs.setString("phone", responseJson.user.member.phone);

            prefs.setInt("leftcv", responseJson.user.member.leftcv);

            prefs.setInt("rightcv", responseJson.user.member.rightcv);

            prefs.setInt("leftpointreward", responseJson.user.member.leftpointreward);

            prefs.setInt("rightpointreward", responseJson.user.member.rightpointreward);


            if(responseJson.user.member.commission == null) {
                prefs.setInt("commission", responseJson.user.member.commission);
            } else {
                prefs.setString("commission", formattedCommission.format(responseJson.user.member.commission));
            }


            prefs.setString("rank", responseJson.user.member.rank);

            prefs.setString("par", responseJson.user.member.par);

            if(responseJson.user.member.expired == null) {
                prefs.setString("expired", "-");
            } else {
                prefs.setString("expired", responseJson.user.member.expired);
            }


            prefs.setString("highestrank", responseJson.user.member.highestrank.toString());

            prefs.setString("timoneposition", responseJson.user.member.timoneposition);

            prefs.setString("timtwoposition", responseJson.user.member.timtwoposition);

            prefs.setInt("timone", responseJson.user.member.timone);

            prefs.setInt("timtwo", responseJson.user.member.timtwo);

            prefs.setString("totalcommission", totalFormattedCommision.format(responseJson.user.member.totalcommission));

            prefs.setString("type", responseJson.user.member.type);

            prefs.setString("profilemail", responseJson.user.email);

            prefs.setString("referralurl", responseJson.user.referralUrl);

            prefs.setString("monthlycycle", responseJson.user.member.monthlycycle.toString());

            prefs.setString("dailycycle", responseJson.user.member.dailycycle.toString());

            ///SPONSOR
            prefs.setString("sponsorfirstname", responseJson.user.sponsor.firstname);

            prefs.setString("sponsorlastname", responseJson.user.sponsor.lastname);

            prefs.setString("sponsorgender", responseJson.user.sponsor.gender);

            prefs.setString("sponsoraddress", responseJson.user.sponsor.address);

            prefs.setString("sponsorkelurahan", responseJson.user.sponsor.kelurahan);

            prefs.setString("sponsorsubdistrict", responseJson.user.sponsor.subdistrict);

            prefs.setString("sponsorcity", responseJson.user.sponsor.city);

            prefs.setString("sponsorprovince", responseJson.user.sponsor.province);

            prefs.setString("sponsorphone", responseJson.user.sponsor.phone);

            ///WEBVIEWS
            prefs.setString("dashboard", responseJson.user.webviews.dashboard);

            prefs.setString("tree", responseJson.user.webviews.tree);

            prefs.setString("referral", responseJson.user.webviews.referral);

            prefs.setString("cv", responseJson.user.webviews.cv);

            prefs.setString("pointreward", responseJson.user.webviews.pointreward);

            prefs.setString("kebijakanPrivacy", responseJson.user.webviews.kebijakanPrivacy);

            prefs.setString("ketentuanPengguna", responseJson.user.webviews.ketentuanPengguna);

            ///WALLETS
            prefs.setString("method", responseJson.user.jsonData.wallets.method);
            
            prefs.setString("accesskey", responseJson.user.jsonData.wallets.params.accesskey);

            prefs.setString("walleturl", responseJson.user.jsonData.wallets.url);

            ///PARAMS OPTIONAL
            prefs.setString("accesskey", responseJson.user.jsonData.referrals.params.accesskey);

            prefs.setString("typeId", responseJson.user.jsonData.referrals.params.typeId);

            prefs.setString("datefrom", responseJson.user.jsonData.referrals.params.datefrom);

            prefs.setString("dateto", responseJson.user.jsonData.referrals.params.dateto);

            notifyListeners();



            Navigator.of(context).pushReplacementNamed("main_page");




        } else if(responseJson.user.code == 400) {

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