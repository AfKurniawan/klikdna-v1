import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/member/models/member_model.dart';
import 'package:new_klikdna/token/providers/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class MemberProvider with ChangeNotifier {

  bool isLoading;
  String name ;
  List<Member> listMember = [];

  Future<List<MemberResponseModel>> getMember(BuildContext context, String person) async {
    isLoading = true;
    final prov = Provider.of<TokenProvider>(context, listen: false);
    String accessToken = prov.accessToken;

    var url = AppConstants.GET_MEMBER_URL + "$person";

    Map<String, String> ndas = {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final request = await http.get(url, headers: ndas);

    print("MEMBER RESPONSE: ${request.statusCode}");


    if(request.statusCode == 200) {
      isLoading = false;
      var data = json.decode(request.body);
      var personArray = data['data'] as List;
      listMember = personArray.map<Member>((j) => Member.fromJson(j)).toList();
      notifyListeners();
      print("NAMA MEMBER: $listMember");
    }

    return null;

  }

  String newMemberName = "";
  getName(BuildContext context, String memberName){
    newMemberName = memberName;
    print("NAMA MEMBER: $newMemberName");
    notifyListeners();
  }
}