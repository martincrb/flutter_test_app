import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_test_app/RandomWordsWidget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
}