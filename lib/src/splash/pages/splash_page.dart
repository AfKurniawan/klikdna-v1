import 'package:flutter/material.dart';
import 'package:new_klikdna/src/splash/providers/splash_provider.dart';
import 'package:new_klikdna/src/token/providers/cms_token_provider.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    context.read<SplashProvider>().getPrefs(context);
    Provider.of<TokenProvider>(context, listen: false).getApiToken();
    Provider.of<CmsTokenProvider>(context, listen: false).getCmsToken(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.width < 600 ? size.height /1.5 : size.height /2.8,
                margin: EdgeInsets.only(bottom: 50, top: 50),
                child: Center(
                  child: Image.asset(
                      'assets/images/logo.png', height: 150),
                ),
              ),
              Text("Terdaftar dan diawasi oleh", style: TextStyle(fontSize: 12, color: Color(0xff8D8D8D))),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/images/logo_ap2li.png', height: 60),
                    SizedBox(width: 20),
                    Image.asset(
                        'assets/images/logo_kemendag.png', height: 60),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
