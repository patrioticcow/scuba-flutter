import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:myapp/drawer/menu.dart';
import 'package:myapp/widgets/questionCard.dart';
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
  List<int> score;

  _getFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      this.quiz = prefs.getString('quiz');
      this.quiz = JSON.decode(this.quiz)[widget.id];
      this.question = this.quiz['data'][widget.qid];
    });

    return "Success!";
  }

  _getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var scoreUp = prefs.getInt('score_up_' + widget.id.toString());
    var scoreDown = prefs.getInt('score_down_' + widget.id.toString());

    // save score
    if (scoreUp == null) {
      prefs.setInt('score_up_' + widget.id.toString(), 0);
    }
    if (scoreDown == null) {
      prefs.setInt('score_down_' + widget.id.toString(), 0);
    }

    setState(() {
      this.score = [scoreUp, scoreDown];
    });

    return "Success!";
  }

  @override
  void initState() {
    this._getFromStorage();
    this._getScore();
  }

  @override
  Widget build(BuildContext context) {
    Menu drawer = new Menu();

    //print('--- question ---');
    //print(this.question);

    return new Scaffold(
        drawer: drawer,
        appBar: new AppBar(
          title: new Text('Question'),
        ),
        //body: null);
        body: this.question != null ? new QuestionCard(score: this.score, question: this.question, id: widget.id, qid: widget.qid) : null);
  }
}
