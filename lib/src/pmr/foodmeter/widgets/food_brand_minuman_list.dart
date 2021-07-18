import 'package:flutter/material.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_brands_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class FoodBrandMinumanList extends StatefulWidget {

  int id;
  FoodBrandMinumanList({Key key, this.id}) : super(key: key);

  @override
  _FoodBrandMinumanListState createState() => _FoodBrandMinumanListState();
}

class _FoodBrandMinumanListState extends State<FoodBrandMinumanList> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FoodBrandsProvider>(context, listen: false);
    return ListView.builder(
      itemCount: prov.minumanList.length,
      itemBuilder: (context, i){
        List splittedSize = prov.minumanList[i].productSize.toString().split(".");
        return Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 10, top: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  color: Colors.grey[500].withOpacity(0.2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: MyColors.drinkIconColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Center(
                                child: Image.asset(
                                    "assets/icons/drinks_icon.png",
                                    height: 32)),
                          )),
                      SizedBox(width: 20),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              child: Text("${prov.minumanList[i].productName}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  )),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 110,
                              child: Text("1 Porsi ${splittedSize[0]} ${prov.minumanList[i].productUom}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12
                                  )),
                            ),
                          ]),

                      SizedBox(width: 20),
                      InkWell(
                        onTap: (){
                          print("xxx");
                          //Navigator.of(context).pushNamed("new_detail_food_meter_page", arguments: item);
                          // Provider.of<FoodMeterProvider>(context, listen: false).getSpecificFoodMeter(context, item.id);
                          Navigator.of(context).pushNamed("new_detail_food_meter_page", arguments: prov.minumanList[i].id);
                        },
                        splashColor: Colors.white,
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: MyColors.dnaGreen
                          ),
                          child: Center(
                            child: Text(
                              "Details",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
