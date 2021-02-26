
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/providers/wallet_referral_provider.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/widgets/new_referral_tab_view.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/widgets/new_wallet_tab_view.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/widgets/new_wallet_tab_view_fix.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/widgets/referral_tab_view_widget.dart';
import 'package:new_klikdna/src/mitra/wallets_and_referrals/widgets/wallet_tab_view_widget.dart';
import 'package:new_klikdna/styles/my_colors.dart';
import 'package:provider/provider.dart';

class WalletsAndReferralPage extends StatefulWidget {
  @override
  _WalletsAndReferralPageState createState() => _WalletsAndReferralPageState();
}

class _WalletsAndReferralPageState extends State<WalletsAndReferralPage> with SingleTickerProviderStateMixin{

  TabController controller;
  Future future ;

  @override
  void initState() {
    future = Provider.of<WalletReferralProvider>(context, listen: false).getWalletData(context) ;
    Provider.of<WalletReferralProvider>(context, listen: false).getReferralData(context) ;
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
      backgroundColor: Color(0xffEDF0F4),
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
              //Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed("main_page", arguments: 2);
              Provider.of<WalletReferralProvider>(context, listen: false).clearFilter();

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
      body: TabBarView(
        controller: controller,
        children: [
          NewWalletTabViewFix(future: future),
          NewReferralTabView(future: future)
        ],
      ),
    );
  }
}

