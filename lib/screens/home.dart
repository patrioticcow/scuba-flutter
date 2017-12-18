import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/drawer/menu.dart';
import 'package:myapp/widgets/testList.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  static const String routeName = "/";

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var resp;

  void _incrementCounter() {
    //;
  }


  _getQuiz() async {
    String url = 'https://api.massinflux.com/scuba/quiz.php?type=quiz';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);

    List data = JSON.decode(response);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    Menu drawer = new Menu();

    _getQuiz().then((List value){
      this.resp = value;
      //print(value);

    });


    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new TestList(quiz: _getQuiz()),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
