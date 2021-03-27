import 'package:flutter/material.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class CardTypeDuaWidget extends StatelessWidget {
  const CardTypeDuaWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MitraProvider>(
      builder: (child, model, _){
        return Container(
          margin: EdgeInsets.only(
              right: 10,
              left: 2
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors:
                    //model.vhighestrank.contains("Leader")
                    // ? MyColors.imperialLeaderColor
                    model.vpar.contains("Builder")
                  ? MyColors.builderCardColor
                        : model.vpar.contains("Producer")
                        ? MyColors.producerCardColor
                  : model.vhighestrank.contains("Leader")
                  ? MyColors.imperialLeaderColor
                  : model.vpar.contains("Presidential")
                  ? MyColors.presidentAndDirectorColor
                  : model.vpar.contains("Star")
                  ? MyColors.startCardColor
                  : (model.vhighestrank == "0" && model.vtype.contains('Mitra')) || model.vhighestrank.contains('Mitra')
                  ? MyColors.mitraCardColor
                  // : model.vhighestrank.contains('Producer')
                  // ? MyColors.producerColor

                  // : model.vhighestrank.contains('Star')
                  // ? MyColors.startCardColor
                  : MyColors.mitraCardColor,
              stops: [0.1, 1],
            ),
          ),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: -15,
                  child: Image.asset("assets/images/card_logo.png", height: 200),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 11, right: 12, bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${model.vpar}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Proxima",
                              fontWeight: FontWeight.bold)),
                      //SizedBox(height: 5),
                      Text(model.vhighestrank == "0" || model.vpar == ""
                          ? model.vrank == ""
                          ? "Kualifikasi Peringkat: -"
                          : "Kualifikasi Peringkat: ${model.vrank}"
                          : "Kualifikasi Peringkat: ${model.vrank}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300)),

                      SizedBox(height: 90),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(model.vallName.length > 20 ? "${model.vallName.substring(0, 20).toUpperCase()}" : "${model.vallName.toUpperCase()}",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: "Proxima",
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            SizedBox(width: MediaQuery.of(context).size.width /10),

                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("MASA BERLAKU",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(model.parsedTanggalExpired == null ? "-" : "${model.parsedTanggalExpired.substring(0, 11)}",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Proxima",
                                        fontWeight: FontWeight.bold
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
        );
      },
    );
  }
}