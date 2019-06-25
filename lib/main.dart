import 'package:hackernews/services/best_stories.dart';
import 'package:hackernews/services/news.dart';
import 'routes.dart';

NewsService newsService = new NewsService();
BestStoriesService bestStoriesService = new BestStoriesService();

void main() {
  new Routes();
}
