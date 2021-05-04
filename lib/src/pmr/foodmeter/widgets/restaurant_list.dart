import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: ListView.builder(
        itemCount: 10,
          itemBuilder:(context, index){
            return Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 20),
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
                        children: [
                          Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: MyColors.restoranIconColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Center(
                                    child: Image.asset(
                                        "assets/icons/resto_icon.png",
                                        height: 32)),
                              )),
                          SizedBox(width: 20),
                          Column(children: [
                            Container(
                              width: 130,
                              child: Text("Yuppi - Strawberry Kiss",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                fontWeight: FontWeight.w500,
                                  fontSize: 14
                              )),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 130,
                              child: Text("45 g 1 serving",
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
                            onTap: (){},
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
          }
      ),
    );
  }
}
