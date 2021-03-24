import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/styles/my_theme.dart';
import 'package:provider/provider.dart';

class CardTypeSatuWidget extends StatelessWidget {
  const CardTypeSatuWidget({
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
          //width: model.vhighestrank == "0" ? MyTheme.fullWidth(context) / 1 : MyTheme.fullWidth(context) / 1.057,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors:
              model.vhighestrank.contains("Leader")
                  ? MyColors.imperialLeaderColor
                  : (model.vhighestrank == "0" && model.vtype == "Mitra" && model.vtype == "Mitra Pro")
                  ? MyColors.mitraCardColor
                  : model.vhighestrank.contains("Star")
                  ? MyColors.startCardColor
                  : model.vhighestrank.contains("Builder")
                  ? MyColors.builderCardColor
                  : model.vhighestrank.contains("Producer")
                  ? MyColors.producerCardColor
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
                  padding: const EdgeInsets.only(left: 12.0, top: 12, right: 12, bottom: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.vhighestrank == "0" || model.vpar == "" ? "${model.vtype}" : "${model.vhighestrank}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Proxima",
                              fontWeight: FontWeight.bold)),

                      Container(
                        margin: EdgeInsets.only(top: 80),
                        width: MediaQuery.of(context).size.width / 1,
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
                              child: model.vtype == "Mitra" ? Container()
                              : Column(
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
                                  Text(model.parsedTanggalExpired == null ? "-" : "${model.parsedTanggalExpired}",
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