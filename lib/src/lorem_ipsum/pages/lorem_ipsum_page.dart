import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class LoremIpsumPage extends StatefulWidget {
  @override
  _LoremIpsumPageState createState() => _LoremIpsumPageState();
}

class _LoremIpsumPageState extends State<LoremIpsumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Kembali",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.dnaGrey,
              size: 20,
            ),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, "detail_report_page");
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6,
              decoration: BoxDecoration(
                color: MyColors.dnaGreen,
                borderRadius: BorderRadius.circular(0),
                // boxShadow: [
                //   BoxShadow(
                //     offset: Offset(0, 4),
                //     blurRadius: 20,
                //     color: Color(0xFFB0CCE1).withOpacity(0.32),
                //   ),
                // ],
              ),
              child: Center(child: Text("Lorem Ipsum", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34, color: Colors.white))),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
