import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/drawer/menu.dart';

class TestsPage extends StatefulWidget {
  TestsPage({Key key, this.title}) : super(key: key);

  static const String routeName = "TestsPage";

  final String title;

  @override
  _TestsPageState createState() => new _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    _getIPAddress();
  }

  _getIPAddress() async {
    String url = 'https://api.massinflux.com/scuba/quiz.php?type=quiz';
    var httpClient = createHttpClient();
    var response = await httpClient.read(url);
    List data = JSON.decode(response);

    print(data[0]['name']);
    print(data);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    Menu drawer = new Menu();

    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'TESTS You have pushed the button this many times;:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
