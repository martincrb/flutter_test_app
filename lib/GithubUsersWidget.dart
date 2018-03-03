import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class GithubUsers extends StatefulWidget {
  @override
  createState() => new GithubUsersState();
}

class GithubUsersState extends State<GithubUsers> {
  final _users = <Map<String, dynamic>>[]; //_ in the name makes field private


  Future<List> _getGithubUsers() async {
    var response = await http.get(
      Uri.parse("https://api.github.com/users?since=135")
    );

    List users = JSON.decode(response.body);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Github Users'),
      ),
      body: _buildUsersList(),
    );
  }


  Widget _buildUsersList() {
    var _users = _getGithubUsers();
    return new FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData)
          return new Container();
        List content = snapshot.data;
        return _buildListInternal(content);
      },
      future: _users,
    );
  }

  Widget _buildListInternal(List list) {
    return new ListView.builder(
        padding: const EdgeInsets.all(12.0),
        // The itemBuilder callback is called once per suggested word pairing,
        // and places each suggestion into a ListTile row.
        // For even rows, the function adds a ListTile row for the word pairing.
        // For odd rows, the function adds a Divider widget to visually
        // separate the entries. Note that the divider may be difficult
        // to see on smaller devices.
        itemBuilder: (context, i) {
          // Add a one-pixel-high divider widget before each row in theListView.
          if (i.isOdd) return new Divider();

          // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings in the ListView,
          // minus the divider widgets.
          final index = i ~/ 2;
          // If you've reached the end of the available word pairings...
          return _buildRow(list[index]);
        },
      itemCount: list.length,
    );
  }
  Widget _buildRow(dynamic elem) {
    return new ListTile(
      title: new Text(
        elem["login"]
      ),
      leading: new ClipOval(
        child: new Image.network(elem["avatar_url"])
      ),
      subtitle: new Text(elem["url"]),
    );
  }
}