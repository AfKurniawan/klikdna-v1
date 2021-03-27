import 'package:flutter/material.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class OverViewTileWidget extends StatelessWidget {
  const OverViewTileWidget({
    Key key,
    @required this.prov,
  }) : super(key: key);

  final MitraProvider prov;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              buildCVTile(context),
              SizedBox(height: 15),
              buildTeamTile(context)
            ],
          ),
          SizedBox(width: 14),
          Column(
            children: [
              buildPoint(context),
              SizedBox(height: 15),
              buildCycleTile(context)
            ],
          )

        ],
      ),
    );
  }

  Widget buildCVTile(BuildContext context) {
    return Container(
              height: 110,
              width: MediaQuery.of(context).size.width / 2.3,
              decoration: BoxDecoration(
                  color: MyColors.cvTileColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset("assets/images/lingkaran.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 17, left: 17, right: 19),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CV",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700
                          ),
                        ),

                        SizedBox(height: 21),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kiri",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vleftcv == null ? "0" : "${prov.vleftcv}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ("${prov.vleftcv}").length > 5 ? 14 : 18,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kanan",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vrightcv == null ? "0" : "${prov.vrightcv}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ("${prov.vrightcv}").length > 5 ? 14 : 18,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            );
  }

  Widget buildTeamTile(BuildContext context) {
    return Container(
              height: 110,
              decoration: BoxDecoration(
                  color: MyColors.teamTileColor,
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width / 2.3,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset("assets/images/lingkaran.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, left: 16, right: 16, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("TIM",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "Proxima",
                              fontWeight: FontWeight.w700
                          ),
                        ),

                        SizedBox(height: 21),
                        prov.vtimoneposition == "left" ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kiri",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vtimone == null ? "-" : "${prov.vtimone}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ("${prov.vtimone}").length > 5 ? 14 : 18,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kanan",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vtimtwo == null ? "-" : "${prov.vtimtwo}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ("${prov.vtimtwo}").length > 5 ? 14 : 18,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Kiri",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vtimtwo == null ? "" : "${prov.vtimtwo}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ("${prov.vtimtwo}").length > 5 ? 14 : 18,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kanan",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vtimone == null ? "" : "${prov.vtimone}",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ("${prov.vtimone}").length > 5 ? 14 : 18,
                                      fontFamily: "Proxima",
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            );
  }

  Widget buildPoint(BuildContext context) {
    String pointKiri = prov.vleftpointreward.toString();
    return Container(
            height: 110,
            decoration: BoxDecoration(
                color: MyColors.pointRewardTileColor,
                borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width / 2.3,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset("assets/images/lingkaran.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 17, bottom: 17, right: 19),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("POINT REWARD",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: "Proxima",
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(height: 21),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Kiri",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "Proxima",
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(prov.vleftpointreward == null ? "0" : "${prov.vleftpointreward}",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: pointKiri.length > 5 ? 14 : 18,
                                    fontFamily: "Proxima",
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Kanan",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "Proxima",
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(prov.vrightpointreward == null ? "0" : "${prov.vrightpointreward}",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: pointKiri.length > 5 ? 14 : 18,
                                    fontFamily: "Proxima",
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildCycleTile(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
          color: MyColors.totalSaldoTileColor,
          borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width / 2.3,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, bottom: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("CYCLE",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "Proxima",
                      fontWeight: FontWeight.w500
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset("assets/images/lingkaran.png")),
              ],
            ),

            //SizedBox(height: 21),

            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hari Ini",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(prov.vdailycycle == null ? "" : "${prov.vdailycycle}",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bulan Ini",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(prov.vmonthlycycle == null ? "" : "${prov.vmonthlycycle}",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
    );
  }
}