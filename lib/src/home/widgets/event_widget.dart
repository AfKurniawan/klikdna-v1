import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/event_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer<HomeProvider>(
        builder: (context, prov, _) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 18),
            child: Container(
              height: MediaQuery.of(context).size.height /2.09,
              child: Row(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      var document;
                      String text;
                      document = parse(prov.trainingEventArray[index].data.text);
                      text = parse(document.body.text).documentElement.text;
                      return Container(
                        margin: EdgeInsets.only(right: 18),
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
                            Container(
                              width: size.width - 20,
                              height: size.height / 3.7,
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
                              padding: const EdgeInsets.only(left:8.0, top: 8),
                              child: InkWell(
                                onTap: (){
                                  print("SHAREEEEE");
                                  prov.shareContents(context, '${prov.allEventArray[index].imageUrl}', '${prov.allEventArray[index].data.title}\n$text');
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
                                          "${prov.allEventArray[index].data.title}",
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
                      );
                    },
                  ),
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      var document;
                      String text;
                      document = parse(prov.healthEventArray[index].data.text);
                      text = parse(document.body.text).documentElement.text;
                      return Container(
                        margin: EdgeInsets.only(right: 18),
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
                            Container(
                              width: size.width - 15,
                              height: size.height / 3.7,
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
                                      fit: BoxFit.fill,
                                      height: size.height / 4,
                                      // height: 150,
                                    ),
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
                                  prov.shareContents(context, '${prov.healthEventArray[index].imageUrl}', '${prov.healthEventArray[index].data.title}\n$text');
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
                                          child: Text("$text",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(fontSize: 12),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}