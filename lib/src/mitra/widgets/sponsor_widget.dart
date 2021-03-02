import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:provider/provider.dart';

class SponsorWidget extends StatefulWidget {
  const SponsorWidget({
    Key key,
    @required this.prov
  }) : super(key: key);

  final MitraProvider prov;


  @override
  _SponsorWidgetState createState() => _SponsorWidgetState();
}

class _SponsorWidgetState extends State<SponsorWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 7,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                height: 20,
                width: MediaQuery.of(context).size.width / 2,
                child: Text("${widget.prov.vsponsorfirstname} ${widget.prov.vsponsorlastname}",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),

              SizedBox(width: 10),
              Container(
                color: Colors.white,
                height: 30,
                width: 1,
              ),
              SizedBox(width: 10),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      print("WHATSSAPPP ${widget.prov.vsponsorphone}");
                      Provider.of<MitraProvider>(context, listen: false).makePhoneCall(context, widget.prov.vsponsorphone, widget.prov.vsponsorfirstname);
                    },
                    child: Image.asset("assets/icons/phone_icon.png"),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                      print("WHATSSAPPP ${widget.prov.vsponsorphone}");
                      Provider.of<MitraProvider>(context, listen: false).openWhatsapp(context, widget.prov.vsponsorphone, widget.prov.vsponsorfirstname);
                    },
                    child: Image.asset("assets/icons/whatsapp_icon.png"),
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