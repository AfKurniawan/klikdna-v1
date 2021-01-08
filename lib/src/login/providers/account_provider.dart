import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/models/account_model.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountProvider with ChangeNotifier {
  int kdmAccountId;
  String userId;
  String name;
  String username;
  String phone;
  String gender;
  String dob;
  bool isLoading ;


  AccountProvider(BuildContext context){
    getAccount(context);
  }


  String personId = "";
  String accessToken = "" ;
  String lastID ;

  TextEditingController nameController = new TextEditingController();
  TextEditingController rhesusController = new TextEditingController();


  List<PatientCard> listPatentCard = [];
  Future<AccountModel> getAccount(BuildContext context) async {
    isLoading = true ;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final prov = Provider.of<TokenProvider>(context, listen: false);
    prov.getApiToken();
    String accessToken = prov.accessToken;

    int kdmId = prefs.getInt("userid");

    print("KDM ID: $kdmId");

    var url = AppConstants.NEW_GET_ACCOUNT_URL + kdmId.toString();

    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.get(url, headers: ndas);
    final accountResponse = AccountModel.fromJson(json.decode(request.body));
    print("ACCOUNT RESPONSE: ${request.statusCode}");

    if(request.statusCode == 200){
      // var data = json.decode(request.body);
      // var detailArray = data['data']['patient_card'] as List;
      // listPatentCard = detailArray.map<PatientCard>((j) => PatientCard.fromJson(j)).toList();

      print("PATIEN CARD: ${listPatentCard[0].id}");

      for(int i = 0 ; i < listPatentCard.length ; i++) {
        lastID = listPatentCard.last.id.toString();
        notifyListeners();
      }




      isLoading = false ;
      name = accountResponse.data.name;
      phone = accountResponse.data.phone;
      dob = accountResponse.data.dob;
      gender = accountResponse.data.gender;
      kdmAccountId = accountResponse.data.kdmAccountId;
      userId = accountResponse.data.userId;
      prefs.setString("personId", accountResponse.data.userId);
      print("PERSON: ${accountResponse.data.userId}");
      nameController.text = accountResponse.data.name;
      notifyListeners();

      //Provider.of<NewMemberProvider>(context, listen: false).getMember(context, accountResponse.data.userId);


    } else {
      print("ERROR GET ACCCOUNT");
      isLoading = false ;
    }

    return null ;


  }


  void setRhesus(BuildContext context, String rhesus){
    print("RHESUS : $rhesus");
    rhesusController.text = rhesus;
    notifyListeners();
  }
}