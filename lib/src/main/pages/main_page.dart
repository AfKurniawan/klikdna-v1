import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:new_klikdna/src/home/pages/home_page.dart';
import 'package:new_klikdna/src/home/providers/home_provider.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/main/providers/main_provider.dart';
import 'package:new_klikdna/src/report/providers/report_provider.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {

  int currentTab;
  Widget currenPage = new HomePage();
  String currentTitle;
  String token ;

  MainPage({Key key, this.currentTab}){
    currentTab = currentTab != null ? currentTab : 0 ;
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  @override
  void initState() {
    Provider.of<MainProvider>(context, listen: false).getPrefs();
    Provider.of<TokenProvider>(context, listen: false).getApiToken();
    Provider.of<HomeProvider>(context, listen: false).getHomeContents(context);
    Provider.of<LoginProvider>(context, listen: false).getMitraData();
    context.read<MainProvider>().selectTab(context, widget.currentTab);
    super.initState();

  }

  @override
  void didUpdateWidget(MainPage oldWidget){
    Provider.of<MainProvider>(context, listen: false).selectTab(context, widget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Consumer<MainProvider>(
        builder: (context, prov, child){
          return Scaffold(
            body: prov.currenPage,
            bottomNavigationBar: AnimatedContainer(
              duration: Duration(milliseconds: 10),
              child: BottomNavigationBar(
                  elevation: 20,
                  backgroundColor: Colors.white,
                  currentIndex: prov.currentTab,
                  selectedItemColor: MyColors.dnaGreen,
                  onTap: (index){
                    setState(() {
                      context.read<MainProvider>().selectTab(context, index);
                    });
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [

                    ///HOME PAGE
                    BottomNavigationBarItem(
                        activeIcon: Image.asset("assets/icons/home_icon.png",
                          width: 20,
                          color: MyColors.dnaGreen,
                        ),
                        icon: Image.asset("assets/icons/home_icon.png",
                          width: 20,
                          color: MyColors.grey,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text("Beranda"),
                        )
                    ),


                    /// PMR PAGE
                    BottomNavigationBarItem(
                        activeIcon: Image.asset("assets/icons/emr_icon.png",
                          width: 20,
                          color: MyColors.dnaGreen,
                        ),
                        icon: Image.asset("assets/icons/emr_icon.png",
                          width: 22,
                          color: MyColors.grey,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text("PMR"),
                        )
                    ),

                    ///  MITRA PAGE
                    BottomNavigationBarItem(
                        activeIcon: Image.asset("assets/icons/mitra_icon.png",
                          height: 22,
                          color: MyColors.dnaGreen,
                        ),
                        icon: Image.asset("assets/icons/mitra_icon.png",
                          width: 22,
                          color: MyColors.grey,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text("Mitra"),
                        )
                    ),

                    /// REPORT PAGE
                    BottomNavigationBarItem(
                        activeIcon: Image.asset("assets/icons/report_icon.png",
                          height: 22,
                          color: MyColors.dnaGreen,
                        ),
                        icon: Image.asset("assets/icons/report_icon.png",
                          width: 22,
                          color: MyColors.grey,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text("Report"),
                        )
                    ),


                    /// PROFILE PAGE
                    BottomNavigationBarItem(
                        activeIcon: Image.asset("assets/icons/profile_icon.png",
                          height: 22,
                          color: MyColors.dnaGreen,
                        ),
                        icon: Image.asset("assets/icons/profile_icon.png",
                          width: 22,
                          color: MyColors.grey,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text("Profil"),
                        )
                    ),
                  ]
              ),
            ),
          );
        },

      ),
    );
  }
}
