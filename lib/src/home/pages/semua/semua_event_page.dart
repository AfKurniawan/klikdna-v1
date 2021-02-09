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
                  GestureDetector(
                    child: Text("Lihat Semua",
                        style:
                            TextStyle(color: MyColors.dnaGreen, fontSize: 14)),
                    onTap: () {
                      Navigator.pushNamed(context, "semua_event_page");
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
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
                  GestureDetector(
                    child: Text("Lihat Semua",
                        style:
                        TextStyle(color: MyColors.dnaGreen, fontSize: 14)),
                    onTap: () {
                      Navigator.pushNamed(context, "semua_event_page");
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            buildHealthSeries(),
          ],
        ),
      ),
    );
  }

  Consumer<HomeProvider> buildTraining() {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
            builder: (context, prov, _) {
              return Container(
                height: 400,
                padding: const EdgeInsets.only(bottom: 18.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: prov.trainingEventArray.length,
                  itemBuilder: (context, index) {
                    var document;
                    String text;
                    document = parse(prov.trainingEventArray[index].data.text);
                    text = parse(document.body.text).documentElement.text;
                    return Container(
                      height: MediaQuery.of(context).size.height /2.1,
                      margin: EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 10,
                            color: Colors.grey.withOpacity(1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width - 20,
                            height: size.height / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(
                                      context, "detail_event_page",
                                      arguments: DummyModel(
                                          "${prov.trainingEventArray[index].data.title}",
                                          "${prov.trainingEventArray[index].data.text}",
                                          "${prov.trainingEventArray[index].imageUrl}"));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl: "${prov.trainingEventArray[index].imageUrl}",
                                    //width: size.width - 40,
                                    fit: BoxFit.cover,
                                    height: size.height / 4,
                                    // height: 150,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 11),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                                width: 300,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          child: Icon(Icons.share_outlined, size: 30),
                                      onTap: (){
                                        prov.shareContents(context, '${prov.trainingEventArray[index].imageUrl}', '$text');
                                      },
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "${prov.trainingEventArray[index].data.title}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      SizedBox(height: 9),
                                      Container(
                                        child: Text(
                                          "$text",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
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
              return Container(
                height: 400,
                padding: const EdgeInsets.only(bottom: 18.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: prov.healthEventArray.length,
                  itemBuilder: (context, index) {
                    var document;
                    String text;
                    document = parse(prov.healthEventArray[index].data.text);
                    text = parse(document.body.text).documentElement.text;
                    return Container(
                      height: 400,
                      margin: EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 10,
                            color: Colors.grey.withOpacity(1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width - 20,
                            height: size.height / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(
                                      context, "detail_event_page",
                                      arguments: DummyModel(
                                          "${prov.healthEventArray[index].data.title}",
                                          "${prov.healthEventArray[index].data.text}",
                                          "${prov.healthEventArray[index].imageUrl}"));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl: "${prov.healthEventArray[index].imageUrl}",
                                    //width: size.width - 40,
                                    fit: BoxFit.cover,
                                    height: size.height / 4,
                                    // height: 150,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 11),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                                width: 300,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          prov.shareContents(context, '${prov.healthEventArray[index].imageUrl}', '$text');
                                        },
                                          child: Icon(Icons.share_outlined, size: 30)),
                                      SizedBox(height: 20),
                                      Text(
                                        "${prov.healthEventArray[index].data.title}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      SizedBox(height: 9),
                                      Container(
                                        child: Text(
                                          "$text",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
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
                    );
                  },
                ),
              );
            },
          );
  }
}
