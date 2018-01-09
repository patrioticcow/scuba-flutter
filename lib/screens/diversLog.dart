import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/drawer/menu.dart';

class DiversLog extends StatefulWidget {
  DiversLog({Key key, this.title}) : super(key: key);

  static const String routeName = "DiversLog";

  final String title;

  @override
  _DiversLogState createState() => new _DiversLogState();
}

class _DiversLogState extends State<DiversLog> {
  @override
  Widget build(BuildContext context) {
    Menu drawer = new Menu();

    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: null,
    );
  }
}
