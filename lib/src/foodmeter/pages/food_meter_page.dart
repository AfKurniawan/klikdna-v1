import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/foodmeter/models/food_meter_model.dart';
import 'package:new_klikdna/src/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class FoodMeterPage extends StatefulWidget {
  @override
  _FoodMeterPageState createState() => _FoodMeterPageState();
}

class _FoodMeterPageState extends State<FoodMeterPage> {


  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FoodMeterProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Food Meter",
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
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                style: TextStyle(fontSize: 18),
                controller: searchController,
                onFieldSubmitted: (value){
                  prov.getFoodsData(context, searchController.text);
                },
                onChanged: (value){
                  prov.getFoodsData(context, searchController.text);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  hintText: "Cari",
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: MyColors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: MyColors.dnaGreen, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: MyColors.dnaGreen, width: 1.0),
                  ),
                ),
              ),
            ),
            prov.isLoading == true ? Expanded(
                child: Container(
                height: 50,
                child: Center(child: Platform.isIOS ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(strokeWidth: 2)))) :
            Expanded(
              child: searchController.text.isEmpty
                  ? Container(
                height: 50,
                child: Center(
                ),
              )
                  : new ListView.builder(
                shrinkWrap: true,
                itemCount: prov.listFood.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoodItemWidget(model: prov.listFood[index]);
                },
              ),
            )
          ],

        ),
      ),
    );
  }
}

class FoodItemWidget extends StatefulWidget {
  final Food model;
  FoodItemWidget({Key key, this.model,}) : super(key: key);


  @override
  _FoodItemWidgetState createState() => _FoodItemWidgetState();
}

class _FoodItemWidgetState extends State<FoodItemWidget> {

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(widget.model.productName),
      onTap: (){
        Navigator.of(context).pushNamed("detail_food_meter_page", arguments: widget.model);
      },
    );
  }
}
