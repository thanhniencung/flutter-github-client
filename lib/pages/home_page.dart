import 'package:flutter/material.dart';
import 'package:flutter_app_github_trending/pages/bookmark_repos.dart';
import 'package:flutter_app_github_trending/pages/profile_page.dart';
import 'package:flutter_app_github_trending/pages/signin_page.dart';
import 'package:flutter_app_github_trending/pages/trending_repos.dart';
import 'package:flutter_app_github_trending/shared/spref.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    TrendingRepos(),
    BookmarkRepos(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Github Trending',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await SPref.instance.set("token", null);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                  (Route<dynamic> route) => false,
                );
              })
        ],
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Trending'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            title: Text('Bookmarks'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
