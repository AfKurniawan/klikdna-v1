import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';

class SponsorWidget extends StatelessWidget {
  const SponsorWidget({
    Key key,
    @required this.prov,
  }) : super(key: key);

  final LoginProvider prov;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height / 6,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Color(0xff50A1D3),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 20,
                color: Color(0xFFB0CCE1).withOpacity(0.32),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10, left: 20),
                height: 80,
                width: MediaQuery.of(context).size.width / 1.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${prov.vsponsorfirstname} ${prov.vsponsorlastname}",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        onTap: (){
                          print("CALL SPONSOR");
                        },
                        child: Row(
                          children: [
                            Icon(Icons.phone, size: 15),
                            SizedBox(width: 5),
                            Text(prov.vsponsorphone == null ? "-" : "${prov.vsponsorphone}",
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.underline
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      print("CALL WHATSAPP");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/whatsapp_icon.png"),
                        SizedBox(height: 5),
                        Text("Whatsapp", style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ))
                      ],
                    ),
                  ),
                ),

              ),
            ],
          ),
        ),
      ],
    );
  }
}