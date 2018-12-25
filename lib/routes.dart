import 'package:flutter/material.dart';
import 'screens/news.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/test': (BuildContext context) => new NewsPage()
  };

  Routes() {
    runApp(new MaterialApp(
      title: 'Hacker News',
      routes: routes,
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new NewsPage(),
    ));
  }
}
