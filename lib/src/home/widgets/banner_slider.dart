import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/home/models/home_model.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {

  final List<String> imgAsset = [
    "assets/images/slider_1.png",
    "assets/images/slider_2.png",
    "assets/images/slider_3.png"
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final porv = Provider.of<HomeProvider>(context, listen: false);
    final List<Widget> imageSliders = imgAsset.map((item) => buildContainer(item, size)).toList();

    List<Widget> getBanner = porv.bannerArray.map((i) => buildContainer(porv.bannerArray[_current].imageUrl, size)).toList();

    return Stack(
        children: [
      Container(

        child: CarouselSlider(
          items: getBanner,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              height: 220,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Positioned(top: 185, right: 0, left: 0, child: buildIndicatorSlider()),
    ]);
  }

  Widget buildIndicatorSlider() {
    return Consumer<HomeProvider>(
      builder: (context, prov, _){
        return  Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: imgAsset.map((url) {
                    int index = imgAsset.indexOf(url);
                    if (_current == index) {
                      return Container(
                        width: 18.0,
                        height: 8.0,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    } else {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: MyColors.grey),
                      );
                    }
                  }).toList(),
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "semua_promo_page");
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      //color: Color(0xff433F3F),
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          "Lihat Semua Promo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  Widget buildContainer(String item, Size size) {

    Color gradientStart = Colors.transparent;
    Color gradientMid = Colors.black12;
    Color gradientEnd = MyColors.overlaySlider;

    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gradientStart, gradientMid, gradientEnd],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height - 60));
      },
      blendMode: BlendMode.softLight,
      child: Container(
          child: CachedNetworkImage(imageUrl: item, fit: BoxFit.fill))
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