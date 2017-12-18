
import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/tests.dart';
import 'package:myapp/screens/test.dart';

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
          TestPage.routeName: (BuildContext context) => new TestPage(title: 'TestPage'),
          TestsPage.routeName: (BuildContext context) => new TestsPage(title: 'TestsPage')
        }
    );
  }
}

