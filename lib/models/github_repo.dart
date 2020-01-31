/*
   "name": "brentsimmons/NetNewsWire",
    "url": "/brentsimmons/NetNewsWire",
    "description": "RSS reader for macOS.",
    "color": "#ffac45",
    "lang": "Swift",
    "fork": "195",
    "stars": "2,655",
    "starsToday": "110 stars today",
    "buildBy": "https://avatars0.githubusercontent.com/u/1297121?s=40&v=4,https://avatars3.githubusercontent.com/u/16448027?s=40&v=4,https://avatars2.githubusercontent.com/u/12581273?s=40&v=4,https://avatars3.githubusercontent.com/u/567949?s=40&v=4,https://avatars2.githubusercontent.com/u/14606?s=40&v=4",
    "bookmarked": false
*/
class GithubRepo {
  String name;
  String url;
  String description;
  String color;
  String lang;
  String fork;
  String stars;
  String starsToday;
  List<String> contributors;
  bool bookmarked;

  GithubRepo({
    this.name,
    this.url,
    this.description,
    this.color,
    this.lang,
    this.fork,
    this.stars,
    this.starsToday,
    this.contributors,
    this.bookmarked,
  });

  GithubRepo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'],
        description = json['description'],
        color = json['color'],
        lang = json['lang'],
        fork = json['fork'],
        stars = json['stars'],
        starsToday = json['starsToday'],
        contributors = json['contributors'].cast<String>(),
        bookmarked = json['bookmarked'];

  static List<GithubRepo> parseRepoList(map) {
    var list = map['data'] as List;
    return list.map((repo) => GithubRepo.fromJson(repo)).toList();
  }
}
