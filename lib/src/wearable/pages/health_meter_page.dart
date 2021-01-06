
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/styles/my_theme.dart';
import 'package:new_klikdna/styles/extentions.dart';

class HealthMeterPage extends StatefulWidget {

  @override
  _HealthMeterPageState createState() => _HealthMeterPageState();
}

class _HealthMeterPageState extends State<HealthMeterPage> {


  ScrollController controller;
  final _all = <HealthDataPoint>[];
  final _saved = new Set<HealthDataPoint>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<HealthDataPoint> _healthDataList = [];

  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime(2020, 01, 01);

  HealthFactory health = HealthFactory();

  List<HealthDataType> types = [
    HealthDataType.HEART_RATE,
  ];

  List<HealthDataPoint> healthData;

  final items = List<HealthDataPoint>();

  int present = 0;
  int perPage = 5;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchData();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  loadMore() {
    setState(() {
      if((present + perPage )> _all.length) {
        items.addAll(
            _healthDataList.getRange(present, _all.length));
      } else {
        items.addAll(
            _all.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      loadMore();
    }
  }


  fetchData() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, onResponse);
  }



  Future<void> onResponse() async {
    healthData = await health.getHealthDataFromTypes(startDate, endDate, types);
    setState(() {
      controller = new ScrollController()..addListener(_scrollListener);
      isLoading = false;
      _all.addAll(healthData);
      _all.sort((b, a) => a.dateFrom.compareTo(b.dateFrom));
      _healthDataList = HealthFactory.removeDuplicates(_all);
      if((present + perPage )> _all.length) {
        items.addAll(
            _healthDataList.getRange(present, _all.length));
      } else {
        items.addAll(
            _all.getRange(present, present + perPage));
      }
      present = present + perPage;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: new Stack(
        children: <Widget>[
          _header(),
          _buildListView(),
        ],
      ),
    );
  }
  Widget _header() {
    return Container(
      height: 100,
      width: MyTheme.fullWidth(context) / 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [MyColors.dnaGreen, Colors.lightBlue],
        stops: [0.1, 1],
      ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 6,
            color: Colors.grey.withOpacity(.6),
          )
        ],
      ),
      child: ClipRRect(
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 5,
                right: -10,
                child: Transform.rotate(
                    angle: 75,
                    child: Icon(FontAwesomeIcons.heartbeat, size: 120, color: Colors.white.withOpacity(.23))),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white54),
                        onPressed: (){
                         Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                            "HEARTH RATE",
                            style: TextStyle(color: Colors.white54, fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: -2)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: new ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          controller: controller,
          itemCount: (present <= _healthDataList.length) ? items.length + 1 : items.length,
          itemBuilder: (context, i) {
            if (i == items.length) {
              return Container(
                height: MediaQuery.of(context).size.height / 10,
                child: Center(child: CupertinoActivityIndicator()));
            } else {
              return _buildItem(_all[i]);
            }
          }),
    );
  }

  Widget _buildItem(HealthDataPoint item) {
    final alreadySaved = _saved.contains(item);
    String unit = item.unitString;
    String dateFrom = DateFormat("dd MMM yy HH:mm:ss").format(DateTime.parse(item.dateFrom.toString()).toLocal());
    String dateTo = DateFormat("dd MMM yy HH:mm:ss").format(DateTime.parse(item.dateTo.toString()).toLocal());

    return Container(
      height: 110,
      width: MyTheme.fullWidth(context) / 1,
      margin: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 6,
            color: Colors.grey.withOpacity(.4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -5,
                left: -20,
                child: Transform.rotate(
                    angle: -6,
                    child: Icon(FontAwesomeIcons.heartbeat, size: 130, color: Colors.white.withOpacity(.23))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            "From: ",
                            style: TextStyle(color: Colors.white, fontSize: 13)
                        ),
                        Text(
                            dateFrom,
                            style: TextStyle(color: Colors.white, fontSize: 13)
                        ),
                        SizedBox(width: 5),
                        Text(
                            "To: ",
                            style: TextStyle(color: Colors.white, fontSize: 13)
                        ),
                        Text(
                            dateTo,
                            style: TextStyle(color: Colors.white, fontSize: 13)
                        ),
                      ],
                    ),
                    Divider(color: Colors.white),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                              "${item.value}",
                              style: TextStyle(color: Colors.white70, fontSize: 55, fontWeight: FontWeight.w900, letterSpacing: -2)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, left: 2),
                          child: Text(
                              unit == "METERS" ? "METER"
                                  : unit == "BEATS_PER_MINUTE" ? "BPM"
                                  : unit == "MILLIGRAM_PER_DECILITER" ? "mg/dL"
                                  : unit == "COUNT" ? "STEPS" : unit,
                              style: TextStyle(color: Colors.white, fontSize: 13)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ).ripple(() {
        setState(() {
          if (alreadySaved) {
            _saved.remove(item);
          } else {
            _saved.add(item);
          }
        });
      }, borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
