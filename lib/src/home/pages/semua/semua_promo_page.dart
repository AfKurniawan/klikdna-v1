
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/detail_widget.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class SemuaPromoPage extends StatefulWidget {
  @override
  _SemuaPromoPageState createState() => _SemuaPromoPageState();
}

class _SemuaPromoPageState extends State<SemuaPromoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Semua Promo",
          style: TextStyle(color: MyColors.primaryBlack, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.dnaGrey,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Container(
              width: 156,
              height: 35,
              decoration: BoxDecoration(
                color: MyColors.dnaGreen,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                    ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 20,
                    color: Colors.grey.withOpacity(0.32),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                child: Text("Semua Promo", style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500
                ),),
              ),
            ),
            SizedBox(height: 16),
            Consumer<HomeProvider>(
              builder: (context, prov, _){
                 return Container(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: prov.bannerArray.length,
                    itemBuilder: (context, index) {
                      var document;
                      String text;
                      document = parse(prov.bannerArray[index].data.text);
                      text = parse(document.body.text)
                          .documentElement
                          .text;
                      return Container(
                        height: 250,
                        margin: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 1,
                              color: Colors.grey.withOpacity(0.32),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailWidget(
                              svgSrc:
                              "${prov.bannerArray[index].imageUrl}",
                              title: "",
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              desc: "",
                              radiusTr: 10,
                              radiusTl: 10,
                              press: () {
                                Navigator.pushNamed(
                                    context, "detail_promo_page",
                                    arguments: DummyModel(
                                        "${prov.bannerArray[index].data.title}",
                                        "${prov.bannerArray[index].data.text}",
                                        "${prov.bannerArray[index].imageUrl}",
                                          prov.bannerArray.length

                                    ));
                              },
                            ),
                            SizedBox(height: 11),
                            Padding(
                              padding:
                              const EdgeInsets.only(bottom: 0, top: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 90,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 0),
                                        child: Text(
                                          "$text",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Roboto",
                                            fontSize: 14,
                                          ),
                                        ),
                                        ),
                                      ),
                                  Text(
                                    "Lihat Detail",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      color: Colors.grey
                                    ),
                                  ),
                                ],
                              )),

                          ],
                        ),
                      );
                    },
                  ),
                );

              },
            )
          ],
        ),
      ),
    );
  }
}
