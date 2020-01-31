import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_github_trending/models/user.dart';
import 'package:flutter_app_github_trending/network/github_api.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _fullNameTxtController =
      TextEditingController(text: '');
  final TextEditingController _emailTxtController =
      TextEditingController(text: '');

  final StreamController _streamController = StreamController<User>();
  bool enableEditProfile = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GithubApi().profile().then(
      (user) {
        _streamController.sink.add(user);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          _fullNameTxtController.text = snapshot.data.fullName;
          _emailTxtController.text = snapshot.data.email;

          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _fullNameTxtController,
                  enabled: enableEditProfile,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal),
                    ),
                    suffixIcon: Icon(Icons.info),
                    hintText: 'Full Name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailTxtController,
                  enabled: enableEditProfile,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal),
                    ),
                    suffixIcon: Icon(Icons.email),
                    hintText: 'Email',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 200,
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (enableEditProfile) {
                        // update profile
                        print(_fullNameTxtController.text);
                        print(_emailTxtController.text);

                        GithubApi()
                            .updateProfile(User(
                                fullName: _fullNameTxtController.text,
                                email: _emailTxtController.text))
                            .then(
                          (user) {
                            enableEditProfile = false;
                            _streamController.sink.add(user);
                          },
                        );
                      }
                      setState(() {
                        enableEditProfile = !enableEditProfile;
                      });
                    },
                    child: Text(
                      enableEditProfile ? 'Done' : 'Update Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
