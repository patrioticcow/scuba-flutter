import 'dart:core';

import 'package:flutter/material.dart';
import 'package:myapp/screens/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QuestionCard extends StatefulWidget {
  final question;
  final score;
  final int id;
  final int qid;

  QuestionCard({Key key, this.score, this.question, this.id, this.qid}) : super(key: key);

  @override
  _QuestionCardState createState() => new _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String _selectedAnswer = '';
  bool _isCorrect = false;
  Color _color;
  int _correctText = 0;
  int _incorrectText = 0;

  void _showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: new Text('Correct: ' + (_isCorrect ? 'Yes' : 'No'), style: new TextStyle(color: _color)),
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          new Container(child: new Text(widget.question['title'])),
          new Container(child: new Text(widget.question['answer'])),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Continue'),
          onPressed: () {
            Navigator.pop(context);

            print('--- widget ---');
            print(widget.question);
            print(widget.qid);
            print(widget.qid + 1);


            var qid = widget.qid + 1;
            Navigator.pushNamed(context, TestPage.routeName + "/${widget.id}/${qid}");
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

      // set score
      _setScore(_isCorrect);
    });
  }

  _setScore(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int up = widget.score[0] != null ? widget.score[0] : 0;
    int down = widget.score[1] != null ? widget.score[1] : 0;

    // set score
    if (status == true) {
      prefs.setInt('score_up_' + widget.id.toString(), up + 1);
    } else {
      prefs.setInt('score_down_' + widget.id.toString(), down + 1);
    }

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    _correctText = widget.score[0] != null ? widget.score[0] : 0;
    _incorrectText = widget.score[1] != null ? widget.score[1] : 0;

    var childList = <Widget>[
      new ListTile(
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

    return new Column(children: <Widget>[
      new Card(
        child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(8.0),
            child: new Row(children: [
              new Expanded(
                child: new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  new Text('Score', style: new TextStyle(fontWeight: FontWeight.bold)),
                ]),
              ),
              new Container(child: new Text('Correct: ' + _correctText.toString(), style: new TextStyle(color: Colors.green[400])), margin: const EdgeInsets.only(right: 10.0)),
              new Text('Incorrect: ' + _incorrectText.toString(), style: new TextStyle(color: Colors.red[400])),
            ]),
          )
        ]),
      ),
      new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: childList,
        ),
      )
    ]);
  }
}
