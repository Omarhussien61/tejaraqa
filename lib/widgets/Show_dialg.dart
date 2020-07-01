
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Show_dialog extends StatelessWidget {

  String title;
  String msg;

  Show_dialog(this.title, this.msg);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: new Text(msg),
    content: new Text(title),
    actions: <Widget>[
    // usually buttons at the bottom of the dialog
    ],
      )
    );
  }



}
