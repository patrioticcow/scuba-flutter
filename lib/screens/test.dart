import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:myapp/drawer/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/screens/tests.dart';

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

    print('------------------------------------');
    print(this.question);

    return new Scaffold(
        drawer: drawer,
        appBar: new AppBar(
          title: new Text('Question'),
        ),
        //body: null);
        body: this.question != null
            ? new QuestionCard(
                question: this.question, id: widget.id, qid: widget.qid)
            : null);
  }
}

class QuestionCard extends StatefulWidget {
  final question;
  final int id;
  final int qid;

  QuestionCard({Key key, this.question, this.id, this.qid}) : super(key: key);

  @override
  _QuestionCardState createState() => new _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String _selectedAnswer = '';
  bool _isCorrect = false;
  Color _color;

  void _showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: new Text('Correct: ' + (_isCorrect ? 'Yes' : 'No'),
                style: new TextStyle(color: _color)),
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          new Container(
            child: new Text(
                widget.question['title'] + ' ' + widget.question['answer']),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Continue'),
          onPressed: () {
            Navigator.pop(context);

            var qid = widget.qid + 1;
            Navigator.pushNamed(
                context, TestPage.routeName + "/${widget.id}/${qid}");
          },
        )
      ],
    );

    showDialog(context: context, child: dialog);
  }

  void _onAnswerSelect(String value) {
    setState(() {
      _selectedAnswer = value;
      _isCorrect = _selectedAnswer == widget.question['answer'];
      _color = _isCorrect ? Colors.green[400] : Colors.red[400];
    });
  }

  @override
  Widget build(BuildContext context) {
    var childList = <Widget>[
      new ListTile(
        //leading: new Icon(Icons.album),
        title: new Text(widget.question['title']),
      ),
    ];

    for (var i = 0; i < widget.question['answers'].length; i++) {
      childList.add(new Row(
        children: <Widget>[
          new Flexible(
              fit: FlexFit.tight,
              child: new Container(
                child: new FlatButton(
                  child: new Text(widget.question['answers'][i]),
                  onPressed: () {
                    _onAnswerSelect(widget.question['answers'][i]);
                    _showAlert();
                  },
                ),
                padding: const EdgeInsets.all(6.0),
                margin: const EdgeInsets.all(2.0),
              )),
        ],
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
