import 'package:flutter/material.dart';
import 'package:new_klikdna/src/pmr/foodmeter/pages/food_meter_page.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/favourite_food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/custom_appbar.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/makanan_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/minuman_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/restaurant_list.dart';
import 'package:new_klikdna/src/profile/pages/detail_profile_page.dart';
import 'package:new_klikdna/src/profile/pages/main_profile_page.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_and_icon_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:new_klikdna/widgets/outline_and_icon_button_widget.dart';
import 'package:provider/provider.dart';

class FoodMeterByKategoryPage extends StatefulWidget {

  @override
  _FoodMeterByKategoryPageState createState() => _FoodMeterByKategoryPageState();
}

class _FoodMeterByKategoryPageState extends State<FoodMeterByKategoryPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  ScrollController _scrollController;
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    Provider.of<FavouriteFoodMeterProvider>(context, listen: false).getListFood(context);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> list = [
    Container(
        width: 100,
        child: new Tab(text: 'Makanan')),
    Container(
        width: 100,
        child: new Tab(text: 'Minuman')),
    Container(
        width: 100,
        child: new Tab(text: 'Restaurant')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
      height: 230,
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
                    width: MediaQuery.of(context).size.width / 2.3,
                    myIcon: Icons.mic,
                    iconColor: MyColors.dnaGreen,
                    btnText: Text(
                      "Voice Search",
                      style: TextStyle(color: MyColors.dnaGreen),
                    )),
                ButtonAndIconWidget(
                    btnAction: () {},
                    height: 40,
                    widht: MediaQuery.of(context).size.width / 2.3,
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
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScroller){
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: Colors.white, brightness: Brightness.dark,
              expandedHeight: 0,
              bottom: TabBar(
                indicatorColor: MyColors.dnaGreen,
                labelColor: MyColors.dnaGreen,
                labelStyle: TextStyle(fontSize: 12),
                indicatorWeight: 2,
                unselectedLabelColor: Colors.grey[400],
                tabs: list,
                controller: _tabController,
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
                        Expanded(
                          child: TabBarView(
                              children: [
                                MakananList(),
                                MakananList(),
                                MakananList(),
                          ],
                            controller: _tabController,
                          ),
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
