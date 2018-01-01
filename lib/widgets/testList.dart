import 'package:flutter/material.dart';
import 'package:myapp/screens/test.dart';

// NOT USED
// NOT USED
// NOT USED
// NOT USED
// NOT USED
// NOT USED
// NOT USED
// NOT USED
// NOT USED
// NOT USED

class TestList extends StatefulWidget {
  final quiz;

  TestList({this.quiz});

  @override
  _CreateList createState() => new _CreateList(quiz: this.quiz);
}

class _CreateList extends State<TestList> {
  bool loading = true;
  final quiz;

  List listArray = [];

  _CreateList({this.quiz}) {
    this.quiz.then((List value) {
      if (value != null) {
        for (var i = 0; i < value.length; i++) {
          //print(value[i]['data']);

          listArray.add(new ListTile(
            title: new Text(value[i]['name'],
                style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: new Text(value[i]['data'][0]['title']),
            leading: new Icon(
              Icons.assignment,
              color: Colors.blue[500],
            ),
            onTap: () {
              Navigator.pushNamed(
                  context, TestPage.routeName + "/${value[i]['group']}/1");
            },
          ));
        }
      } else {
        // todo, show no results
        print('no results');
      }

      setState(() {
        loading = false;
      });
    });
  }

  var loadingIndicator = new Center(
      child: new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new CircularProgressIndicator()));

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: loading
            ? loadingIndicator
            : new ListView(
                children:
                    listArray // when the state of loading changes from true to false, it'll force this widget to reload
                ));
  }
}
