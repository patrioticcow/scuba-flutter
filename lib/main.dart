import 'dart:core';
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
        home: new TestsPage(title: 'Tests'),
        routes: <String, WidgetBuilder>{
          TestsPage.routeName: (BuildContext context) =>
              new TestsPage(title: 'TestsPage')
        },
        onGenerateRoute: (routeSettings) {
          var path = routeSettings.name.split('/');
          final id = path.length > 1 ? int.parse(path[1]) : null;
          final qid = path.length > 2 ? int.parse(path[2]) : null;

          if (path[0] == TestPage.routeName) {
            return new MaterialPageRoute(
              builder: (context) => new TestPage(id: id, qid: qid),
              settings: routeSettings,
            );
          }
        });
  }
}
