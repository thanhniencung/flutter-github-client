import 'package:flutter/material.dart';
import 'package:flutter_app_github_trending/pages/home_page.dart';
import 'package:flutter_app_github_trending/pages/signin_page.dart';
import 'package:flutter_app_github_trending/pages/signup_page.dart';
import 'package:flutter_app_github_trending/shared/spref.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      stick();
    });
  }

  void stick() async {
    var isLogged = await SPref.instance.get("token");
    if (isLogged != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Image.network(
          'https://www.techsignin.com/wp-content/uploads/2018/10/microsoft-hoan-thanh-thuong-vu-github.png'),
    );
  }
}
