import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackernews/data/news.dart';
import 'package:hackernews/main.dart';
import 'package:hackernews/widgets/adaptive_widget.dart';
import 'package:hackernews/widgets/in_app_brower.dart';

MyInAppBrowser inAppBrowser = new MyInAppBrowser();

class BestStoriesPage extends StatelessWidget {
  static const title = 'Best Stories';

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: bestStoriesService.fetchBestStoryList(0),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return new Text('No internet connection, please try again later');
            } else {
              return NewsList(news: snapshot.data);
            }
        }
      },
    );

    return AdaptivePageScaffold(
        title: 'Best Stories', child: new Scrollbar(child: futureBuilder));
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
          return new Center(
            child: Container(
              height: 100.0,
              padding: EdgeInsets.all(8.0),
              width: 100.0,
              child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()),
            ),
          );
        } else {
          return AdaptiveListView(
              newsItem: newsItem,
              onTap: () {
                inAppBrowser.open(url: newsItem.url, options: {
                  "useShouldOverrideUrlLoading": false,
                  "useOnLoadResource": false,
                  "hideUrlBar": true,
                });
              });
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

        bestStoriesService.fetchBestStoryList(loadedPage).then((newsObject) {
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
