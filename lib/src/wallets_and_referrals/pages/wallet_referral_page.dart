import 'package:flutter/material.dart';
import 'package:new_klikdna/src/report/pages/detail_report_page.dart';
import 'package:new_klikdna/src/report/pages/hasil_report_page.dart';
import 'package:new_klikdna/src/wallets_and_referrals/widgets/referral_tab_view_page.dart';
import 'package:new_klikdna/src/wallets_and_referrals/widgets/wallet_tab_view_page.dart';
import 'package:new_klikdna/styles/my_colors.dart';

class WalletsAndReferralPage extends StatefulWidget {
  @override
  _WalletsAndReferralPageState createState() => _WalletsAndReferralPageState();
}

class _WalletsAndReferralPageState extends State<WalletsAndReferralPage> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Mitra",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              //Navigator.pushReplacementNamed(context, "detail_report_page");
              Navigator.of(context).pop();
            }),
        bottom: TabBar(
          controller: controller,
          unselectedLabelColor: MyColors.dnaGrey,
          labelColor: MyColors.dnaGreen,
          indicatorColor: MyColors.dnaGreen,
          unselectedLabelStyle: TextStyle(color: MyColors.dnaGreen),
          tabs: [
            Tab(
              text: "Wallet",
            ),
            Tab(
              text: "Referrals"
            )
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: [
          WalletTabViewPage(),
          RefferalTabViewPage()
        ],
      ),
    );
  }
}
