import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class SemuaPinPage extends StatefulWidget {
  @override
  _SemuaPinPageState createState() => _SemuaPinPageState();
}

class _SemuaPinPageState extends State<SemuaPinPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  //padding: EdgeInsets.all(5),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: size.width < 600 ? 0.78 : 0.85),
                  itemBuilder: (context, index){
                    var document;
                    String text;
                    document = parse(prov.pinArray[index].data.text);
                    text = parse(document.body.text).documentElement.text;
                    return Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
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
                            width: 152,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, "detail_pin_page",
                                      arguments: DummyModel(
                                          "${prov.pinArray[index].data.title}",
                                          "${prov.pinArray[index].data.text}",
                                          '${prov.pinArray[index].imageUrl}',
                                          prov.pinArray.length
                                      ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: prov.pinArray[index].imageUrl,
                                    width: 158,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 9),
                          Container(
                            width: MediaQuery.of(context).size.width -100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10),
                              child: Text(
                                "${prov.pinArray[index].data.title}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
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
