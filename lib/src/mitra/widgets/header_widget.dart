import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:new_klikdna/src/patient_card/providers/patient_card_provider.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key key,
    @required this.prov,
  }) : super(key: key);

  final MitraProvider prov;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width < 400 ? 140 : 130,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 10.0,
                  offset: Offset(0.75, 0)),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: MediaQuery.of(context).size.width < 400 ? 140 : 130,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 16, left: 16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2)),
                child: Center(
                  child: Consumer<PatientCardProvider>(
                    builder: (context, model, _) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: model.photoView == null ?
                          Image.asset("assets/images/no_image.png", height: 62, width: 62, fit: BoxFit.cover)
                              : Image.memory(
                            model.photoView,
                            width: 62,
                            fit: BoxFit.cover,
                            height: 62,
                            // height: 150,
                          ));
                    },
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Komisi",
                    style: TextStyle(
                        color: MyColors.dnaBlack,
                        fontSize: 12, fontWeight: FontWeight.w300),
                  ),

                  SizedBox(height: 2),

                  Text(
                    prov.vtotalcommission == null ? "0" : "IDR ${prov.vtotalcommission.split(".")[0]}",
                    style: TextStyle(
                        color: MyColors.dnaBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 32,
                width: 32,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Color(0xffEDF0F4),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: InkWell(
                  onTap: (){
                    Provider.of<WalletReferralProvider>(context, listen: false).clearFilter();
                    Navigator.of(context).pushNamed("wallet_referral_page");

                  },
                  child: Center(
                    child: Icon(Icons.arrow_forward_ios, size: 16),
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