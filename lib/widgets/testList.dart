import 'package:flutter/material.dart';

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

    this.quiz.then((List value) { print(value);
        for (var i = 0; i < value.length; i++) {
          print(value[i]);

          listArray.add(new ListTile(
              title: new Text(value[i]['name'],
                  style:
                  new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              subtitle: new Text('85 W Portal Ave'),
              leading: new Icon(
                Icons.theaters,
                color: Colors.blue[500],
              )));
        }

        setState(() {
          loading = false;
        });
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new ListView(
            children: loading
                ? []
                : listArray // when the state of loading changes from true to false, it'll force this widget to reload
            ));
  }
}
/*
class _CreateList extends State<TestList> {
  bool loading = true;


  @override
  Widget build(BuildContext context) {
    List<Widget> listArray = [];

    widget.quiz.then((List value) {
      for (var i = 0; i < value.length; i++) {
        print(value[i]);

        listArray.add(new ListTile(
            title: new Text('CineArts at the Empires',
                style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
            subtitle: new Text('85 W Portal Ave'),
            leading: new Icon(
              Icons.theaters,
              color: Colors.blue[500],
            )));
      }
      print(loading);
      setState(() { loading = false; });
    });

    //


    return new Container(
        child: new ListView(
      children: loading ? [] : listArray,
    ));
  }
}
*/
