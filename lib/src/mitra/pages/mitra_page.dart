import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/mitra/widgets/card_type_dua_widget.dart';
import 'package:new_klikdna/src/mitra/widgets/card_type_satu_widget.dart';
import 'package:new_klikdna/src/mitra/widgets/header_widget.dart';
import 'package:new_klikdna/src/mitra/widgets/overview_tile_widget.dart';
import 'package:new_klikdna/src/mitra/widgets/sponsor_widget.dart';
import 'package:new_klikdna/src/mitra/widgets/tree_webview_widget.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class MitraPage extends StatefulWidget {
  @override
  _MitraPageState createState() => _MitraPageState();
}

class _MitraPageState extends State<MitraPage> {

  final List<Widget> slideCard = [
    CardTypeSatuWidget(),
    CardTypeDuaWidget()
  ];

  int _current = 0;

  @override
  void initState() {
    Provider.of<LoginProvider>(context, listen: false).getMitraData();
    super.initState();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(prov: prov),
              SizedBox(height: 20),
              prov.vtype == "Mitra Pro" ?
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      child: CarouselSlider(
                        items: slideCard,
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: false,
                            viewportFraction: 1.0,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: slideCard.map((url) {
                            int index = slideCard.indexOf(url);
                            if (_current == index) {
                              return Container(
                                width: 18.0,
                                height: 8.0,
                                margin:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  color: MyColors.dnaGreen,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            } else {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: MyColors.grey),
                              );
                            }
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CardTypeSatuWidget(),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text("Overview",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    SizedBox(height: 15),

                    OverViewTileWidget(prov: prov),

                    SizedBox(height: 20),

                    Text("Tree",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: MyColors.primaryBlack)),

                    TreeWebViewWidget(prov: prov),

                    Text("Sponsor",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: MyColors.primaryBlack)),

                    SponsorWidget(prov: prov)

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




