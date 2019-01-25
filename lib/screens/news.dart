import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackernews/data/news.dart';
import 'package:hackernews/main.dart';
import 'package:hackernews/widgets/darwer_widget.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  void onLoadStart(String url) {
    super.onLoadStart(url);
    print("\n\nStarted $url\n\n");
  }

  @override
  void onLoadStop(String url) {
    super.onLoadStop(url);
    print("\n\nStopped $url\n\n");
  }

  @override
  void onExit() {
    super.onExit();
    print("\n\nBrowser closed!\n\n");
  }
}

MyInAppBrowser inAppBrowser = new MyInAppBrowser();

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: newsService.fetchNewsList(0),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return NewsList(news: snapshot.data);
        }
      },
    );

    return Scaffold(
        drawer: new DrawerWidget(),
        appBar: AppBar(
          title: Text('News'),
        ),
        body: new Scrollbar(child: futureBuilder));
  }
}

class NewsList extends StatefulWidget {
  final news;

  NewsList({Key key, this.news}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  var loadedPage = 0;
  var news;
  bool loadingList = false;
  ScrollController controller;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    news = widget.news;
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: news.length,
      controller: controller,
      itemBuilder: (BuildContext context, int index) {
        final newsItem = news[index];
        if (newsItem is LoadingItem) {
          return new Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
            ],
          );
        } else {
          return new Column(
            children: <Widget>[
              new ListTile(
                  title: new Text(newsItem.title),
                  subtitle: new Text('by ' + newsItem.by + ' | ' + newsItem
                      .getTimeDiffInHuman()),
                  onTap: () {
                    inAppBrowser.open(url: newsItem.url, options: {
                      "useShouldOverrideUrlLoading": true,
                      "useOnLoadResource": true
                    });
                  }
              ),

              new Divider(
                height: 2.0,
              ),
            ],
          );
        }
      },
    );
  }

  void _scrollListener() {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 50) {
      if (!loadingList) {
        loadingList = true;
        loadedPage = loadedPage + 1;
        setState(() => news.add(LoadingItem()));

        newsService.fetchNewsList(loadedPage).then((newsObject) {
          news.removeLast();
          setState(() => news.addAll(newsObject));
          loadingList = false;
        });
      }
    }
  }
}

class LoadingItem implements News {
  @override
  String get by => null;

  @override
  int get descendants => null;

  @override
  int get id => null;

  @override
  int get score => null;

  @override
  int get time => null;

  @override
  String get title => null;

  @override
  String get type => null;

  @override
  String get url => null;

  LoadingItem();

  @override
  getTimeDiffInHuman() {
    return null;
  }
}
