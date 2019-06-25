import 'package:flutter/material.dart';

class NavigationItem {
  final Icon icon;
  final String title;
  final VoidCallback onTap;

  NavigationItem({this.icon, this.title, this.onTap});
}
