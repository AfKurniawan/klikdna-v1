import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/parser.dart';
import 'package:native_share/native_share.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/models/home_model.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/event_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({
    Key key,
  }) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}



class _EventWidgetState extends State<EventWidget> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Consumer<HomeProvider>(
        builder: (context, prov, _) {
          return prov.allEventArray.length == 0 ?
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
          : Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 18),
            child: Container(
              height: size.width > 600 ? 650 : 380,
              child: Row(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: prov.healthArray > 0
                        ? 2 : 3,
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
                            Container(
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              child: IconButton(
                                icon: Icon(Icons.share_outlined, color: Colors.black38),
                                splashColor: MyColors.dnaGreen,
                                onPressed: (){
                                  print("SHAREXXX");
                                  prov.shareImageAndText('${prov.trainingEventArray[index].imageUrl}','${prov.trainingEventArray[index].data.title}\n$text');
                                },
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
                                          "${prov.trainingEventArray[index].data.status} ${prov.trainingEventArray[index].data.categoryId}",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 12),
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
                                                fontSize: 10),
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
                    itemCount: prov.healthArray > 0 ? 1 : 0,
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

                            Container(
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              child: IconButton(
                                icon: Icon(Icons.share_outlined, color: Colors.black54),
                                splashColor: MyColors.dnaGreen,
                                onPressed: (){
                                  print("SHAREXXX");
                                  prov.shareImageAndText('${prov.healthEventArray[index].imageUrl}','${prov.healthEventArray[index].data.title}\n$text');
                                },

                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10.0),
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
                                              fontSize: 12),
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
                                                fontSize: 10),
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