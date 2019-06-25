import 'dart:async';
import 'dart:convert';
import 'package:hackernews/data/news.dart';
import 'package:http/http.dart' as http;

class BestStoriesService {
  var bestStoryList = [];

  Future<List<News>> fetchBestStoryList(page) async {
    var skipItems = page * 20;
    if (skipItems >= 500) {
      throw Exception('End of post');
    }

    return this.getBestStoryList(skipItems);
  }

  Future<List<News>> getBestStoryList(skipItems) async {
    final response = await http.get(
        'https://hacker-news.firebaseio.com/v0/beststories.json?print=pretty');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var responseNewsList = json.decode(response.body);
      bestStoryList = responseNewsList as List;

      var stories = bestStoryList
          .skip(skipItems)
          .take(20)
          .map((s) => this.fetchNewsDetails(s.toString()));

      return Future.wait(stories).then((List<News> responses) {
        return responses.toList();
      });

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load best stories');
    }
  }

  Future<News> fetchNewsDetails(id) async {
    final response = await http.get(
        'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return News.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
