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
  var quiz;
  var question;

  _getFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      this.quiz = prefs.getString('quiz');
      this.quiz = JSON.decode(this.quiz)[widget.id];
      this.question = this.quiz['data'][widget.qid];
    });

    return "Success!";
  }

  @override
  void initState() {
    this._getFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    Menu drawer = new Menu();

    return new Scaffold(
        drawer: drawer,
        appBar: new AppBar(
          title: new Text('I see'),
        ),
        //body: null);
        body: this.question != null
            ? new QuestionCard(question: this.question, id: widget.id, qid: widget.qid)
            : '');
  }
}

class QuestionCard extends StatelessWidget {
  final question;
  final id;
  final qid;

  QuestionCard({Key key, this.question, this.id, this.qid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var qid = this.qid + 1;
    print('-----QuestionCard-----');
    print(this.question['answers']);
    print(this.id);
    print(this.qid);
    print(qid);

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
          Navigator.pushNamed(context, TestPage.routeName + "/${this.id}/${qid}");
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
