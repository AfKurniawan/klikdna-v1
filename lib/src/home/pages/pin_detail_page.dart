import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:native_share/native_share.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/my_appbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class PinDetailPage extends StatefulWidget {

  DummyModel model ;
  static const routeName = 'details';

  PinDetailPage({Key key, this.model}) : super(key: key);

  @override
  _PinDetailPageState createState() => _PinDetailPageState();
}

class _PinDetailPageState extends State<PinDetailPage> {


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
          "Post It Now",
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 2, top: 0),
                child: Container(
                  child: DashboardSlider(
                    imgSrc:
                    "${widget.model.image}",
                    title: "",
                    margin: EdgeInsets.only(right: 10),
                    desc: "",
                    press: () {

                    },
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
                          shareImage(context, '${widget.model.image}', '$text');
                          //NativeShare.share({'title':'${widget.model.desc}','url': "", 'image':'https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616__340.jpg'});
                        },
                        splashColor: MyColors.dnaGreen,
                        child: Container(
                          child: Icon(
                            Icons.share, color: Colors.black54,
                            size: 25,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: (){
                          print("COPY");
                          copyText("$text");
                        },
                        child: Image.asset("assets/icons/copy_icon.png", height: 25),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Container(
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 12.0, right: 12),
              //       child: Text("${widget.model.title}", style:
              //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              //     )),

              //SizedBox(height: 20),
              // Container(
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 12.0, right: 12),
              //       child: Text("${widget.model.desc}"),
              // )),

              Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: HtmlWidget("${widget.model.desc}",
                      textStyle: TextStyle(fontSize: 14),
                    ),
                  )),



              SizedBox(height: 24),

            ],
          ),
        ),
      ),
    );
  }

  copyText(String desc){
    Clipboard.setData(new ClipboardData(text: "$desc"))
        .then((result) {

      Fluttertoast.showToast(
          msg: "Text berhasil dicopy",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );

    });
  }

  Future<File> shareImage(BuildContext context, String path, String desc) async {


    final response = await http.get("$path");
    final Directory tempo = await getTemporaryDirectory();
    final File imageFile = File('${tempo.path}/sharedImages.jpg');
    imageFile.writeAsBytesSync(response.bodyBytes);

    if(Platform.isIOS){
      Share.shareFiles(['${tempo.path}/sharedImages.jpg']);
      copyText(desc);
    } else {
      Share.shareFiles(['${tempo.path}/sharedImages.jpg'], text: '$desc');
    }

    return imageFile;
  }
}


