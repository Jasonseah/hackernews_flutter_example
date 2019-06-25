import 'navigation-item.dart';
import 'package:flutter/material.dart';

class NavigationList {
  final context;

  List<NavigationItem> routes = [];

  NavigationList(this.context) {
    routes = [
      this.navigateFrontPage(),
      this.navigateBestStoriesPage(),
      this.navigateSettingPage()
    ];
  }

  navigateFrontPage() {
    return new NavigationItem(
        icon: Icon(Icons.home),
        title: 'Front Page',
        onTap: () {
          Navigator.of(this.context).pushReplacementNamed('front-page');
        });
  }

  navigateBestStoriesPage() {
    return new NavigationItem(
        icon: Icon(Icons.bookmark),
        title: 'Best Stories',
        onTap: () {
          Navigator.of(this.context).pushReplacementNamed('best-stories');
        });
  }

  navigateSettingPage() {
    return new NavigationItem(
        icon: Icon(Icons.settings),
        title: 'Settings',
        onTap: () {
          Navigator.of(this.context).pushReplacementNamed('best-stories');
        });
  }
}
