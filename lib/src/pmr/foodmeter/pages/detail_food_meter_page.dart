import 'package:flutter/material.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/detail_food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/food_meter_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/pagination_model_data.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class DetailFoodMeterPage extends StatefulWidget {

  final Datum food;

  DetailFoodMeterPage({Key key, this.food}) : super(key: key);

  @override
  _DetailFoodMeterPageState createState() => _DetailFoodMeterPageState();
}

class _DetailFoodMeterPageState extends State<DetailFoodMeterPage> {

  TextEditingController newSearchController = new TextEditingController();

  @override
  void initState() {
//    Provider.of<FoodMeterProvider>(context, listen: false).getDetailFoodMeter(context, widget.food.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FoodMeterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.food.productName,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: TextFormField(
            //     controller: newSearchController,
            //     style: TextStyle(fontSize: 18),
            //     decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.search),
            //       contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            //       //hintText: "Cari",
            //       filled: true,
            //       fillColor: Colors.white,
            //       hintStyle: TextStyle(color: MyColors.grey),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(color: MyColors.dnaGreen, width: 0.0),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(color: MyColors.dnaGreen, width: 1.0),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 30, top: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.food.productName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Text("1 Serving ${widget.food.productSize} ${widget.food.productUom}")
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 15, bottom: 15),
                          child: Text("Nutrition Fact", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        Container(height: 1, color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: prov.newMobilenutritionList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              return NutritionItemWidget(nutritions: prov.newMobilenutritionList[index],
                              );
                            },
                            separatorBuilder: (context, index){
                              return Container(
                                height: 1,
                                color: Colors.grey,
                              );
                            },
                          ),
                        )
                      ],
                    ),

                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class NutritionItemWidget extends StatefulWidget {

  final MobileNutritions nutritions;

  NutritionItemWidget({
    Key key, this.nutritions
  }) : super(key: key);

  @override
  _NutritionItemWidgetState createState() => _NutritionItemWidgetState();
}

class _NutritionItemWidgetState extends State<NutritionItemWidget> {

  String sat;


  @override
  void initState() {
    sat = widget.nutritions.nutritionSize.substring(0, widget.nutritions.nutritionSize.indexOf('.'));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.nutritions.nutritionName, style: TextStyle(fontSize: 14)),
              Row(
                children: [
                  Text(sat, style: TextStyle(fontSize: 14)),
                  SizedBox(width: 5),
                  Text(widget.nutritions.nutritionUom, style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}