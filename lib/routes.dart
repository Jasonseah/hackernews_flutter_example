import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/widgets/bottom_nav_widget.dart';
import 'package:provider/provider.dart';
import 'package:hackernews/screens/best_stories.dart';
import 'data/app.dart';
import 'screens/news.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class Routes {
  Routes() {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    'front-page': (BuildContext context) => new NewsPage(),
    'best-stories': (BuildContext context) => new BestStoriesPage()
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      builder: (context) => AppState(),
      child: isIOS
          ? CupertinoApp(
              debugShowCheckedModeBanner: false,
              routes: routes,
              theme: CupertinoThemeData(
                primaryColor: Colors.deepOrange,
              ),
              home: AdaptiveMainScreen(),
            )
          : MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
              ),
              routes: routes,
              debugShowCheckedModeBanner: false,
              title: 'Hacker News',
              home: AdaptiveMainScreen(),
            ),
    );
  }
}

class AdaptiveMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return BottomNav();
    } else {
      return NewsPage();
    }
  }
}
