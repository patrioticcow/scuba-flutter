import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:myapp/drawer/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key, this.id, this.qid}) : super(key: key);

  static const String routeName = "TestPage";

  final int id;
  final int qid;

  @override
  _TestPageState createState() => new _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var question;

  _getQuizFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('33333333333333333333');
    return prefs.getString('quiz');
  }

  _getQuestions(data) {
    print('++++++++++++');
    print(data);
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
    print('22222222222222222222');

    _getQuizFromStorage().then((String value) {
      if (value != null) {
        this.question = _getQuestions(JSON.decode(value));

        print('--------------');
        print(this.question);
      }
    });

    return new Scaffold(
        drawer: drawer,
        appBar: new AppBar(
          title: new Text('I see'),
        ),
    //body: null);
    body: this.question != null ? new QuestionCard(question: this.question) : '');
  }
}

class QuestionCard extends StatelessWidget {
  final question;
  static const test = 'test';

  QuestionCard({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.question['answers']);

    var childList = <Widget>[
      new ListTile(
        leading: new Icon(Icons.album),
        title: new Text(this.question['title']),
      ),
    ];

    for (var i = 0; i < this.question['answers'].length; i++) {
      childList.add(new FlatButton(
        child: new Text(this.question['answers'][i]),
        onPressed: () {
          /* ... */
        },
      ));
    }

    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: childList,
      ),
    );
  }
}
