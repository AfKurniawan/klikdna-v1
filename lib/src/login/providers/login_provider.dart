import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/login/models/login_model.dart';
import 'package:new_klikdna/src/login/models/new_api_login_model.dart';
import 'package:new_klikdna/src/login/models/new_dashboard_user_model.dart';
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
    int userId;

    var formattedCommission = new NumberFormat.currency(name: "", locale: "en_US".toString());

    var totalFormattedCommision = new NumberFormat.currency(name: "", locale: "en_US");


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

    Future<NewApiLoginModel> loginAction(BuildContext context) async {
        prefs = await SharedPreferences.getInstance();
        isLoading = true;
        notifyListeners();

        String email = emailController.text;
        String password = passwordController.text;

        var url = AppConstants.NEW_API_LOGIN_URL;
        var body = json.encode({
            "email" : email,
            "password": password
        });

        Map<String, String> headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
        };

        final response = await http.post(url, body: body, headers: headers);
        final responseJson = NewApiLoginModel.fromJson(json.decode(response.body));

        print("[LOGIN ACTION NEW API TOKEN] ==> ${response.body}");

        if(response.statusCode == 200) {
            print(
                "[LOGIN ACTION NEW API TOKEN] ==> ${responseJson.accessToken}");
            prefs.setString("newApiToken", responseJson.accessToken);
            prefs.setString("newTokenType", responseJson.tokenType);

            notifyListeners();

            //Navigator.of(context).pushReplacementNamed("main_page");

            getUserDataDashboard(context);

        } else if(response.statusCode == 500){
            isLoading = false ;
            _showToast(context);

        } else {

            isLoading = false;
            notifyListeners();
            showErrorDialogOTP(context);

        }
        return responseJson;
    }


    void _showToast(BuildContext context) {
        Navigator.of(context).pushReplacementNamed("/");
        Fluttertoast.showToast(
            msg: "Terjadi kesalahan, silahkan ulangi lagi",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
        );
    }


    Future<NewDashboardUserModel> getUserDataDashboard(BuildContext context) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("newApiToken");

        var url = AppConstants.NEW_API_DASHBOARD_URL;

        Map<String, String> headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization' : 'Bearer $token'
        };

        final response = await http.get(url, headers: headers);
        print('[LOGIN PROVIDER] getUserDataDashboard ==> ${response.statusCode}');
        final responseJson = NewDashboardUserModel.fromJson(json.decode(response.body));

        if(response.statusCode == 200) {

            // print("[LOGIN PROVIDER] GET USER DASHBOARD Response body ==> ${response.body}");
            
            /// Account Response
            prefs.setInt('accountId', responseJson.message.account.id);
            prefs.setString('accountEmail', responseJson.message.account.email);
            prefs.setString('accountRole', responseJson.message.account.role);
            prefs.setString('accountReferalUrl', responseJson.message.account.referralUrl);
            
            /// Agent
            prefs.setString('agentNik', responseJson.message.account.agent.nik);
            prefs.setString('agentNpwp', responseJson.message.account.agent.npwp);
            prefs.setString('agentReligion', responseJson.message.account.agent.religion);
            prefs.setString('agentJob', responseJson.message.account.agent.job);
            prefs.setString('agentStatus', responseJson.message.account.agent.status);
            prefs.setBool('agentVerified', responseJson.message.account.agent.verified);
            prefs.setBool('agentMaster', responseJson.message.account.agent.master);
            prefs.setBool('agentOutlet', responseJson.message.account.agent.outlet);
            
            /// Member Response 
            prefs.setString('memberNumber', responseJson.message.account.member.number);
            prefs.setString('memberFirstName', responseJson.message.account.member.firstname);
            prefs.setString('memberLastName', responseJson.message.account.member.lastname);
            prefs.setString('memberBirthDate', responseJson.message.account.member.birthdate);
            prefs.setString('memberGender', responseJson.message.account.member.gender);
            prefs.setString('memberAddress', responseJson.message.account.member.address);
            prefs.setString('memberKelurahan', responseJson.message.account.member.kelurahan);
            prefs.setString('memberSubdistrict', responseJson.message.account.member.subdistrict);
            prefs.setString('memberCity', responseJson.message.account.member.city);
            prefs.setString('memberProvince', responseJson.message.account.member.province);
            prefs.setString('memberZipCode', responseJson.message.account.member.zipcode);
            prefs.setString('memberPhone', responseJson.message.account.member.phone);
            prefs.setInt('memberLeftCv', responseJson.message.account.member.leftcv);
            prefs.setInt('memberRightCv', responseJson.message.account.member.rightcv);
            prefs.setInt('memberLeftPointReward', responseJson.message.account.member.leftpointreward);
            prefs.setInt('memberRightPointReward', responseJson.message.account.member.rightpointreward);
            prefs.setInt('memberComission', responseJson.message.account.member.commission);
            prefs.setString('memberRank', responseJson.message.account.member.rank);
            prefs.setString('memberPar', responseJson.message.account.member.par);
            prefs.setString('memberExpired', responseJson.message.account.member.expired);
            prefs.setString('memberHighestRank', responseJson.message.account.member.highestrank);
            prefs.setString('memberTimeOnePosition', responseJson.message.account.member.timoneposition);
            prefs.setString("memberTimeTwoPosition", responseJson.message.account.member.timtwoposition);
            prefs.setInt('memberTimLeft', responseJson.message.account.member.timleft);
            prefs.setInt('memberTimRight', responseJson.message.account.member.timright);
            prefs.setInt('memberTimone', responseJson.message.account.member.timone);
            prefs.setInt('memberTimTwo', responseJson.message.account.member.timtwo);
            prefs.setInt('memberMonthlycycle', responseJson.message.account.member.monthlycycle);
            prefs.setInt('memberDailyCycle', responseJson.message.account.member.dailycycle);
            prefs.setString('memberType', responseJson.message.account.member.type);

            /// Sponsor
            prefs.setString('sponsorFirstName', responseJson.message.account.sponsor.firstname);
            prefs.setString('sponsorLastName', responseJson.message.account.sponsor.lastname);
            prefs.setString('sponsorGender', responseJson.message.account.sponsor.gender);
            prefs.setString('sponsorAddress', responseJson.message.account.sponsor.address);
            prefs.setString('sponsorAddress', responseJson.message.account.sponsor.kelurahan);
            prefs.setString('sponsorSubdistrict', responseJson.message.account.sponsor.subdistrict);
            prefs.setString('sponsorCity', responseJson.message.account.sponsor.city);
            prefs.setString('sponsorProvince', responseJson.message.account.sponsor.province);
            prefs.setString('sponsorPhone', responseJson.message.account.sponsor.phone);


            Navigator.of(context).pushReplacementNamed("main_page");

        } else {


        }

        return responseJson ;

    }




}