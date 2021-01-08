import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/dummy/widgets/Indicator.dart';
import 'package:new_klikdna/src/login/providers/account_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class DummyChartPage extends StatefulWidget {
  @override
  _DummyChartPageState createState() => _DummyChartPageState();
}

class _DummyChartPageState extends State<DummyChartPage> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 285,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: MyColors.dnaGreen,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 18, top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("10 November 2020",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300)),
                    Text(
                      "Good Day Doan!",
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ),

            SingleChildScrollView(
              padding: EdgeInsets.only(top: 120),
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          buildStepCard(),
                          SizedBox(height: 20),
                          buildHarthCard(),
                          SizedBox(height: 20),
                          buildCyclingCard()
                        ],
                      ),

                      Column(
                        children: <Widget>[
                          buildSleepCard(),
                          SizedBox(height: 20),
                          buildCaloriesCard(),
                          SizedBox(height: 20),
                          buildSwimmingCard()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSleepCard(){
    return Container(
      height: 110,
      width: 152,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 4),
            blurRadius: 10,
            color: MyColors.grey.withOpacity(0.62),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Image.asset("assets/icons/sleep_icon.png"),
                SizedBox(width: 10),
                Text("Sleep"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("300",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
                Text("Hours", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),


        ],
      ),
    );
  }

  Widget buildStepCard() {
    return Container(
      height: 200,
      width: 152,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 4),
            blurRadius: 10,
            color: MyColors.grey.withOpacity(0.62),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Image.asset("assets/icons/step_icon.png"),
                SizedBox(width: 10),
                Text("Steps"),
              ],
            ),
          ),
          PieChart(
            PieChartData(
                pieTouchData: PieTouchData(),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections()),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text("300",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400))),
              Center(
                  child: Text("Steps", style: TextStyle(color: Colors.grey))),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCaloriesCard() {
    return Container(
      height: 200,
      width: 152,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 4),
            blurRadius: 10,
            color: MyColors.grey.withOpacity(0.62),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Image.asset("assets/icons/calories_icon.png"),
                SizedBox(width: 10),
                Text("Calories"),
              ],
            ),
          ),
          PieChart(
            PieChartData(
                pieTouchData: PieTouchData(),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingCalories()),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text("362",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400))),
              Center(
                  child: Text("Kkal", style: TextStyle(color: Colors.grey))),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHarthCard(){
    return Container(
      height: 200,
      width: 152,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 4),
            blurRadius: 10,
            color: MyColors.grey.withOpacity(0.62),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Image.asset("assets/icons/love_icon.png"),
                SizedBox(width: 10),
                Text("Heart Rate"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset("assets/icons/heart_rate_icon.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("75",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
                Text("BPM", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),


        ],
      ),
    );
  }

  Widget buildCyclingCard(){
    return Container(
      height: 110,
      width: 152,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 4),
            blurRadius: 10,
            color: MyColors.grey.withOpacity(0.62),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Image.asset("assets/icons/bicycle_icon.png"),
                SizedBox(width: 10),
                Text("Cycling"),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1.15",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
                Text("Km", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),


        ],
      ),
    );
  }

  Widget buildSwimmingCard(){
    return Container(
      height: 200,
      width: 152,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 4),
            blurRadius: 10,
            color: MyColors.grey.withOpacity(0.62),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Image.asset("assets/icons/swimming_icon.png"),
                SizedBox(width: 10),
                Text("Swimming"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset("assets/icons/water_swim_icon.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("75",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400)),
                Text("Metres", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),


        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffFF8552),
            value: 900,
            title: '',
            radius: 10,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffFFEDE5),
            value: 100,
            title: '',
            radius: 8,
          );

        default:
          return null;
      }
    });
  }
  List<PieChartSectionData> showingCalories() {
    return List.generate(2, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffFF8552),
            value: 364,
            title: '',
            radius: 10,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffFFEDE5),
            value: 200,
            title: '',
            radius: 8,
          );

        default:
          return null;
      }
    });
  }
}
