import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_klikdna/src/dummy/post_it_now_models.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:provider/provider.dart';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final porv = Provider.of<HomeProvider>(context, listen: false);

    List<Widget> getBanner = porv.bannerArray.map((i) => buildContainer(porv.bannerArray[_current].imageUrl, porv.bannerArray[_current].data.title, porv.bannerArray[_current].data.text, size)).toList();
    return Stack(
        children: [
      Container(
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(
                context, "detail_promo_page",
                arguments: DummyModel(
                    "${porv.bannerArray[_current].data.title}",
                    "${porv.bannerArray[_current].data.text}",
                    "${porv.bannerArray[_current].imageUrl}",
                    porv.bannerArray.length
                ));
          },
          child: Container(
            child: CarouselSlider(
              items: getBanner,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  height: 180,
                  viewportFraction: 2,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ),
        ),
      ),
      Positioned(bottom: 2, right: 0, left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildIndicatorSlider(),
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 2),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "semua_promo_page");
                  },
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      //color: Color(0xff433F3F),
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15),
                        child: Text(
                          "Lihat Semua Promo",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),

    ]);
  }

  Widget buildIndicatorSlider() {
    return Consumer<HomeProvider>(
      builder: (context, prov, _){
        return  Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: prov.bannerArray.map((url) {
                  int index = prov.bannerArray.indexOf(url);
                  if (_current == index) {
                    return Container(
                      width: 16.0,
                      height: 6.0,
                      margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  } else {
                    return Container(
                      width: 6.0,
                      height: 6.0,
                      margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: MyColors.grey),
                    );
                  }
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget buildContainer(String item, String title, String text, Size size) {

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
      child: CachedNetworkImage(
          imageUrl: item,
          width: MediaQuery.of(context).size.width,
          height: 0,
          fit: BoxFit.fill)
      // child: Image.network(
      //   item,
      //   fit: BoxFit.cover,
      //   width: 400,
      // ),
    );
  }
}