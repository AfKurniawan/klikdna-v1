import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/src/home/models/home_model.dart';
import 'package:new_klikdna/src/home/providers/artikel_provider.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/home/widgets/banner_slider.dart';
import 'package:new_klikdna/src/home/widgets/dashboard_slider.dart';
import 'package:new_klikdna/src/home/widgets/dummy_dashboard_slider.dart';
import 'package:new_klikdna/src/home/widgets/event_slider.dart';
import 'package:new_klikdna/src/home/widgets/event_widget.dart';
import 'package:new_klikdna/src/home/widgets/pin_widget.dart';
import 'package:new_klikdna/src/home/widgets/podcast_slider.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class HomePage extends StatefulWidget {
  DummyModel model;
  HomePage({Key key, this.model}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken();
    Provider.of<HomeProvider>(context, listen: false).getHomeContents(context);
    super.initState();
  }

  String eventDesc2 =
      "Kabar gembira! @klikdna kembali lagi nih dengan “Health Seminar Series” yang kali ini bersama dr. Bona, Sp. KFR\n\nMinggu, 20 Desember 2020\n\nSTAY TUNED TERUS UNTUK INFO LENGKAPNYA 🔥🔥\n\n\n#KlikDNA\n#Bioinformatics\n#Biomolecular\n#CancerMarker\n#Genetics\n#Genomics\n#DNAku\n#DNAsional\n#UntukIndonesia\n#MandiriUntukNegeri\n#IamKlikDNA\n#KlikDNAHealthSeriesSeminar";
  String eventDesc1 =
      "Kenali Potensi Olahraga melalui Profil Genetik\n\nTahukah kamu? Setiap orang memiliki potensi olahraga yang berbeda berdasarkan profil genetik masing-masing.\nIngin tahu aktivitas olahraga apa yang tepat untuk daya tahan dan kesehatan tubuhmu?\nIkuti Health Seminar Series KlikDNA yang akan diadakan pada:\n\n🗓️ Minggu, 20 Desember 2020\n\n⏰ 14.00-15.30 WIB\n\nSilahkan mendaftar melalui link berikut:\nbit.ly/KlikDNASportgenomik20";

  String eventTitle1 = "Kenali Potensi Olahraga melalui Profil Genetik";
  String eventTitle2 = "SAVE THE DATE!";

  String pinTitle1 = "Cara Mendeteksi Kanker Payudara Sedari Dini";
  String pinDesc1 =
      "#octoberbreastcancerawareness\n\n\n1. SADARI\nPemeriksaan ini dilakukan agar semua perubahan yang mengarah ke kondisi serius bisa segera ditangani. Waktu terbaik untuk melakukan SADARI adalah beberapa hari setelah menstruasi kamu berakhir.\n\n2. SADANIS\nPemeriksaan ini diperlukan untuk menentukan apakah benjolan dan penyebab perubahan merupakan tanda atau gejala awal dari kanker payudara. Contohnya seperti pemeriksaan fisik oleh dokter, mamografi, MRI, USG, atau biopsi.\n\n3. MAMOGRAFI\nIni merupakan salah satu pemeriksaan penunjang yang dilakukan untuk memeriksa dan mendeteksi bentuk kelainan pada payudara. Jika kamu wanita berusia 40 tahun keatas atau memiliki risiko genetik kanker payudara disarankan melakukan mamografi secara berkala.\n“Cancer can be prevented”\n“Early detection saves lives” 🎀\n\n#KlikDNAPeduliKankerPayudara\n#KlikDNA\n#Bioinformatics\n#Biomolecular\n#CancerMarker\n#Genetics\n#Genomics\n#DNAku\n#DNAsional\n#UntukIndonesia\n#MandiriUntukNegeri\n#IamKlikDNA\n#BreastCancerAwarenessMonth\n#BulanKesadaranKankerPayudara\n#KankerPayudara\n#BreastCancerAwareness\n#EarlyDetectionSavesLives";

  String pinTitle2 = "Rosalind Franklin";
  String pinDesc2 =
      "Rosalind Franklin, seorang ilmuan perempuan asal Inggris ini adalah ‘Penemu’ struktur DNA lho.\nPenelitian yang dilakukannya memiliki kontribusi penting dalam struktur molekular dengan penggambaran DNA dalam bentuk double helix.\n\n#KlikDNA\n#Bioinformatics\n#Biomolecular\n#CancerMarker\n#Genetics\n#Genomics\n#DNAku\n#DNAsional\n#UntukIndonesia\n#MandiriUntukNegeri\n#IamKlikDNA\n#RosalindFranklin\n#NobelPrize\n#DNA\n#DNAHelix";

  String pinTitle3 =
      "Apa yang akan terjadi jika tubuh kamu terhidrasi dengan baik?";
  String pinDesc3 =
      "\n- Cairan tubuhmu menjadi seimbang\n- Energi dan fungsi otakmu akan meningkat\n- Fungsi ususmu terjaga dan terhindar dari sembelit\n- Laju metabolisme mu meningkat\n- Risiko terkena batu ginjal akan berkurang\n\nYuk cek seberapa terhidrasi kah kamu\n🙌🏻\n\n#KlikDNA\n#Bioinformatics\n#Biomolecular\n#CancerMarker\n#Genetics\n#Genomics\n#DNAku\n#DNAsional\n#UntukIndonesia\n#MandiriUntukNegeri\n#IamKlikDNA\n#AirPutih\n#HidrasiTubuh\n#HidrasiTubuhmu\n#HidrasiTubuhLebihBaik";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var mediaquery = MediaQuery.of(context);
    Provider.of<ArtikelProvider>(context, listen: false)
        .getArtikel(context, context.watch<TokenProvider>().accessToken);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        //appBar:  myApbar(context),
        body: SingleChildScrollView(
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
                              Text("Post it now",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Sanomat Grab Web',
                                    color: Colors.black,
                                  )),
                              GestureDetector(
                                child: Text("Lihat Semua",
                                    style: TextStyle(
                                        color: MyColors.dnaGreen,
                                        fontSize: 14)),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "post_it_now_page");
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        PinWidget(),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
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
                                    color: Colors.black,
                                  )),
                              GestureDetector(
                                child: Text("Lihat Semua",
                                    style: TextStyle(
                                        color: MyColors.dnaGreen, fontSize: 14)),
                                onTap: () {
                                  print("LIHAT SEMUA CLICKED");
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        EventWidget(),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
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
                          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
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
                              GestureDetector(
                                child: Text("Lihat Semua",
                                    style: TextStyle(
                                        color: MyColors.dnaGreen, fontSize: 14)),
                                onTap: () {
                                  print("LIHAT SEMUA CLICKED");
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              PodcastSlider(
                                imgSrc: "assets/images/spotify_logo.png",
                                title: "",
                                width: 130,
                                height: 130,
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                desc: "",
                                press: () {
                                  launchSpotify();
                                },
                              ),
                              PodcastSlider(
                                imgSrc: "assets/images/google_podcast_logo.png",
                                title: "",
                                width: 130,
                                height: 130,
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                desc: "",
                                press: () {
                                  launchGooglePodcast();
                                },
                              ),
                              PodcastSlider(
                                imgSrc: "assets/images/apple_podcast_logo.png",
                                title: "",
                                width: 130,
                                height: 130,
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                desc: "",
                                press: () {
                                  launchApplePodcast();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10)
            ],
          ),
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
    Color gradientStart = Colors.transparent;
    Color gradientMid = Colors.black12;
    Color gradientEnd = MyColors.overlaySlider;

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




