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
            padding: const EdgeInsets.only(left: 10.0, bottom: 32),
            child: Container(
              height: 341,
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
                                    width: 316,
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
  }
}