import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/models/account_model.dart';
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

  List<PatientCard> listPatentCard = [];

  TextEditingController nameController = new TextEditingController();
  TextEditingController rhesusController = new TextEditingController();



  Future<AccountModel> getUserAccount(BuildContext context) async {
    print("START GET ACCOUNT");
    final prov = Provider.of<TokenProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    notifyListeners();

    int userid = prefs.getInt("userid");


    String token = prov.accessToken;
    var url = AppConstants.GET_ACCOUNT_URL + userid.toString();

    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final request = await http.get(url, headers: ndas);
    final accountResponse = AccountModel.fromJson(json.decode(request.body));
   // print("ACCOUNT RESPONSE: ${request.body}");

    if(accountResponse.success == true){
      isLoading = false ;
      isError = false ;
      var data = json.decode(request.body);
      var detailArray = data['data']['patient_card'] as List;
       listPatentCard = detailArray.map<PatientCard>((j) => PatientCard.fromJson(j)).toList();

      for(int i = 0 ; i < listPatentCard.length ; i++) {
        lastID = listPatentCard[i].id.toString();
        print("ID_______ $lastID");
        notifyListeners();
      }

      print("PANJANG LIST PATIENT CARD: ${listPatentCard.length}");


      name = accountResponse.data.name;
      phone = accountResponse.data.phone;
      accountdob = accountResponse.data.dob;
      accountgender = accountResponse.data.gender;
      kdmAccountId = accountResponse.data.kdmAccountId;
      userId = accountResponse.data.userId;
      prefs.setString("personId", accountResponse.data.userId);
      print("PERSON ACOUNT___: ${accountResponse.data.userId}");
      nameController.text = accountResponse.data.name;
      Provider.of<ReportProvider>(context, listen: false).getSample(context, accountResponse.data.userId);
//      notifyListeners();

    } else {

      print("ERROR GET ACCCOUNT");
      isLoading = false ;
      isError = true ;
      notifyListeners();
    }
     return null;

  }
}