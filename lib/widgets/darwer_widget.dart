import 'package:flutter/material.dart';
import 'package:hackernews/util/navigation-list.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: getList(context),
      ),
    );
  }

  getList(context) {
    final navigationList = new NavigationList(context);

    final List<Widget> itemList = [
      DrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/android-icon-white.png'),
          ),
          color: Colors.deepOrange,
        ),
      )
    ];

    navigationList.routes.forEach((item) => {
          itemList.add(ListTile(
              leading: item.icon,
              title: Text(item.title),
              onTap: () {
                item.onTap();
              }))
        });

    return itemList;
  }
}
