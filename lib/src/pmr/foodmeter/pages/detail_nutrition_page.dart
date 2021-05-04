import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/dummy_nutrisi_desc.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class DetailNutritionPage extends StatefulWidget {

  DummyNutrisiDesc model;

  DetailNutritionPage({Key key, this.model}) : super(key: key);

  @override
  _DetailNutritionPageState createState() => _DetailNutritionPageState();
}

class _DetailNutritionPageState extends State<DetailNutritionPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.model.title}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18, bottom: 12, top: 12),
            child: Image.asset("assets/images/logo.png",
            height: 20,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){

                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset('${widget.model.picture}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text("${widget.model.desc}",
                      style: TextStyle(fontSize: 14),
                    )),



                SizedBox(height: 24),

              ],
            ),
          ),
        ),
      )
    );
  }
}
