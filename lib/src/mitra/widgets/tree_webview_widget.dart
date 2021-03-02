import 'package:flutter/material.dart';
import 'package:new_klikdna/src/login/providers/login_provider.dart';
import 'package:new_klikdna/src/mitra/providers/mitra_provider.dart';
import 'package:provider/provider.dart';

class TreeWebViewWidget extends StatelessWidget {
  const TreeWebViewWidget({
    Key key,
    @required this.prov,
  }) : super(key: key);

  final MitraProvider prov;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Color(0xFFB0CCE1).withOpacity(0.32),
          ),
        ],
      ),
      child: Container(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            print("TREEE URL ${prov.vtree}");
            Provider.of<MitraProvider>(context, listen: false).treeWebview(prov.vtree);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/new_trees.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              // height: 150,
            ),
          ),
        ),
      ),
    );
  }
}