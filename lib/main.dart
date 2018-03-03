import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_test_app/GithubUserDetailWidget.dart';
import 'package:flutter_test_app/GithubUsersWidget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Github Users',
      home: new GithubUsers(),
      onGenerateRoute: _getRoute,
      theme: new ThemeData(
        primaryColor: Colors.blueGrey,
      ),
    );
  }

  Route<Null> _getRoute(RouteSettings settings) {
    // Routes, by convention, are split on slashes, like filesystem paths.
    final List<String> path = settings.name.split('/');
    // We only support paths that start with a slash, so bail if
    // the first component is not empty:
    if (path[0] != '')
      return null;
    // If the path is "/stock:..." then show a stock page for the
    // specified stock symbol.
    if (path[1].startsWith('detail:')) {
      // We don't yet support subpages of a stock, so bail if there's
      // any more path components.
      if (path.length != 2)
        return null;
      // Extract the symbol part of "stock:..." and return a route
      // for that symbol.
      final String symbol = path[1].substring(7);
      return new MaterialPageRoute<Null>(
        settings: settings,
        builder: (BuildContext context) => new GithubUserDetail(symbol),
      );
    }
    // The other paths we support are in the routes table.
    return null;
  }
}