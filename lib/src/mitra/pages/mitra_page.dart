import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/styles/my_theme.dart';
import 'package:provider/provider.dart';

class MitraPage extends StatefulWidget {
  @override
  _MitraPageState createState() => _MitraPageState();
}

class _MitraPageState extends State<MitraPage> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<LoginProvider>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light ),
      child: Scaffold(
        backgroundColor: MyColors.background,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 10.0,
                            offset: Offset(0.75, 0)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    height: MediaQuery.of(context).size.height / 5,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 10),
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset("assets/images/no_image.png",
                                  height: 70, width: 70)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Omset",
                              style: TextStyle(
                                  color: MyColors.dnaBlack,
                                  fontSize: 13),
                            ),

                            SizedBox(height: 2),

                            Text(
                              prov.vcommission == null ? "" : "IDR ${prov.vcommission.split(".")[0]}",
                              style: TextStyle(
                                  color: MyColors.dnaBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: () {
                            Navigator.pushNamed(context, "");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Status",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: MyColors.primaryBlack)),

                    SizedBox(height: 10),

                    CardStatusWidget(),

                    SizedBox(height: 20),
                    Text("Tree",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: MyColors.primaryBlack)),

                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 20,
                            color: Color(0xFFB0CCE1).withOpacity(0.32),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            print("CALL TREE WEBSITE");
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.asset(
                              "assets/images/tree_image.png",
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.height / 4 : MediaQuery.of(context).size.height / 3,
                              // height: 150,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Text("Sponsor",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: MyColors.primaryBlack)),

                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: MediaQuery.of(context).size.height / 6,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Color(0xff50A1D3),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 20,
                                color: Color(0xFFB0CCE1).withOpacity(0.32),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10, left: 20),
                                height: 80,
                                width: MediaQuery.of(context).size.width / 1.7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${prov.vsponsorfirstname} ${prov.vsponsorlastname}",
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      GestureDetector(
                                        onTap: (){
                                          print("CALL SPONSOR");
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.phone, size: 15),
                                            SizedBox(width: 5),
                                            Text(prov.vsponsorphone == null ? "-" : "${prov.vsponsorphone}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              decoration: TextDecoration.underline
                                            ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                height: 80,
                                width: 80,
                                margin: EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: (){
                                      print("CALL WHATSAPP");
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/icons/whatsapp_icon.png"),
                                        SizedBox(height: 5),
                                        Text("Whatsapp", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12
                                        ))
                                      ],
                                    ),
                                  ),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class CardStatusWidget extends StatelessWidget {
  const CardStatusWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (child, model, _){
        return Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MyTheme.fullWidth(context) / 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: model.vtype == "Mitra Pro" || model.vtype == "Mitra"
                  ? MyColors.mitraColor
                  : MyColors.mitraProColor,
              stops: [0.1, 1],
            ),
          ),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  right: -10,
                  child: Image.asset("assets/images/card_logo.png", height: 180),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.vtype == null ? "-" : "${model.vtype}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text("PR :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300)),
                          ),

                          SizedBox(width: 5),
                          Flexible(
                            child: Row(
                              children: [
                                Text(model.vleftpointreward == null ? "-" : "${model.vleftpointreward}",
                                    style: TextStyle(
                                        color: model.vtype == "Mitra Pro" || model.vtype == "Mitra" ? Colors.white :Colors.orangeAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                                SizedBox(width: 5),
                                Text("|",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                                SizedBox(width: 5),
                                Text(model.vrightpointreward == null ? "-" : "${model.vrightpointreward}",
                                    style: TextStyle(
                                        color: model.vtype == "Mitra Pro" || model.vtype == "Mitra" ? Colors.white :Colors.orangeAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text("CV :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300)),
                          ),

                          SizedBox(width: 5),
                          Flexible(
                            child: Row(
                              children: [
                                Text(model.vleftcv == null ? "-" : "${model.vleftcv}",
                                    style: TextStyle(
                                        color: model.vtype == "Mitra Pro" || model.vtype == "Mitra" ? Colors.white :Colors.orangeAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),

                                Text(" | ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),

                                Text(model.vrightcv == null ? "-" : "${model.vrightcv}",
                                    style: TextStyle(
                                        color: model.vtype == "Mitra Pro" || model.vtype == "Mitra" ? Colors.white :Colors.orangeAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Text("Tim 1 : ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),

                                Text("${model.vtimone}",
                                    style: TextStyle(
                                        color: model.vtype == "Mitra Pro" || model.vtype == "Mitra" ? Colors.white :Colors.orangeAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),

                                Text(" | ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                                Text("Tim 2 : ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),

                                Text(model.vtimtwo == null ? "-" : "${model.vtimtwo}",
                                    style: TextStyle(
                                        color: model.vtype == "Mitra Pro" || model.vtype == "Mitra" ? Colors.white :Colors.orangeAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),

                      Text(model.vfirstname == null ? "-" : "${model.vfirstname} ${model.vlastname}".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
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
