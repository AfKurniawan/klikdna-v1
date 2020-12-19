import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                      Html(data: widget.model.deskripsiHasil),
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
                  child: Html(data: widget.model.deskripsi),
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



  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    final prov = Provider.of<DetailReportProvider>(context);

    return SingleChildScrollView(
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
                  itemCount: prov.listRecomendasi.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return RekomedasiItemWidget(model: prov.listRecomendasi[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class RekomedasiItemWidget extends StatefulWidget {

  final Rekomendasi model;
  final int pos ;

 RekomedasiItemWidget({Key key, this.model, this.pos}) : super (key: key);

  @override
  _RekomedasiItemWidgetState createState() => _RekomedasiItemWidgetState();
}

class _RekomedasiItemWidgetState extends State<RekomedasiItemWidget> {

  var document;
  String judul ;
  @override
  void initState() {
    document = parse(widget.model.judulRekomendasi);
    judul = parse(document.body.text).documentElement.text;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 10),
          child: Row(
            children: [
              Image.network(
                widget.model.ikonRekomendasi,
                height: 20,
                width: 20,
              ),
              SizedBox(width: 20),
              Flexible(child: Text(judul, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.dnaGrey),)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 18, right: 10, bottom: 16),
          width: width,
          child: widget.model.gambarRekomendasi == null ?
          Center(

          )
          :
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                //NOTE:  Jika gambar kurang dari 890 maka lebarnya dibagi 2, tinggi menyesuaikan (proporsional)
                child: CachedNetworkImage(
                  imageUrl: widget.model.gambarRekomendasi,
                  //width: width > 890 ? width / 2 : width,
                  fit: BoxFit.fitHeight,
                )),
          ),
        ),
      ],
    );
  }
}




class RekomendasiItem extends StatefulWidget {
  final Rekomendasi model;

  RekomendasiItem({Key key, this.model}) : super (key: key);


  @override
  _RekomendasiItemState createState() => _RekomendasiItemState();
}

class _RekomendasiItemState extends State<RekomendasiItem> {

  var document;
  String judul ;
  @override
  void initState() {
    document = parse(widget.model.judulRekomendasi);
    judul = parse(document.body.text).documentElement.text;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: MyColors.dnaGreen)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Center(
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(12.0),
              child: Image.network(
                widget.model.gambarRekomendasi,
                fit: BoxFit.fitHeight,
                height: 120,
                width: 120,
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(judul,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

