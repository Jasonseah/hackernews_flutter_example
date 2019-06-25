import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/screens/best_stories.dart';
import 'package:hackernews/screens/news.dart';
import 'package:hackernews/util/navigation-list.dart';

class BottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavWidget();
}

class BottomNavWidget extends State {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: this.getList(context),
      ),
      resizeToAvoidBottomInset: false,
      tabBuilder: (context, index) {
        return (index == 0)
            ? CupertinoTabView(builder: (context) => NewsPage())
            : CupertinoTabView(
                builder: (context) => BestStoriesPage(),
                defaultTitle: BestStoriesPage.title);
      },
    );
  }

  getList(context) {
    final navigationList = new NavigationList(context);
    final List<BottomNavigationBarItem> itemList = [];

    navigationList.routes.forEach((item) => {
          itemList.add(BottomNavigationBarItem(
            icon: item.icon,
            title: Text(item.title),
          ))
        });

    return itemList;
  }

  tap(context, int index) {
    final navigationList = new NavigationList(context);
    navigationList.routes[index].onTap();

    setState(() {
      _selectedIndex = index;
    });
  }
}
