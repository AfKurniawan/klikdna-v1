

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/src/pmr/foodmeter/models/pagination_model_data.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/loading_widget.dart';
import 'package:provider/provider.dart';



ModelData modelDataFromJson(String str) => ModelData.fromJson(json.decode(str));

String modelDataToJson(ModelData data) => json.encode(data.toJson());


class NewMinumanList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewMinumanListState();
  }
}

class NewMinumanListState extends State<NewMinumanList> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Paginator.listView(
        key: paginatorGlobalKey,
        pageLoadFuture: sendPagesDataRequest,
        pageItemsGetter: listItemsGetterPages,
        listItemBuilder: listItemBuilder,
        loadingWidgetBuilder: loadingWidgetMaker,
        errorWidgetBuilder: errorWidgetMaker,
        emptyListWidgetBuilder: emptyListWidgetMaker,
        totalItemsGetter: totalPagesGetter,
        pageErrorChecker: pageErrorChecker,
        scrollPhysics: BouncingScrollPhysics(),
      ),

    );
  }

  Future<ModelData> sendPagesDataRequest(int page) async {
    print('page ${page}');
    try {
      String url = AppConstants.LIST_FOOD_URL + '2/0/0/0?page=$page';
      print("$url");
      http.Response response = await http.get(url);
      ModelData md = modelDataFromJson(response.body);
      return md;
    } catch (e) {
      if (e is IOException) {
        /*return CountriesData.withError(
            'Please check your internet connection.');*/
      } else {
        print(e.toString());
        /*return CountriesData.withError('Something went wrong.');*/
      }
    }
  }

  List<dynamic> listItemsGetterPages(ModelData pagesData) {
    List<Datum> list = [];
    pagesData.data.data.data.forEach((value) {
      list.add(value);
    });
    return list;
  }

  Widget listItemBuilder(dynamic item, int index) {
    List splittedSize = item.productSize.toString().split(".");

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 10, top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 5,
              color: Colors.grey[500].withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: MyColors.drinkIconColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Center(
                            child: Image.asset(
                                "assets/icons/drinks_icon.png",
                                height: 32)),
                      )),
                  SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          child: Text("${item.productName}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14
                              )),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 110,
                          child: Text("1 Porsi ${splittedSize[0]} ${item.productUom}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12
                              )),
                        ),
                      ]),

                  SizedBox(width: 20),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("new_detail_food_meter_page", arguments: item.id);
                      //Provider.of<FoodMeterProvider>(context, listen: false).getSpecificFoodMeter(context, item.id);
                    },
                    splashColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: MyColors.dnaGreen
                      ),
                      child: Center(
                        child: Text(
                          "Details",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: LoadingWidget(),
    );
  }

  Widget errorWidgetMaker(ModelData countriesData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("error"),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text('Retry'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(ModelData countriesData) {
    return Center(
      child: Text('No countries in the list'),
    );
  }

  int totalPagesGetter(ModelData pagesData) {
    return pagesData.data.data.total;
  }

  bool pageErrorChecker(ModelData pagesData) {
    //return countriesData.statusCode != 200;
    return false;
  }
}

// class CountriesData {
//   List<dynamic> countries;
//   int statusCode;
//   String errorMessage;
//   int total;
//   int nItems;
//
//   CountriesData.fromResponse(http.Response response) {
//     this.statusCode = response.statusCode;
//     List jsonData = json.decode(response.body);
//     countries = jsonData[1];
//     total = jsonData[0]['total'];
//     nItems = countries.length;
//   }
//
//   CountriesData.withError(String errorMessage) {
//     this.errorMessage = errorMessage;
//   }
//   }