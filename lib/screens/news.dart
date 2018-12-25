import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackernews/widgets/darwer_widget.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<String> litems = ["1", "2", "Third", "4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new DrawerWidget(),
        appBar: AppBar(
          title: Text('News'),
        ),
        body: new ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemExtent: 20.0,
          itemCount: litems.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(litems[index]);
          },
        ));
  }
}
