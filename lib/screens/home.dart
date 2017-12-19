import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/drawer/menu.dart';
import 'package:myapp/widgets/testList.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  _getQuizFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('quiz');
  }

  _getQuizFromServer() async {
    String url = 'https://api.massinflux.com/scuba/quiz.php?type=quiz';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('quiz', response);

    List data = JSON.decode(response);

    return data;
  }

  _getQuiz() async {
    return _getQuizFromStorage().then((String value) {
      return value == null ? _getQuizFromServer() : JSON.decode(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Menu drawer = new Menu();

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
