import 'package:flutter/material.dart';
import 'package:myapp/test.dart';
import 'package:myapp/main.dart';

class Routes {
  final String page;

  Routes.homePage({this.page : 'HomePage'}){
    <String, WidgetBuilder>{
      HomePage.routeName: (BuildContext context) => new HomePage(title: 'HomePage')
    };
  }

  Routes.testPage({this.page : 'TestPage'}){
    <String, WidgetBuilder>{
      TestPage.routeName: (BuildContext context) => new TestPage(title: 'TestPage')
    };
  }

}
