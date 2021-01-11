
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';


class HasilReportPage extends StatefulWidget {
  final ReportDetail model;

  HasilReportPage({Key key, this.model}) : super(key: key);

  _HasilReportPageState createState() => _HasilReportPageState();
}

class _HasilReportPageState extends State<HasilReportPage>
    with SingleTickerProviderStateMixin {
  bool isMyProfile = false;
  int pageIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    Provider.of<DetailReportProvider>(context, listen: false).getRecomendasi(widget.model.namaModul);
    super.initState();
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color left = Colors.black;
  Color right = Colors.white;

  SliverAppBar getAppbar() {
    return SliverAppBar(
      forceElevated: false,
      expandedHeight: 170,
      elevation: 0,
      stretch: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      actions: <Widget>[],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground
        ],
        background: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SizedBox(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                height: 30,
                color: Colors.white,
              ),
            ),
            // Container(height: 50, color: Colors.black),

            /// Banner image
            Container(
              decoration: BoxDecoration(color: MyColors.dnaGreen),
            ),

            /// User avatar, message icon, profile edit and follow/following button
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    padding: EdgeInsets.symmetric(horizontal: 20),

                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          widget.model.gambarJudul,
                          width: 80,
                          fit: BoxFit.cover,
                          height: 80,
                          // height: 150,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.model.namaModul,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TabController _tabController;

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "${widget.model.namaModul}",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: MyColors.dnaGreen,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, "detail_report_page");
              Navigator.of(context).pop();
            }),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            getAppbar(),
            SliverList(
              delegate: SliverChildListDelegate([
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 4),
                            blurRadius: 10,
                            color: Color(0xFFB0CCE1).withOpacity(0.62),
                          ),
                        ],
                      ),
                      height: 50,
                      child: TabBar(
                        unselectedLabelColor: MyColors.dnaGrey,
                        labelColor: Colors.white,
                        unselectedLabelStyle: TextStyle(color: Colors.blue),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.dnaGreen),
                        controller: _tabController,
                        tabs: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Hasil Kamu"),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Rekomendasi"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            HasilKamu(model: widget.model),
            HasilRekomendasi(),
            // listLinkedAccountPage(context, prov)
          ],
        ),
      ),
    );
  }

}

class HasilKamu extends StatefulWidget {
  final ReportDetail model;

  HasilKamu({Key key, this.model}) : super(key: key);
  @override
  _HasilKamuState createState() => _HasilKamuState();
}

class _HasilKamuState extends State<HasilKamu> {

  @override
  Widget build(BuildContext context) {
    var document;
    String text;
    document =
        parse(widget.model.deskripsi);
    text = parse(document.body.text)
        .documentElement
        .text;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text("Hasil Genetik Kamu",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColors.dnaGrey)),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 4),
                      blurRadius: 10,
                      color: Color(0xFFB0CCE1).withOpacity(0.62),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Berikut ini merupakan hasil tes kamu:",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 20),
                      Text("$text"),
                      //Text(widget.model.deskripsiHasil),
                      SizedBox(height: 20),
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: widget.model.gambarHasil,
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 4),
                      blurRadius: 10,
                      color: Color(0xFFB0CCE1).withOpacity(0.62),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("$text"),
                ),
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}

class HasilRekomendasi extends StatefulWidget {
  @override
  _HasilRekomendasiState createState() => _HasilRekomendasiState();
}

class _HasilRekomendasiState extends State<HasilRekomendasi> {


 double imgWidth;

  @override
  void setState(fn) {

    if (mounted) super.setState(fn);
  }





  @override
  Widget build(BuildContext context) {
    return Consumer<DetailReportProvider>(
      builder: (context, prov, _){
        return prov.lr.length == 0 || prov.kosong == true ?
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tidak ada data"),
                ],
              )
          ),
        )
        : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 20, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Rekomendasi Untuk Kamu",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyColors.dnaGrey)),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: prov.lr.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var document;
                        String judul ;
                        document = parse(prov.lr[index].judulRekomendasi);
                        judul = parse(document.body.text).documentElement.text;
                        String gambar = "${prov.lr[index].gambarRekomendasi}";
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  prov.lr[index].ikonRekomendasi == "" || prov.lr[index].ikonRekomendasi == null ?
                                  Container()
                                      : Image.network(
                                    "${prov.lr[index].ikonRekomendasi}",
                                    height: 25,
                                    width: 25,
                                  ),
                                  SizedBox(width: 20),
                                  Flexible(
                                      child: Text("$judul",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: MyColors.dnaGrey)
                                      )
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            gambar == "" || gambar == null ?
                            Center()
                                : Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20),
                              child: prov.lr[index].gambarRekomendasi == null ?
                              Container()
                                  : Container(
                               // color: Colors.blueGrey,
                                    child: prov.imgWidth > 600 ?
                                    Container(
                                      width: 512,
                                      margin: EdgeInsets.only(left: 40, right: 20),
                                      child: CachedNetworkImage(
                                              imageUrl: "${prov.lr[index].gambarRekomendasi}",
                                              fit: BoxFit.fitHeight),
                                    ) : Container(
                                      margin: EdgeInsets.only(left: 40, right: 20),
                                      child: CachedNetworkImage(
                                            imageUrl: "${prov.lr[index].gambarRekomendasi}",
                                            fit: BoxFit.fitWidth),
                                    )
                                  ),
                            ),
                          ],
                        );
                      }),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}

