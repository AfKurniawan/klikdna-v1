import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/src/home/widgets/event_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class SemuaPinPage extends StatefulWidget {
  @override
  _SemuaPinPageState createState() => _SemuaPinPageState();
}

class _SemuaPinPageState extends State<SemuaPinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Post It Now",
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
        child: Consumer<HomeProvider>(
          builder:(context, prov, _){
            return  Container(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: prov.pinArray.length,
                  padding: EdgeInsets.all(5),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.83),
                  itemBuilder: (context, index){
                    var document;
                    String text;
                    document = parse(prov.pinArray[index].data.text);
                    text = parse(document.body.text).documentElement.text;
                    return Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 10,
                            color: Colors.grey.withOpacity(0.5),
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
                                Navigator.pushNamed(context, "pin_detail_page",
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
                )
            );
          }
        ),
      ),
    );
  }
}
