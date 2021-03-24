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
        return prov.pinArray.length == 0 ?
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/no_data.png"),
                Text("Oopss Belum Post It Now", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 5),
                Text("Saat ini belum ada post it now terbaru", style: TextStyle(fontSize: 12)),
                Text("Cek aplikasi secara berkala untuk mendapatkan update", style: TextStyle(fontSize: 12))
              ],
            )
        )
        : Padding(
          padding: const EdgeInsets.only(bottom: 32.0, left: 0, right: 0),
          child: Container(
            height: 210,
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
                  margin: EdgeInsets.only(left: 12, bottom: 10, top: 10, ),
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
                      DashboardSlider(
                          imgSrc: prov.pinArray[index].imageUrl,
                          title: "",
                          width: 158,
                          height: 154,
                          desc: "",
                          press: () {
                            Navigator.pushNamed(context, "detail_pin_page",
                                arguments: DummyModel(
                                    "${prov.pinArray[index].data.title}",
                                    "${prov.pinArray[index].data.text}",
                                    '${prov.pinArray[index].imageUrl}',
                                    prov.pinArray.length
                                ));
                          }),
                      SizedBox(height: 12),
                      Container(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "${prov.pinArray[index].data.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
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