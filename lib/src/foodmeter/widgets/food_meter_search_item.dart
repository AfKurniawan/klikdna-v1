import 'package:flutter/material.dart';
import 'package:new_klikdna/src/foodmeter/models/food_meter_model.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class FoodItemSearchWidget extends StatefulWidget {
  final Food model;
  FoodItemSearchWidget({Key key, this.model,}) : super(key: key);


  @override
  _FoodItemSearchWidgetState createState() => _FoodItemSearchWidgetState();
}

class _FoodItemSearchWidgetState extends State<FoodItemSearchWidget> {

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            Icon(Icons.search, color: MyColors.iconArrowColor, size: 20),
            SizedBox(width: 20),
            Text("${widget.model.productName}",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  fontFamily: "Roboto"
                )),
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed("detail_food_meter_page", arguments: widget.model);
      },
    );
  }
}