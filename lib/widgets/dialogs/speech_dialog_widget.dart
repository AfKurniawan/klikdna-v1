
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/configs/app_constants.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechDialogWidget extends StatefulWidget {
  final String text;
  final bool isListen, isAvailable ;

  const SpeechDialogWidget({Key key, this.text, this.isListen, this.isAvailable}) : super(key: key);

  @override
  _SpeechDialogWidgetState createState() => _SpeechDialogWidgetState();
}

class _SpeechDialogWidgetState extends State<SpeechDialogWidget> {


  @override
  void initState() {
    print("Speech dialog Showed");
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: AppConstants.padding,top: AppConstants.avatarRadius
                      + AppConstants.padding, right: AppConstants.padding,bottom: AppConstants.padding
                  ),
                  margin: EdgeInsets.only(top: AppConstants.avatarRadius),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppConstants.padding),
                      boxShadow: [
                        BoxShadow(color: Colors.black26,offset: Offset(0,10),
                            blurRadius: 10
                        ),
                      ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 55),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FlatButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Text("Close",style: TextStyle(fontSize: 18),)),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  top: 55,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: AvatarGlow(
                        animate: true,
                        glowColor: Theme.of(context).primaryColor,
                        endRadius: 190.0,
                        duration: const Duration(milliseconds: 1500),
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        repeat: true,
                        child: FloatingActionButton(
                          backgroundColor: MyColors.dnaGreen,
                          onPressed: null,
                          child: Icon(Icons.mic_none),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}