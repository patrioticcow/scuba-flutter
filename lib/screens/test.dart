import 'dart:core';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/drawer/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/widgets/testList.dart';
import 'package:myapp/screens/home.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key, this.title, this.id, this.qid}) : super(key: key);

  static const String routeName = "TestPage";

  final String title;
  final int id;
  final int qid;

  @override
  _TestPageState createState() => new _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var question;

  _getQuizFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('quiz');
  }

  _getQuestions(data) {
    var value;
    for (var i = 0; i < data.length; i++) {
      if (data[i]['group'] == widget.id) {
        value = data[i]['data'][widget.qid];
      }
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    Menu drawer = new Menu();

    _getQuizFromStorage().then((String value) {
      if (value != null) {
        this.question = _getQuestions(JSON.decode(value));
      }
    });

    return new Scaffold(
        drawer: drawer,
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: this.question != null ? new QuestionCard(question: this.question) : '');
  }
}

class QuestionCard extends StatelessWidget {
  final question;
  static const x = ';;;';

  QuestionCard({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-----------');
    print(this.question);
    print(this.question['title']);

    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: const Icon(Icons.album),
            title: const Text(x),
          ),
          new FlatButton(
            child: const Text(
                'BUY TICKETS Music by Julie Gable.e. Lyrics by Sidney Stein.'),
            onPressed: () {
              /* ... */
            },
          ),
          new FlatButton(
            child: const Text('BUY TICKETS'),
            onPressed: () {
              /* ... */
            },
          ),
        ],
      ),
    );
  }
}
