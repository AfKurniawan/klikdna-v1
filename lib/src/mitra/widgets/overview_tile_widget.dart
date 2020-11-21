import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class OverViewTileWidget extends StatelessWidget {
  const OverViewTileWidget({
    Key key,
    @required this.prov,
  }) : super(key: key);

  final LoginProvider prov;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                    color: MyColors.cvTileColor,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width / 2.2,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset("assets/images/lingkaran.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CV",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),

                          SizedBox(height: 21),
                          Row(
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
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(prov.vleftcv == null ? "" : "${prov.vleftcv}",
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Kanan",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(prov.vrightcv == null ? "" : "${prov.vrightcv}",
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

                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              /// TEAM
              buildTeamTile(context)
            ],
          ),

          /// POINT
          buildPointTile(context),
        ],
      ),
    );
  }

  Widget buildTeamTile(BuildContext context) {
    return Container(
              height: 120,
              decoration: BoxDecoration(
                  color: MyColors.teamTileColor,
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width / 2.2,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset("assets/images/lingkaran.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Team",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        ),

                        SizedBox(height: 21),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("1",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vtimone == null ? "" : "${prov.vtimone}",
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("2",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vtimtwo == null ? "" : "${prov.vtimtwo}",
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

                      ],
                    ),
                  ),
                ],
              ),
            );
  }

  Widget buildPointTile(BuildContext context) {
    return Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                  color: MyColors.pointRewardTileColor,
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width / 2.2,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset("assets/images/lingkaran.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Point Reward",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        ),

                        SizedBox(height: 21),
                        Row(
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
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vleftpointreward == null ? "" : "${prov.vleftpointreward}",
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Kanan",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(prov.vrightpointreward == null ? "" : "${prov.vrightpointreward}",
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
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Material(
              child: InkWell(
                splashColor: Colors.white,
                onTap: (){
                  print("SALDO CLICKED");
                },
                child: Ink(
                  height: 120,
                  decoration: BoxDecoration(
                      color: MyColors.totalSaldoTileColor,
                      borderRadius: BorderRadius.circular(20)),
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, bottom: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Saldo",
                              overflow: TextOverflow.clip,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 14,
                            ),

                            SizedBox(width: 20),
                            Align(
                                alignment: Alignment.topRight,
                                child: Image.asset("assets/images/lingkaran.png")),
                          ],
                        ),

                        //SizedBox(height: 21),
                        Text(prov.vtotalcommission == null ? "" : "RP. ${prov.vtotalcommission.split(".")[0]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
  }
}