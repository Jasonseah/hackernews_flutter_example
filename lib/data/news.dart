class News {
  final String by;
  final int descendants;
  final int id;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  News(
      {this.by,
      this.descendants,
      this.id,
      this.score,
      this.time,
      this.title,
      this.type,
      this.url});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      by: json['by'],
      descendants: json['descendants'],
      id: json['id'],
      score: json['score'],
      time: json['time'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }

  getTimeDiffInHuman(){
    if(this.time == null){
      return null;
    }

    final time = new DateTime.fromMillisecondsSinceEpoch(this.time * 1000);
    final currentTime = new DateTime.now();
    final differentTime = currentTime.difference(time);

    return differentTime.inHours.toString() + ' hours ago';
  }

//  by: "ajmmertens",
//  descendants: 2,
//  id: 18787777,
//  kids: [
//  18787840,
//  18787826
//  ],
//  score: 10,
//  time: 1546150951,
//  title: "Show HN: Bake – A tool that makes building C/C++ code effortless",
//  type: "story",
//  url: "https://www.github.com/SanderMertens/bake"
}
