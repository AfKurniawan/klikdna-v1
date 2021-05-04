import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/custom_shadow_card_widget.dart';

class FavouriteItems extends StatelessWidget {
  String food ;
  String kal ;
  String kalSize ;
  String prot ;
  String protSize;
  String lemak ;
  String lemakSize;
  String karbo ;
  String karboSize;
  String kategori;

  FavouriteItems({Key key, this.food, this.kal, this.kalSize, this.prot, this.protSize, this.lemak, this.lemakSize, this.karbo, this.karboSize, this.kategori}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CustomShadowCardWidget(
      margin: EdgeInsets.only(right: 16, bottom: 16),
      width: 280,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: kategori == "1" ? MyColors.burgerIconColor : MyColors.drinkIconColor,
                      borderRadius:
                      BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.all(6.0),
                      child: Center(
                          child: Image.asset(kategori == "1" ?
                              "assets/icons/food_apple_icon.png" : "assets/icons/drinks_icon.png",
                              height: 16)),
                    )),
                SizedBox(width: 13),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$food",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Roboto",
                          fontWeight:
                          FontWeight.w400),
                    ),
                    Text("1 Serving $kalSize Kalori",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w300)),
                    SizedBox(height: 5)
                  ],
                )
              ],
            ),
          ),
          Divider(),
          //////////////////////////
          Padding(
            padding: const EdgeInsets.only(
                left: 17.0, top: 8, right: 19),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 19.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: MyColors
                                    .kkalColor,
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    10)),
                          ),
                          SizedBox(width: 6),
                          Text("Kalori",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily:
                                  "Roboto",
                                  fontWeight:
                                  FontWeight
                                      .w300)),
                        ],
                      ),
                      Text("$kalSize kkal",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Roboto",
                              fontWeight:
                              FontWeight.w400))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: MyColors
                                    .proteinColor,
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    10)),
                          ),
                          SizedBox(width: 6),
                          Text("Protein",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily:
                                  "Roboto",
                                  fontWeight:
                                  FontWeight
                                      .w300)),
                        ],
                      ),
                      Text("$protSize g",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Roboto",
                              fontWeight:
                              FontWeight.w400))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color:
                                MyColors.fatColor,
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    10)),
                          ),
                          SizedBox(width: 6),
                          Text("Lemak",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily:
                                  "Roboto",
                                  fontWeight:
                                  FontWeight
                                      .w300)),
                        ],
                      ),
                      Text("$lemakSize g",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Roboto",
                              fontWeight:
                              FontWeight.w400))
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color:
                              MyColors.carboColor,
                              borderRadius:
                              BorderRadius
                                  .circular(10)),
                        ),
                        SizedBox(width: 6),
                        Text("Karbo",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Roboto",
                                fontWeight:
                                FontWeight.w300)),
                      ],
                    ),
                    Text("$karboSize g",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Roboto",
                            fontWeight:
                            FontWeight.w400))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}