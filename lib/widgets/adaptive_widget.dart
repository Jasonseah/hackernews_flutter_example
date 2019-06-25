import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackernews/data/news.dart';
import 'darwer_widget.dart';
import 'package:flutter/foundation.dart' as foundation;

bool get _isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class AdaptivePageScaffold extends StatelessWidget {
  const AdaptivePageScaffold({
    @required this.title,
    @required this.child,
  })  : assert(title != null),
        assert(child != null);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (_isIOS) {
      return AdaptiveTextTheme(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(title),
          ),
          resizeToAvoidBottomInset: false,
          child: child,
        ),
      );
    } else {
      return AdaptiveTextTheme(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          drawer: ModalRoute.of(context).isFirst ? DrawerWidget() : null,
          body: child,
        ),
      );
    }
  }
}

class AdaptiveListView extends StatelessWidget {
  const AdaptiveListView({
    @required this.newsItem,
    @required this.onTap,
  })  : assert(newsItem != null),
        assert(onTap != null);

  final News newsItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (_isIOS) {
      return new GestureDetector(
        onTap: () {
          onTap();
        },
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(12.0),
              child: new ListBody(children: <Widget>[
                Text(newsItem.title),
                Text(
                  'by ' + newsItem.by + ' | ' + newsItem.getTimeDiffInHuman(),
                  style: TextStyle(color: Colors.grey[500], fontSize: 14.0),
                ),
              ]),
            ),
            new Divider(height: 1.0),
          ],
        ),
      );
    } else {
      return new Column(
        children: <Widget>[
          new ListTile(
              title: new Text(newsItem.title),
              subtitle: new Text(
                  'by ' + newsItem.by + ' | ' + newsItem.getTimeDiffInHuman()),
              onTap: () {
                onTap();
              }),
          new Divider(
            height: 2.0,
          ),
        ],
      );
    }
  }
}

class AdaptiveTextTheme extends StatelessWidget {
  const AdaptiveTextTheme({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final materialThemeData = Theme.of(context);
    final cupertinoThemeData = CupertinoTheme.of(context);

    return _AdaptiveTextThemeProvider(
      data: AdaptiveTextThemeData(
        materialThemeData?.textTheme,
        cupertinoThemeData?.textTheme,
      ),
      child: child,
    );
  }

  static AdaptiveTextThemeData of(BuildContext context) {
    final provider =
        context.inheritFromWidgetOfExactType(_AdaptiveTextThemeProvider)
            as _AdaptiveTextThemeProvider;
    return provider?.data;
  }
}

class _AdaptiveTextThemeProvider extends InheritedWidget {
  _AdaptiveTextThemeProvider({
    this.data,
    @required Widget child,
    Key key,
  }) : super(child: child, key: key);

  final AdaptiveTextThemeData data;

  @override
  bool updateShouldNotify(_AdaptiveTextThemeProvider oldWidget) {
    return data != oldWidget.data;
  }
}

class AdaptiveTextThemeData {
  const AdaptiveTextThemeData(this.materialThemeData, this.cupertinoThemeData);

  final TextTheme materialThemeData;
  final CupertinoTextThemeData cupertinoThemeData;

  TextStyle get headline =>
      (materialThemeData?.headline ?? cupertinoThemeData.navLargeTitleTextStyle)
          .copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.6,
      );

  TextStyle get subhead =>
      (materialThemeData?.subhead ?? cupertinoThemeData.textStyle).copyWith(
        color: Color(0xDE000000),
        fontSize: 14,
        letterSpacing: 0.1,
      );

  TextStyle get tileTitle =>
      (materialThemeData?.body2 ?? cupertinoThemeData.textStyle).copyWith(
        fontSize: 21,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      );

  TextStyle get bodySmall =>
      (materialThemeData?.body2 ?? cupertinoThemeData.textStyle).copyWith(
        color: Color(0xDE000000),
        fontSize: 12,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w500,
      );

  TextStyle get body =>
      (materialThemeData?.subhead ?? cupertinoThemeData.navTitleTextStyle)
          .copyWith(
        color: Color(0xDE000000),
        fontSize: 14.05,
        letterSpacing: 0.25,
        fontWeight: FontWeight.w500,
      );

  TextStyle get label =>
      (materialThemeData?.body2 ?? cupertinoThemeData.textStyle).copyWith(
        fontStyle: FontStyle.italic,
        fontSize: 12,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w500,
        color: Color(0x99000000),
      );

  @override
  int get hashCode => materialThemeData.hashCode ^ cupertinoThemeData.hashCode;

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final AdaptiveTextThemeData typedOther = other;
    return materialThemeData != typedOther.materialThemeData ||
        cupertinoThemeData != typedOther.cupertinoThemeData;
  }
}
