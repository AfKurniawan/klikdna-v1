import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/models/home_model.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class AllEventByCategoriesPage extends StatefulWidget {


  @override
  _AllEventByCategoriesPageState createState() => _AllEventByCategoriesPageState();
}

class _AllEventByCategoriesPageState extends State<AllEventByCategoriesPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Training",
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Consumer<HomeProvider>(
          builder: (context, prov, _) {
            return prov.filterArray.length == 0 ?
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
              height: MediaQuery.of(context).size.height /2.09,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: prov.filterArray.length,
                itemBuilder: (context, index) {
                  var document;
                  String text;
                  document = parse(prov.filterArray[index].data.text);
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
                                        "${prov.filterArray[index].data.title}",
                                        "${prov.filterArray[index].data.text}",
                                        "${prov.filterArray[index].imageUrl}",
                                          prov.filterArray.length
                                    ));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl: "${prov.filterArray[index].imageUrl}",
                                  width: size.width - 10,
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
                                    '${prov.filterArray[index].imageUrl}',
                                    '${prov.filterArray[index].data.title}\n$text');
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
                                        "${prov.filterArray[index].data.title}",
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
        ),
      )
    );
  }

}
