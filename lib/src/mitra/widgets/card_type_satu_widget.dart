import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/styles/my_theme.dart';
import 'package:provider/provider.dart';

class CardTypeSatuWidget extends StatelessWidget {
  const CardTypeSatuWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<LoginProvider>(
      builder: (child, model, _){
        return Container(
          margin: EdgeInsets.only(
              right: 10,
              left: 2
          ),
          height: MediaQuery.of(context).size.width < 400 ? MediaQuery.of(context).size.height / 3.5 : MediaQuery.of(context).size.height / 4,
          width: model.vhighestrank == "0" ? MyTheme.fullWidth(context) / 1 : MyTheme.fullWidth(context) / 1.057,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors:
              model.vhighestrank == "Imperial Leader"
                  ? MyColors.imperialLeaderColor
                  : model.vhighestrank == "0" && model.vtype == "Mitra" && model.vtype == "Mitra Pro"
                  ? MyColors.mitraCardColor
                  : model.vhighestrank == "1 Star"
                  ? MyColors.startCardColor
                  : model.vhighestrank == "Executive Builder" || model.vhighestrank == "Elite Builder" || model.vhighestrank == "Pro Builder"
                  ? MyColors.builderCardColor
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
                  padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.vhighestrank == "0" || model.vpar == "" ? "${model.vtype}" : "${model.vhighestrank}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),

                      Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text("${model.vfirstname} ${model.vlastname}",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),

                            SizedBox(width: 30),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("MASA BERLAKU",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),

                                Text(model.parsedTanggalExpired == null ? "-" : "${model.parsedTanggalExpired.substring(0, 10)}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
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