import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/food_brand_model.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/favourite_food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_brands_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/custom_appbar.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/filtered_makanan_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/filtered_minuman_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/filtered_restaurant_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/food_brand_makanan_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/food_brand_minuman_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/new_makanan_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/new_minuman_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/new_restaurant_list.dart';
import 'package:new_klikdna/src/report/providers/detail_report_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_and_icon_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:new_klikdna/widgets/loading_widget.dart';
import 'package:new_klikdna/widgets/outline_and_icon_button_widget.dart';
import 'package:provider/provider.dart';

class RestoranDetailPage extends StatefulWidget {

  int currentTab;
  int id;
  BrandDetail brand;
  RestoranDetailPage({Key key, this.currentTab, this.id, this.brand}) : super(key: key);

  @override
  _RestoranDetailPageState createState() => _RestoranDetailPageState();
}

class _RestoranDetailPageState extends State<RestoranDetailPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  TextEditingController searchController = new TextEditingController();

  int _selectedIndex;

  Future _futureMinuman;
  Future _futureMakanan;


  @override
  void initState() {
    _tabController = TabController(length: listTab.length, vsync: this);
    _scrollController = ScrollController();
    _selectedIndex = 0;
    print("ID TAB ${widget.id}");
    //_futureMakanan = Provider.of<FoodBrandsProvider>(context, listen: false).getRestoDetailzz(context, widget.id);
    //Provider.of<FoodBrandsProvider>(context, listen: false).getRestoDetailzz(context, widget.id);
    super.initState();
  }



  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }


  List<Widget> listTab = [
    Container(
        width: 100,
        child: new Tab(text: 'Makanan')),
    Container(
        width: 100,
        child: new Tab(text: 'Minuman'))
  ];

  @override
  Widget build(BuildContext context) {
    _tabController.animateTo(_selectedIndex);
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        height: 190,
        title: "Restoran",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Focus(
                onFocusChange: (isFocus) {
                  if (isFocus) {
                    Navigator.pushReplacementNamed(
                        context, "food_meter_search_page");
                  }
                },
                child: FormWidget(
                  readonly: true,
                  textEditingController: searchController,
                  hint: "Cari makanan, minuman atau restauran",
                  obscure: false,
                  labelText: "Cari makanan, minuman atau restauran",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineAndIconButtonWidget(
                      btnAction: () {},
                      height: 40,
                      outlineColor: MyColors.dnaGreen,
                      btnTextColor: MyColors.dnaGreen,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2.3,
                      myIcon: Icons.mic,
                      iconColor: MyColors.dnaGreen,
                      btnText: Text(
                        "Voice Search",
                        style: TextStyle(color: MyColors.dnaGreen),
                      )),
                  ButtonAndIconWidget(
                      btnAction: () {},
                      height: 40,
                      widht: MediaQuery
                          .of(context)
                          .size
                          .width / 2.3,
                      color: MyColors.dnaGreen,
                      myIcon: Image.asset("assets/icons/scan_icon.png"),
                      btnText: "Pindai"),
                ],
              ),
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScroller) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: Colors.white,
              brightness: Brightness.dark,
              expandedHeight: 0,
              bottom: TabBar(
                indicatorColor: MyColors.dnaGreen,
                labelColor: MyColors.dnaGreen,
                labelStyle: TextStyle(fontSize: 12),
                indicatorWeight: 2,
                unselectedLabelColor: Colors.grey[400],
                tabs: listTab,
                controller: _tabController,
                onTap: (tabIndex) {
                  setState(() {
                    _selectedIndex = tabIndex;
                    print("$tabIndex");
                  });
                },

              ),
            )
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Consumer<FoodBrandsProvider>(
                          builder: (context, prov, _){
                            return Expanded(
                              child: TabBarView(
                                children: [

                                  prov.isLoading == true ? LoadingWidget() : prov.makananList.length <= 0
                                      ? Container(
                                          height: MediaQuery.of(context).size.height,
                                          child: Center(child: Text("Belum ada product")))
                                      : FoodBrandMakananList(),
                                  prov.isLoading == true ? LoadingWidget() : prov.minumanList.length <= 0
                                      ? Container(
                                      height: MediaQuery.of(context).size.height,
                                      child: Center(child: Text("Belum ada product")))
                                      : FoodBrandMinumanList(),


                                  // FutureBuilder(
                                  //   future: _futureMakanan,
                                  //   builder: (context, snapshot) {
                                  //     if (snapshot.connectionState ==
                                  //         ConnectionState.waiting) {
                                  //       return LoadingWidget();
                                  //     } else if (snapshot.connectionState == ConnectionState.done) {
                                  //       return FoodBrandMakananList();
                                  //     } else {
                                  //       return Container();
                                  //     }
                                  //   },
                                  // ),
                                  // FutureBuilder(
                                  //   future: _futureMinuman,
                                  //   builder: (context, snapshot) {
                                  //     if (snapshot.connectionState ==
                                  //         ConnectionState.waiting) {
                                  //       return LoadingWidget();
                                  //     } else if (snapshot.connectionState ==
                                  //         ConnectionState.done) {
                                  //       return NewMinumanList();
                                  //     } else {
                                  //       return Container();
                                  //     }
                                  //   },
                                  // ),


                                ],
                                controller: _tabController,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
