import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/login/models/login_model.dart';
import 'package:new_klikdna/src/login/models/new_api_login_model.dart';
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

        prefs.setString("email", emailController.text);
        prefs.setString('passing', passwordController.text);

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

        if(response.statusCode == 200){


            prefs.setString("newApiToken", responseJson.accessToken);
            prefs.setString("neTokenType", responseJson.tokenType);

            notifyListeners();

            Navigator.of(context).pushReplacementNamed("main_page");


        } else {

            isLoading = false;
            notifyListeners();
            showErrorDialogOTP(context);

        }
        return responseJson;
    }




}