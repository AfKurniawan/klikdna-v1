import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/patient_card/models/patient_card_model.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class CardInssuranceItem extends StatelessWidget {
  final Asuransi model;
  const CardInssuranceItem({
    Key key, this.model
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String s = model.nomorKartu ;
    s = StringUtils.addCharAtPosition(s, " ", 4, repeat: true);
    return Column(
      children: [
        Container(
         // height: MediaQuery.of(context).size.width < 400 ? MediaQuery.of(context).size.height / 3.5 : MediaQuery.of(context).size.height / 4,
          width:  MediaQuery.of(context).size.width - 16,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: model.type.contains("Jiwa") ? MyColors.asuransiCardBlue : MyColors.asuransiCardGreen,
              stops: [0.1, 1],
            ),
          ),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset("assets/images/insurance_bg.png", width: 250),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16, bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${model.nomorAsuransi}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.w700)),

                      Text("${model.namaPeserta}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.w300)),

                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Text("$s",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21.49,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w500)),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 32),
                        width: MediaQuery.of(context).size.width / 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pemegang Polis",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 7.18,
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  SizedBox(height: 5.33),

                                  Text( "${model.pemegangPolis}",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: MediaQuery.of(context).size.width /10),

                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Nomor Polis",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  SizedBox(height: 5.33),

                                  Text( "${model.nomorPolis}",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}