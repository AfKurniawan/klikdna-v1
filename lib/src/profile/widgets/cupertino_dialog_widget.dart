import 'package:flutter/cupertino.dart';

class CupertinoDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback action;
  const CupertinoDialogWidget({
    Key key, this.title, this.message, this.action
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      message: Text(message, style: TextStyle(fontSize: 16)),
      cancelButton: CupertinoActionSheetAction(
          onPressed: ()=>Navigator.of(context).pop(), child: Text("Cancel")),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Oke"),
          onPressed: action,
        ),
      ],
    );
  }
}