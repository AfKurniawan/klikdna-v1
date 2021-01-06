
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class LoginErrorWidget extends StatelessWidget {
  final String title, description, filledButtonText, outlineButtonText;
  final VoidCallback filledButtonaction;
  final VoidCallback outlineButtonAction;
  final Color outlineTextColor;

  LoginErrorWidget({
    @required this.title,
    this.description,
    @required this.filledButtonText,
    this.outlineButtonText,
    this.filledButtonaction,
    this.outlineButtonAction,
    this.outlineTextColor
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  dialogContent(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height > 600 ?
    Stack(
      children: <Widget>[
        Container(
          width: mediaQuery.size.width > 600 ? mediaQuery.size.width /2 : mediaQuery.size.width / 1,
          padding: EdgeInsets.only(
            bottom: 16,
            left: 16,
            right: 16,
          ),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: MyColors.dnaGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.0,
                    color: MyColors.dnaGrey,
                    fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 16.0),
              Divider(),
              SizedBox(height: 16.0),

              InkWell(
                onTap: filledButtonaction,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyColors.dnaGreen

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            filledButtonText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ) :

    ListView(
      children: [
        Center(
          child: Stack(
            children: <Widget>[
              Container(
                width: mediaQuery.size.width > 600 ? mediaQuery.size.width /2 : mediaQuery.size.width / 1,
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    SizedBox(height: 30),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        InkWell(
                          onTap: outlineButtonAction,
                          splashColor: MyColors.dnaGreen,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: MyColors.dnaGreen,
                                  width: 2
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      outlineButtonText,
                                      style: TextStyle(
                                          color: MyColors.dnaGreen,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: filledButtonaction,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MyColors.dnaGreen

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      filledButtonText,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )


                      ],
                    )


                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}