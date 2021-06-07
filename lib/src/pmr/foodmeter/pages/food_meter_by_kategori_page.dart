import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/favourite_food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/custom_appbar.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/filtered_makanan_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/filtered_minuman_list.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/filtered_restaurant_list.dart';
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

class FoodMeterByKategoryPage extends StatefulWidget {

  int currentTab;
  FoodMeterByKategoryPage({Key key, this.currentTab}) : super(key: key);

  @override
  _FoodMeterByKategoryPageState createState() => _FoodMeterByKategoryPageState();
}

class _FoodMeterByKategoryPageState extends State<FoodMeterByKategoryPage> with SingleTickerProviderStateMixin{
  TabController _tabController;
  ScrollController _scrollController;
  TextEditingController searchController = new TextEditingController();

  int _selectedIndex ;
  Future _futureResto ;
  Future _futureMinuman;
  Future _futureMakanan;


  @override
  void initState() {
    _tabController = TabController(length: listTab.length, vsync: this);
    _scrollController = ScrollController();
    _selectedIndex = widget.currentTab;
    print("CURRENT TAB $_selectedIndex");
    getData(widget.currentTab);
    _futureResto = Provider.of<FavouriteFoodMeterProvider>(context, listen: false).getListRestaurant(context, '3/1/0/0');
    _futureMinuman = Provider.of<FavouriteFoodMeterProvider>(context, listen: false).getListMinuman(context, '2/1/0/0');
    _futureMakanan = Provider.of<FavouriteFoodMeterProvider>(context, listen: false).getListFood(context, AppConstants.LIST_FOOD_URL + '1/1/0/0');
    super.initState();
  }

  getData(int index){
    if(_selectedIndex == 0){
      Provider.of<FavouriteFoodMeterProvider>(context, listen: false).getListFood(context, AppConstants.LIST_FOOD_URL + '1/1/0/0');
    } else if(_selectedIndex == 1){
      Provider.of<FavouriteFoodMeterProvider>(context, listen: false).getListMinuman(context, '2/1/0/0');
    } else if(_selectedIndex == 2){
      Provider.of<FavouriteFoodMeterProvider>(context, listen: false).getListRestaurant(context, '3/1/0/0');
    } else {
      print("DO NOTHING");
    }
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
        child: new Tab(text: 'Minuman')),
    Container(
        width: 100,
        child: new Tab(text: 'Restaurant')),
  ];

  @override
  Widget build(BuildContext context) {
    _tabController.animateTo(_selectedIndex);
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: "Food Meter",
      height: 190,
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
                tabs: listTab,
                controller: _tabController,
                onTap: (tabIndex){
                  setState(() {
                    getData(tabIndex);
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
                        Expanded(
                          child: TabBarView(
                              children: [

                                FutureBuilder(
                                  future: _futureMakanan,
                                  builder: (context, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return LoadingWidget();
                                    } else if (snapshot.connectionState == ConnectionState.done){
                                      return isFiltered == true ? FilteredMakananList() : NewMakananList();
                                    } else {
                                      return Container();
                                    }

                                  },
                                ),
                                FutureBuilder(
                                  future: _futureMinuman,
                                  builder: (context, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return LoadingWidget();
                                    } else if (snapshot.connectionState == ConnectionState.done){
                                      return isFiltered == true ? FilteredMinumanList() : NewMinumanList();
                                    } else {
                                      return Container();
                                    }

                                  },
                                ),

                                FutureBuilder(
                                  future: _futureResto,
                                  builder: (context, snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return LoadingWidget();
                                    } else if (snapshot.connectionState == ConnectionState.done){
                                      return isFiltered == true ? FilteredRestaurantList() : NewRestaurantList();
                                    } else {
                                      return Container();
                                    }

                                  },
                                )

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showFilterBottomSheet(context);
        },
        elevation: 4,
        label: Text('Urutkan', style: TextStyle(color: Colors.black, fontFamily: "Roboto")),
        icon: Image.asset("assets/icons/sort_icon.png", height: 20),
        backgroundColor: Colors.white,
      ) ,
    );
  }

  void showFilterBottomSheet(context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter state) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Urutkan Berdasarkan: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: checkboxDataListTwo.map<Widget>(
                            (data) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CheckboxListTile(
                                  value: data.checked,
                                  title: Text(data.displayId),
                                  onChanged: (bool val) {
                                    state(() {
                                      onCheckedValue(data.id, data.checked);
                                      print("CHECKED ${data.id}");
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool isFiltered = false;
  onCheckedValue(String text, bool checked) async {
    if (text == '1') {
      setState(() {
       isFiltered = false ;
       print("Filter status = $isFiltered");
      });
    }  else if (text == "2") {
      setState(() {
        isFiltered = true ;
        print("Filter status = $isFiltered");
      });
    } else {
      print("do nothing");
    }
  }



  List<CheckBoxData> checkboxDataListTwo = [
    new CheckBoxData(
      id: '1',
      displayId: 'Alphabet A-Z',
      checked: false,
    ),
    new CheckBoxData(
        id: '2',
        displayId: 'Alphabet Z-A',
        checked: false
    ),
  ];

  clearSelectedFilter() {
    checkboxDataListTwo.clear();
    checkboxDataListTwo.clear();
  }

}

class CheckBoxData {
  String id;
  String displayId;
  bool checked;

  CheckBoxData({
    this.id,
    this.displayId,
    this.checked,
  });

  factory CheckBoxData.fromJson(Map<String, dynamic> json) => CheckBoxData(
    id: json["id"] == null ? null : json["id"],
    displayId: json["displayId"] == null ? null : json["displayId"],
    checked: json["checked"] == null ? null : json["checked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "displayId": displayId == null ? null : displayId,
    "checked": checked == null ? null : checked,
  };
}
