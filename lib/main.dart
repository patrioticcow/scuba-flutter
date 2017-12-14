import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/drawer/menu.dart';
import 'package:myapp/route/routes.dart';
import 'package:myapp/test.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
        title: 'Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new HomePage(title: 'Home Page'),
        routes: <String, WidgetBuilder>{
          TestPage.routeName: (BuildContext context) => new TestPage(title: 'TestPage')
        }
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  static const String routeName = "/";

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {

    setState(() {
      _counter++;
    });

    _getQuiz();
  }

  _getQuiz() async {
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
              'You have pushed the button this many times;:',
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
