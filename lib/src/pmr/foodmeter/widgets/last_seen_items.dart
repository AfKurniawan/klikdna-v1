import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/custom_shadow_card_widget.dart';

class LastSeenItem extends StatelessWidget {
  String food ;
  String kal ;
  String kalSize ;
  String prot ;
  String protSize;
  LastSeenItem({Key key, this.food, this.kal, this.kalSize, this.prot, this.protSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return CustomShadowCardWidget(
      width: MediaQuery.of(context).size.width / 2.5,
      margin: EdgeInsets.only(right: 16, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 0, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${food}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: MyColors.kkalColor,
                                borderRadius:
                                BorderRadius.circular(50),
                              ),
                            ),
                            SizedBox(width: 6),
                            Text("$kal",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Text("$kalSize kkal",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto")),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: Color(0xffFCFF9B),
                                borderRadius:
                                BorderRadius.circular(50),
                              ),
                            ),
                            SizedBox(width: 6),
                            Text("$prot",
                                style: TextStyle(
                                  fontSize: 10,
                                ))
                          ],
                        ),
                        Text("$protSize g",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto")),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
