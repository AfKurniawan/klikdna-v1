import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class DetailEventPage extends StatefulWidget {

  final DummyModel model ;

  DetailEventPage({Key key, this.model}) : super(key: key);

  @override
  _DetailEventPageState createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {


  @override
  Widget build(BuildContext context) {
    var document;
    String text;
    document = parse(widget.model.desc);
    text = parse(document.body.text).documentElement.text;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Kembali",
          style: TextStyle(fontSize: 14),
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
              //Navigator.pushReplacementNamed(context, "detail_report_page");
              Navigator.of(context).pop();
            }),
        actions: [
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, prov, _){
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 0, top: 0),
                    child: Container(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.height / 3.3
                            :  MediaQuery.of(context).size.height * 1.22,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){

                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: CachedNetworkImage(
                                imageUrl: '${widget.model.image}',
                                height: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.height / 1.9
                                    :  MediaQuery.of(context).size.height * 1.7,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left:12.0, right: 12),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              print("SHAREEEEE");
                              prov.shareContents(context, '${widget.model.image}', '${widget.model.title}\n$text');
                              //NativeShare.share({'title':'${widget.model.desc}','url': "", 'image':'https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616__340.jpg'});
                            },
                            splashColor: MyColors.dnaGreen,
                            child: Container(
                              child: Icon(
                                Icons.share_outlined, color: Colors.black54,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: (){
                              print("COPY");
                              prov.copyText("${widget.model.title}\n${widget.model.desc}");
                            },
                            child: Image.asset("assets/icons/copy_icon.png", height: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: Text("${widget.model.title}", style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      )),

                  SizedBox(height: 20),
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: HtmlWidget("${widget.model.desc}",
                          textStyle: TextStyle(fontSize: 14),
                          onTapUrl: (url){
                            print("URL: $url");
                            prov.handleUrl(url);
                          },
                        ),
                      )),



                  SizedBox(height: 24),

                ],
              ),
            ),
          );
        },
      )
    );
  }

}
