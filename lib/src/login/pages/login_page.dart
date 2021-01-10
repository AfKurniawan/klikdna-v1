import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/disable_button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool buttonDisabled = true ;


  @override
  Widget build(BuildContext context) {
    final emailValidator = MultiValidator([
      EmailValidator(errorText: "Alamat email tidak valid"),
      RequiredValidator(errorText: "Harap isi alamat email")
    ]);
    final passwordValidator = RequiredValidator(errorText: "Harap isi password");
    var prov = Provider.of<LoginProvider>(context);
    return Consumer<LoginProvider>(
      builder: (context, login, _){
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: MyColors.background,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: login.isLoading == true ? Center(child: Platform.isIOS ? CupertinoActivityIndicator():CircularProgressIndicator(strokeWidth: 2))
              : ListView(
            children: [
              Container(
                //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height /7),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Masuk ke",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 10),

                          Container(
                              child: Image.asset("assets/images/logo_klik_dna.png")
                          ),

                        ],
                      ),

                      SizedBox(
                        height: 160,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormWidget(
                                onchange: (text) {
                                  setState(() {
                                    if(text.length > 1){
                                      buttonDisabled = false ;
                                    } else {
                                      buttonDisabled = true ;
                                    }

                                  });

                                },
                                validator: emailValidator,
                                labelText: "Email",
                                textEditingController: prov.emailController,
                                keyboardType: TextInputType.emailAddress,
                                obscure: false,
                              ),

                              SizedBox(height: 10),

                              Consumer<LoginProvider>(
                                builder: (context, model, _){
                                  return FormWidget(
                                    suffixIcon: GestureDetector(
                                      onTap: (){
                                        model.toggle();
                                      },
                                      child: Icon(model.obscureText ? Icons.visibility : Icons
                                          .visibility_off, color: MyColors.dnaGreen),
                                    ),
                                    onchange: (text) {
                                      setState(() {
                                        if(text.length > 1){
                                          buttonDisabled = false ;
                                        } else {
                                          buttonDisabled = true ;
                                        }

                                      });

                                    },
                                    labelText: "Password",
                                    validator: passwordValidator,
                                    textEditingController: prov.passwordController,
                                    keyboardType: TextInputType.text,
                                    obscure: model.obscureText,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: buttonDisabled == true ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: DisableButtonWidget(
                btnText: "LANJUTKAN",
                color: MyColors.grey,
                height: 50,
                btnAction: (){},
              )
          )
              :  Padding(
              padding: const EdgeInsets.all(18.0),
              child: ButtonWidget(
                btnText: "LANJUTKAN",
                color: MyColors.dnaGreen,
                height: 50,
                btnAction: (){
                  if (_formKey.currentState.validate()) {
                    context.read<LoginProvider>().loginAction(context);
                  }
                },
              )
          )
        );
      },
    );
  }
}
