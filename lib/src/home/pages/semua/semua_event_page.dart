import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/event_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class SemuaEventPage extends StatefulWidget {
  @override
  _SemuaEventPageState createState() => _SemuaEventPageState();
}

class _SemuaEventPageState extends State<SemuaEventPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Event",
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
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Training",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      )),
                  Consumer<HomeProvider>(
                    builder: (context, prov, _){
                      return GestureDetector(
                        child: Text("Lihat Semua",
                            style: TextStyle(color: MyColors.dnaGreen, fontSize: 12, fontWeight: FontWeight.w400)),
                        onTap: (){
                          prov.filteringCategory(context, 10);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 13),
            buildTraining(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Health Series",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      )),
                  Consumer<HomeProvider>(
                    builder: (context, prov, _){
                      return GestureDetector(
                        child: Text("Lihat Semua",
                            style:
                            TextStyle(color: MyColors.dnaGreen, fontSize: 12, fontWeight: FontWeight.w300)),
                        onTap: () {
                          prov.filteringCategory(context, 13);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 13),
            buildHealthSeries(),
          ],
        ),
      ),
    );
  }

  Widget buildTraining() {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (context, prov, _) {
        return prov.trainingEventArray.length == 0 ?
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/no_data.png"),
                Text("Oopss Belum Ada Event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 5),
                Text("Saat ini belum ada event terbaru", style: TextStyle(fontSize: 12)),
                Text("Cek aplikasi secara berkala untuk mendapatkan update", style: TextStyle(fontSize: 12))
              ],
            )
        )
        : Container(
          height: 341,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: prov.trainingEventArray.length,
            itemBuilder: (context, index) {
              var document;
              String text;
              document = parse(prov.trainingEventArray[index].data.text);
              text = parse(document.body.text).documentElement.text;
              return Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 10, right: 0, left: 10),
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 5,
                        color: Colors.grey[500].withOpacity(0.32),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(
                                context, "detail_event_page",
                                arguments: DummyModel(
                                    "${prov.trainingEventArray[index].data.title}",
                                    "${prov.trainingEventArray[index].data.text}",
                                    "${prov.trainingEventArray[index].imageUrl}",
                                      prov.trainingEventArray.length
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: "${prov.trainingEventArray[index].imageUrl}",
                              width: 325,
                              height: 192,
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 10),
                        child: InkWell(
                          onTap: (){
                            print("SHAREEEEE");
                            prov.shareContents(context,
                                '${prov.trainingEventArray[index].imageUrl}',
                                '${prov.trainingEventArray[index].data.title}\n$text');
                          },
                          splashColor: MyColors.dnaGreen,
                          child: Container(
                            child: Icon(
                              Icons.share_outlined, color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 12.0, top: 10),
                        child: Container(
                            width: MediaQuery.of(context).size.width -50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${prov.trainingEventArray[index].data.title}",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  SizedBox(height: 9),
                                  Container(
                                    child: Text(
                                      "$text",
                                      maxLines: 3,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(height: 14),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildHealthSeries() {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (context, prov, _) {
        return prov.healthEventArray.length == 0 ?
        Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_data.png"),
                  Text("Oopss Belum Ada Event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 5),
                  Text("Saat ini belum ada event terbaru", style: TextStyle(fontSize: 12)),
                  Text("Cek aplikasi secara berkala untuk mendapatkan update", style: TextStyle(fontSize: 12))
                ],
              ),
            )
        )
        : Container(
          height: 390,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: prov.filterArray.length,
            itemBuilder: (context, index) {
              var document;
              String text;
              document = parse(prov.filterArray[index].data.text);
              text = parse(document.body.text).documentElement.text;
              return Container(
                margin: EdgeInsets.only(bottom: 32),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: prov.allEventArray.length < 3 ? prov.allEventArray.length : 3,
                        itemBuilder: (context, index) {
                          var document;
                          String text;
                          document = parse(prov.allEventArray[index].data.text);
                          text = parse(document.body.text).documentElement.text;
                          return Container(
                            margin: EdgeInsets.only(left: 6, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                  color: Colors.grey[700].withOpacity(0.32),
                                ),
                              ],
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(
                                          context, "detail_event_page",
                                          arguments: DummyModel(
                                              "${prov.allEventArray[index].data.title}",
                                              "${prov.allEventArray[index].data.text}",
                                              "${prov.allEventArray[index].imageUrl}",
                                              prov.allEventArray.length
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: "${prov.allEventArray[index].imageUrl}",
                                        width: MediaQuery.of(context).size.width - 32,
                                        height: 192,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                      icon: Icon(Icons.share_outlined, color: Colors.black38),
                                      splashColor: MyColors.dnaGreen,
                                      onPressed: (){
                                        print("SHAREXXX");
                                        prov.shareImageAndText('${prov.allEventArray[index].imageUrl}','${prov.allEventArray[index].data.title}\n$text');
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0, top: 10),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width -50,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${prov.allEventArray[index].data.title}",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(height: 9),
                                              Text(
                                                "$text",
                                                maxLines: 3,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w300,
                                                    fontSize: 12),
                                              ),
                                              //SizedBox(height: 10),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
