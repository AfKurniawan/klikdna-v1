
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/report/models/detail_report_model.dart';
import 'package:new_klikdna/src/report/pages/hasil_kamu_tab.dart';
import 'package:new_klikdna/src/report/pages/hasil_rekomendasi_tab.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';


class HasilReportPage extends StatefulWidget {
  final ReportDetail model;
  final Rekomendasi rekomendasi;

  HasilReportPage({Key key, this.model, this.rekomendasi}) : super(key: key);

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
    Provider.of<DetailReportProvider>(context, listen: false).calculateImageDimension(Provider.of<DetailReportProvider>(context, listen: false).listRecomendasi[0].gambarRekomendasi).then((value) => print("IMAGE SIZE $value --> ${Provider.of<DetailReportProvider>(context, listen: false).listRecomendasi[0].gambarRekomendasi}"));
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
            HasilRekomendasi(model: widget.rekomendasi),

            // listLinkedAccountPage(context, prov)
          ],
        ),
      ),
    );
  }

}





