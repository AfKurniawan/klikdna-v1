import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/account/providers/account_provider.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class MemberProvider with ChangeNotifier {

  bool isLoading;
  String name ;
  String personId ;
  List<Member> listMember = [];

  Future<List<MemberResponseModel>> getMember(BuildContext context, String person) async {
    Provider.of<AccountProvider>(context, listen: false).getUserAccount(context);
    isLoading = true;
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;
    name = Provider.of<AccountProvider>(context, listen: false).name;
    personId = Provider.of<AccountProvider>(context, listen: false).userId;

    var url = AppConstants.GET_MEMBER_URL + "$personId";
    print("PERSON PARAMS --> $person");

    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.get(url, headers: ndas);


    if(request.statusCode == 200) {
      isLoading = false;
      print("STATUS BODY MEMBER ==> ${request.body}");
      var data = json.decode(request.body);
      var personArray = data['data'] as List;
      listMember = personArray.map<Member>((j) => Member.fromJson(j)).toList();

      print("LIST MEMEBR LENGHT ==> ${listMember.length}");
      notifyListeners();
    } else {
      isLoading = false;
    }

    return null;

  }

  String newMemberName = "";
  getNamexx(BuildContext context, String memberName, String memberId){
    newMemberName = memberName;
    Provider.of<ReportProvider>(context, listen: false).getMemberSample(context, memberId);

  }

  resetMember(){
    print("Reset member executed");
    newMemberName = "" ;
    notifyListeners();
  }

  String member = "" ;
  getMemberId(BuildContext context, String memberId) {
    member = memberId;
    print("MEMBER ==> $member");
    Provider.of<ReportProvider>(context, listen: false).getMemberSample(context, memberId);
    notifyListeners();

  }
}