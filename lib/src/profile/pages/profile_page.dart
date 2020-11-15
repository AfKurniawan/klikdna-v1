import 'package:flutter/material.dart';
import 'package:new_klikdna/src/profile/providers/profile_provider.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: GestureDetector(
                onTap: (){
                  context.read<ProfileProvider>().logout(context);
                },
                  child: Text("LOGOUT")),
            ),
          )
        ],
      ),
    );
  }
}
