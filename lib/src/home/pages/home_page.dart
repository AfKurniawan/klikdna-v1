import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/providers/artikel_provider.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/banner_slider.dart';
import 'package:new_klikdna/src/home/widgets/event_widget.dart';
import 'package:new_klikdna/src/home/widgets/pin_widget.dart';
import 'package:new_klikdna/src/home/widgets/podcast_slider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/loading_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class HomePage extends StatefulWidget {
  final DummyModel model;
  HomePage({Key key, this.model}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
   // Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken(context);
    Provider.of<MitraProvider>(context, listen: false).refreshMitraData();
    context.read<HomeProvider>().getHomeContentsxx(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        //appBar:  myApbar(context),
        body: Consumer<HomeProvider>(
          builder: (context, prov, _){
            return prov.isLoading == true ? LoadingWidget()
                : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      BannerSlider(),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 20,
                              color: Colors.grey.withOpacity(0.32),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Post It Now",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Sanomat Grab Web',
                                        color: MyColors.blackPrimary,
                                      )),
                                  GestureDetector(
                                    child: Text("Lihat Semua",
                                        style: TextStyle(
                                            color: MyColors.dnaGreen,
                                            fontSize: 14)),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "semua_pin_page");
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            PinWidget(),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 20,
                              color: Colors.grey.withOpacity(0.32),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Event",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Sanomat Grab Web',
                                        color: MyColors.blackPrimary,
                                      )),
                                  GestureDetector(
                                    child: Text("Lihat Semua",
                                        style: TextStyle(
                                            color: MyColors.dnaGreen, fontSize: 14)),
                                    onTap: () {
                                      Navigator.pushNamed(context, "semua_event_page");
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            EventWidget(),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 10,
                              color: Colors.grey.withOpacity(0.32),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Podcast",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Sanomat Grab Web',
                                          color: Colors.black,
                                        )),

                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: Stack(
                                  children: [
                                    PodcastSlider(
                                      imgSrc: "assets/images/netpro_image.png",
                                      title: "",
                                      width: 130,
                                      height: 130,
                                      margin: EdgeInsets.only(right: 10, bottom: 10),
                                      desc: "",
                                      press: () {
                                        //launchSpotify();
                                      },
                                    ),
                                    Positioned(
                                      top: 0,
                                        left: 0,
                                        child: Center(
                                          child: Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text("Coming Soon", style: TextStyle(color: Colors.white, fontSize: 12)),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Text("Netpro", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Klikdna", style: TextStyle(fontWeight: FontWeight.w200)),
                              SizedBox(height: 14),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  //SizedBox(height: 10)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  

  void launchSpotify() async {
    const url = 'https://spotify.com';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchGooglePodcast() async {
    const url = 'https://podcasts.google.com';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchApplePodcast() async {
    const url = 'https://podcasts.apple.com';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareImageAndText(String image, String text) async {
    try {
      await WcFlutterShare.share(
          sharePopupTitle: 'Share',
          subject: 'This is subject',
          text: 'This is text',
          mimeType: 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<File> shareImage(
      BuildContext context, String path, String desc) async {
    final byteData = await rootBundle.load('$path');
    final Directory tempo = await getTemporaryDirectory();
    final File imageFile = File('${tempo.path}/sharedImages.jpg');
    await imageFile.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    if (Platform.isIOS) {
      Share.shareFiles(['${tempo.path}/sharedImages.jpg']);
      Clipboard.setData(new ClipboardData(text: "$desc")).then((result) {
        Fluttertoast.showToast(
            msg:
                "Text yang akan dibagikan sudah dicopy, tempel pada caption anda",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      Share.shareFiles(['${tempo.path}/sharedImages.jpg'], text: '$desc');
    }

    return imageFile;
  }

  ///KANGGO OJO DIHAPUSSSSSSSSS ///////////////////////////////////////////////
  // void shareImage(BuildContext context) async {
  //   final response = await http.get("https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616__340.jpg");
  //   final Directory tempo = await getTemporaryDirectory();
  //   final File imageFile = File('${tempo.path}/sharedImages.jpg');
  //   imageFile.writeAsBytesSync(response.bodyBytes);
  //   Share.shareFiles(['${tempo.path}/tempImage.jpg'],
  //     //text: '$textevent1'
  //   );
  //
  //   Clipboard.setData(new ClipboardData(text: "$eventDesc1"))
  //       .then((result) {
  //
  //     Fluttertoast.showToast(
  //         msg: "Text berhasil dicopy",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.SNACKBAR,
  //         timeInSecForIosWeb: 2,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //     );
  //
  //   });
  //
  // }

  // void whatsAppOpen() async {
  //   final response = await http.get("https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616__340.jpg");
  //   final Directory tempo = await getTemporaryDirectory();
  //   final File imageFile = File('${tempo.path}/sharedImages.jpg');
  //   bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");
  //
  //   if (whatsapp) {
  //     await FlutterLaunch.launchWathsApp(phone: "+6285155488140", message: "Hello, https://cdn.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616__340.jpg");
  //   } else {
  //     imageFile.writeAsBytesSync(response.bodyBytes);
  //     Share.shareFiles(['${tempo.path}/tempImage.jpg'],
  //         subject: "$textevent1"
  //     );
  //   }
  // }

  // void openWhatsapp(BuildContext context) {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CupertinoDialogWidget(
  //         title: "Menghubungi via Whatsapp",
  //         message:
  //         'Apakah anda yakin akan menghubungi KlikDNA melalui Whatsapp ?',
  //         action: () {
  //           Navigator.of(context).pop();
  //           if (Platform.isIOS) {
  //             launch('whatsapp://send?phone=+62816307362');
  //           } else {
  //             launch('whatsapp://send?phone=+62816307362');
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

  // void show(BuildContext context) {
  //   bool isCircle = true;
  //   AchievementView(
  //     context,
  //     title: "Text dicopy",
  //     alignment: Alignment.topCenter,
  //     color: MyColors.dnaGreen,
  //     subTitle: "Text berhasil dicopy untuk di share",
  //     isCircle: isCircle,
  //     listener: (status) {
  //       print(status);
  //     },
  //   )..show();
  // }

  Widget buildContainer() {

    return Consumer<HomeProvider>(
      builder: (context, prov, _) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: prov.bannerArray.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 400,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(prov.bannerArray[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            });
        // return ShaderMask(
        //   shaderCallback: (rect) {
        //     return LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [gradientStart, gradientMid, gradientEnd],
        //     ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height - 50));
        //   },
        //   blendMode: BlendMode.softLight,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         image: ExactAssetImage(item),
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // );
      },
    );

    // return ShaderMask(
    //   shaderCallback: (rect) {
    //     return LinearGradient(
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //       colors: [gradientStart, gradientMid, gradientEnd],
    //     ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height - 50));
    //   },
    //   blendMode: BlendMode.softLight,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: ExactAssetImage(item),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    // );
  }
}




