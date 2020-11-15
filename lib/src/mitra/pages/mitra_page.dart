import 'package:flutter/material.dart';

class MitraPage extends StatefulWidget {
  @override
  _MitraPageState createState() => _MitraPageState();
}

class _MitraPageState extends State<MitraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Text("MITRA"),
            ),
          )
        ],
      ),
    );
  }
}
