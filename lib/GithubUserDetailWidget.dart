import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class GithubUserDetail extends StatefulWidget {
  GithubUserDetail(this.userid);

  final String userid;

  @override
  createState() => new GithubUserState(userid);
}

class GithubUserState extends State<GithubUserDetail>{

  GithubUserState(this.userid);
  final String userid;
  final _user = null; //_ in the name makes field private

  Future<Map<String, dynamic>> _getGithubUser(userid) async {
    var response = await http.get(
        Uri.parse("https://api.github.com/users/$userid")
    );

    var user = JSON.decode(response.body);
    print(user);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Github User'),
      ),
      body: _buildUserView(),
    );
  }

  Widget _buildUserView() {
    var _user = _getGithubUser(userid);
    return new FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData)
          return new Center(
            child: new CircularProgressIndicator(),
          );
        return _buildUserViewInternal(snapshot.data);
      },
      future: _user,
    );
  }

  Widget _buildUserViewInternal(data) {
    var _public_repos = data["public_repos"];
    var _gists = data["public_gists"];
    var _followers = data["followers"];
    var _following = data["following"];
    return new Column(
      children: [
        new Container(
          child: new ClipOval(
            child: new Image.network(data["avatar_url"]),
          ),
          margin: const EdgeInsets.all(10.0),
          width: 60.0,
          height: 60.0,
        ),
        new Text(data["login"]),
        new Text(data["name"]),
        new Center(
          child: new Row(
              children: [
                new Text("Repos: $_public_repos"),
                new Text("Gists: $_gists"),
                new Text("Followers: $_followers"),
                new Text("Following: $_following"),
              ]
          )
        )
      ]
    );
  }
}