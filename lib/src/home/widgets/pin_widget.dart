import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:provider/provider.dart';

class PinWidget extends StatelessWidget {
  const PinWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, prov, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Container(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                var document;
                String text;
                document = parse(prov.pinArray[index].data.text);
                text = parse(document.body.text).documentElement.text;
                return Container(
                  margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                      DashboardSlider(
                          imgSrc: prov.pinArray[index].imageUrl,
                          title: "",
                          width: 160,
                          height: 160,
                          margin: EdgeInsets.only(right: 10, left: 10),
                          desc: "",
                          press: () {
                            Navigator.pushNamed(context, "detail_pin_page",
                                arguments: DummyModel(
                                    "${prov.pinArray[index].data.title}",
                                    //"${prov.pinArray[index].data.text}",
                                    "$text",
                                    '${prov.pinArray[index].imageUrl}'));
                          }),
                      SizedBox(height: 9),
                      Container(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "${prov.pinArray[index].data.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}