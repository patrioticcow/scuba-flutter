import 'package:flutter/material.dart';
import 'package:myapp/test.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    TestPage.routeName: (BuildContext context) =>
    new TestPage(title: 'TestPage')
  };

}
