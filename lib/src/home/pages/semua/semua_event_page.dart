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
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Training",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sanomat Grab Web',
                        color: Colors.black,
                      )),
                  Consumer<HomeProvider>(
                    builder: (context, prov, _){
                      return GestureDetector(
                        child: Text("Lihat Semua",
                            style: TextStyle(color: MyColors.dnaGreen, fontSize: 14)),
                        onTap: (){
                          prov.filteringCategory(context, 10);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            buildTraining(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Health Series",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sanomat Grab Web',
                        color: Colors.black,
                      )),
                  Consumer<HomeProvider>(
                    builder: (context, prov, _){
                      return GestureDetector(
                        child: Text("Lihat Semua",
                            style:
                            TextStyle(color: MyColors.dnaGreen, fontSize: 14)),
                        onTap: () {
                          prov.filteringCategory(context, 13);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
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
          height: size.width > 600 ? 670 : 400,
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
                padding: const EdgeInsets.only(top:10, bottom: 10, right: 10, left: 10),
                child: Container(
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
                              width: size.width - 20,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0, top: 8),
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
                        const EdgeInsets.only(left: 10.0, top: 10),
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
                                        FontWeight.bold,
                                        fontSize: 13),
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
                                          FontWeight.normal,
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
          height: size.width > 600 ? 670 : 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: prov.healthEventArray.length,
            itemBuilder: (context, index) {
              var document;
              String text;
              document = parse(prov.healthEventArray[index].data.text);
              text = parse(document.body.text).documentElement.text;
              return Padding(
                padding: const EdgeInsets.only(top:10, bottom: 10, right: 10, left: 10),
                child: Container(
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
                                    "${prov.healthEventArray[index].data.title}",
                                    "${prov.healthEventArray[index].data.text}",
                                    "${prov.healthEventArray[index].imageUrl}",
                                      prov.healthEventArray.length
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: "${prov.healthEventArray[index].imageUrl}",
                              width: size.width - 20,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0, top: 8),
                        child: InkWell(
                          onTap: (){
                            print("SHAREEEEE");
                            prov.shareContents(context,
                                '${prov.healthEventArray[index].imageUrl}',
                                '${prov.healthEventArray[index].data.title}\n$text');
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
                        const EdgeInsets.only(left: 10.0, top: 10),
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
                                    "${prov.healthEventArray[index].data.title}",
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 13),
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
                                          FontWeight.normal,
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
}
