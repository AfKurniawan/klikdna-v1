import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/models/account_model.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountProvider with ChangeNotifier {

  bool isLoading ;
  bool isError ;


  String lastID ;

  int kdmAccountId;
  String userId;
  String name;
  String username;
  String phone;
  String accountgender;
  String accountdob;
  String noKtp;
  int verifyAccessReport = 0 ;

  List<PatientCard> listPatentCard = [];

  TextEditingController nameController = new TextEditingController();
  TextEditingController rhesusController = new TextEditingController();



  Future<AccountModel> getUserAccount(BuildContext context) async {
    print("USER ACCONT CALL");
    final prov = Provider.of<TokenProvider>(context, listen: false);
    var getSample = Provider.of<ReportProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    notifyListeners();
    int id = Provider.of<MitraProvider>(context, listen: false).vuserid;

    print("GET USER ID USING LOGIN ID --> $id");
    String token = prov.accessToken;
    var url = AppConstants.GET_ACCOUNT_URL + id.toString();

    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final request = await http.get(url, headers: ndas);
    final accountResponse = AccountModel.fromJson(json.decode(request.body));

   // print("AKUN RESPONSE BODY --> ${request.body}");

    if(accountResponse.success == true){

      isLoading = false ;
      isError = false ;
      var data = json.decode(request.body);
      var detailArray = data['data']['patient_card'] as List;
       listPatentCard = detailArray.map<PatientCard>((j) => PatientCard.fromJson(j)).toList();


      for(int i = 0 ; i < listPatentCard.length ; i++) {
        lastID = listPatentCard.last.id.toString();
       // print("LAST ID ==> $lastID");
        noKtp = prefs.getString("nik");
        notifyListeners();
      }

      name = accountResponse.data.name;
      phone = accountResponse.data.phone;

      accountdob = accountResponse.data.dob;
      accountgender = accountResponse.data.gender;
      kdmAccountId = accountResponse.data.kdmAccountId;
      userId = accountResponse.data.userId;
      nameController.text = accountResponse.data.name;
      verifyAccessReport = accountResponse.data.verifykdmAccessReport;
      notifyListeners();
      getSample.getFirstSample(context);

    } else {

      isLoading = false ;
      isError = true ;
      notifyListeners();
    }
     return null;

  }
}