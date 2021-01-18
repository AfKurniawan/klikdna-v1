import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/event_slider.dart';
import 'package:provider/provider.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, prov, _) {
        return Container(
          height: 360,
          padding: const EdgeInsets.only(bottom: 18.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: prov.allEventArray.length,
            itemBuilder: (context, index) {
              var document;
              String text;
              document =
                  parse(prov.allEventArray[index].data.text);
              text = parse(document.body.text)
                  .documentElement
                  .text;
              return Container(
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
                    EventSlider(
                      svgSrc:
                      "${prov.allEventArray[index].imageUrl}",
                      title: "",
                      width: 350,
                      height: 200,
                      desc: "",
                      press: () {
                        Navigator.pushNamed(
                            context, "detail_event_page",
                            arguments: DummyModel(
                                "${prov.allEventArray[index].data.title}",
                                "${prov.allEventArray[index].data.text}",
                                "${prov.allEventArray[index].imageUrl}"));
                      },
                    ),
                    SizedBox(height: 11),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 12.0),
                      child: Container(
                          width: 300,
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
        );
      },
    );
  }
}