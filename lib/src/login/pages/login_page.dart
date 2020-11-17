import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:new_klikdna/widgets/button_widget.dart';
import 'package:new_klikdna/widgets/form_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();


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
            leading: IconButton(
              color: MyColors.grey,
              icon: Icon(Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: (){
                print("Back");
               Navigator.pushReplacementNamed(context, "onboarding_page");
              },
            ),
          ),
          body: login.isLoading == true ? Center(child: CupertinoActivityIndicator())
              : ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height /7),
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
                                fontSize: 28,
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
                        height: 50,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormWidget(
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
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ButtonWidget(
                btnText: "MASUK",
                color: MyColors.dnaGreen,
                btnAction: (){
                  if (_formKey.currentState.validate()) {
                    context.read<LoginProvider>().loginAction(context);
                  }
                },
              )
          ),
        );
      },
    );
  }
}
