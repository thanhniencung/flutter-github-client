import 'dart:async';
import 'dart:ffi';

import 'package:flutter_app_github_trending/models/github_repo.dart';
import 'package:flutter_app_github_trending/models/user.dart';
import 'package:flutter_app_github_trending/network/github_service.dart';

class GithubApi {
  Future<List<GithubRepo>> githubTrending() async {
    var c = Completer<List<GithubRepo>>();
    try {
      var response = await GithubService.instance.dio.get(
        '/github/trending',
      );
      var result = GithubRepo.parseRepoList(response.data);
      c.complete(result);
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<Void> bookmark(String repoName) async {
    var c = Completer<Void>();
    try {
      var response = await GithubService.instance.dio.post(
        '/bookmark/add',
        data: {
          'repo': repoName,
        },
      );
      if (response.statusCode == 200) {
        c.complete();
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<Void> delBookmark(String repoName) async {
    var c = Completer<Void>();
    try {
      var response = await GithubService.instance.dio.delete(
        '/bookmark/delete',
        data: {
          'repo': repoName,
        },
      );
      if (response.statusCode == 200) {
        c.complete();
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<GithubRepo>> listBookmarks() async {
    var c = Completer<List<GithubRepo>>();
    try {
      var response = await GithubService.instance.dio.get('/bookmark/list');
      if (response.statusCode == 200) {
        var result = GithubRepo.parseRepoList(response.data);
        c.complete(result);
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<User> profile() async {
    var c = Completer<User>();
    try {
      var response = await GithubService.instance.dio.get('/user/profile');
      if (response.statusCode == 200) {
        var result = User.fromJson(response.data['data']);
        c.complete(result);
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<User> updateProfile(User user) async {
    var c = Completer<User>();
    try {
      var response = await GithubService.instance.dio.put(
        '/user/profile/update',
        data: {
          'fullName': user.fullName,
          'email': user.email,
        },
      );
      var result = User.fromJson(response.data['data']);
      c.complete(result);
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<User> signIn(String email, String pass) async {
    var c = Completer<User>();
    try {
      var response = await GithubService.instance.dio.post(
        '/user/sign-in',
        data: {
          'email': email,
          'password': pass,
        },
      );
      var result = User.fromJson(response.data['data']);
      c.complete(result);
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<User> signUp(String email, String pass, String fullName) async {
    var c = Completer<User>();
    try {
      var response = await GithubService.instance.dio.post(
        '/user/sign-up',
        data: {
          'email': email,
          'password': pass,
          'fullName': fullName,
        },
      );
      var result = User.fromJson(response.data['data']);
      c.complete(result);
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
