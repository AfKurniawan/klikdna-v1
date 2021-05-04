import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/pmr/foodmeter/providers/food_meter_provider.dart';
import 'package:new_klikdna/src/pmr/foodmeter/widgets/food_meter_search_item.dart';
import 'package:new_klikdna/src/report/widgets/button_icon_widget.dart';
import 'package:new_klikdna/src/token/providers/token_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_and_icon_widget.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/custom_shadow_card_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:new_klikdna/widgets/outline_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FoodMeterSearchPage extends StatefulWidget {
  @override
  _FoodMeterSearchPageState createState() => _FoodMeterSearchPageState();
}

class _FoodMeterSearchPageState extends State<FoodMeterSearchPage> {

  /// SPEECH
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = 'id-ID';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  bool startListen = false ;



  bool visible = true;
  void toggle() {
    setState(() {
      visible = !visible;
    });
  }

  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    _hasSpeech ? null : initSpeechState();
    Provider.of<TokenProvider>(context, listen: false).getApiToken();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void startListening() {
    searchController.text = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 5),
        pauseFor: Duration(seconds: 5),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    print('Result listener $resultListened');
    setState(() {
      searchController.text = '${result.recognizedWords}';
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FoodMeterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColors.iconArrowColor,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Food Meter",
          style: TextStyle(
            fontFamily: "Roboto",
            color: MyColors.blackPrimary,
              fontWeight: FontWeight.w700,
            fontSize: 16
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset("assets/images/logo.png", width: 19),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height /1.1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: FormWidget(
                  readonly: false,
                  autofocus: true,
                  textEditingController: searchController,
                  onsubmit: (value){
                    prov.getFoodsData(context, searchController.text);
                  },
                  hint: "Cari makanan, minuman atau restauran",
                  obscure: false,
                  labelText: "Cari makanan, minuman atau restauran",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlineButtonWidget(
                        // btnAction: (){
                        //   Navigator.pushNamed(context, "dummy_tts_page");
                        // },
                      btnAction: (){

                        !_hasSpeech || speech.isListening
                            ? null
                            : startListening();

                        print("$startListen");
                      },
                        height: 40,
                        outlineColor: MyColors.dnaGreen,
                        btnTextColor: MyColors.dnaGreen,
                        width: MediaQuery.of(context).size.width / 2.3,
                        myIcon: Icons.mic,
                        iconColor: MyColors.dnaGreen,
                        btnText: Text(
                          "Voice Search",
                          style: TextStyle(
                            color: MyColors.dnaGreen
                          ),
                        )),
                    ButtonAndIconWidget(
                        btnAction: (){
                          Navigator.pushNamed(context, "dummy_tts_page");
                        },
                        height: 40,
                        widht: MediaQuery.of(context).size.width / 2.3,
                        color: MyColors.dnaGreen,
                        myIcon: Image.asset("assets/icons/scan_icon.png"),
                        btnText: "Pindai"),
                  ],
                ),
              ),
              SizedBox(height: 12),
              prov.isLoading == true ? Expanded(
                  child: Container(
                      height: 50,
                      child: Center(child: Platform.isIOS ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(strokeWidth: 2)))) :
              Expanded(
                child: searchController.text.isEmpty
                    ? Container()
                    : prov.listFood.length == 0
                    ? Center(
                      child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/no_data.png"),
                            Text('Tidak dapat menemukan hasil untuk "${searchController.text}"',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              )),
                            SizedBox(height: 8),
                            Text('Tidak dapat menemukan hasil untuk "${searchController.text}" tambahkan jika kamu punya informasi mengenai zazaza',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: "Roboto",
                              fontSize: 12,
                            )),
                            SizedBox(height: 16),
                            ButtonWidget(
                              color: MyColors.dnaGreen,
                                height: 46,
                                btnAction: (){

                                },
                                btnText: "Tambah")
                          ],
                        ),
                      )),
                    )
                 :  new ListView.builder(
                  shrinkWrap: true,
                  itemCount: prov.listFood.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FoodItemSearchWidget(model: prov.listFood[index]);
                  },
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


