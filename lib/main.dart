import 'package:flutter/material.dart';
import './ui/cat_list.dart';

void main() async {
  runApp(CatBoxApp());
}

class CatBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Ubuntu',
      ),
      home: CatList(),
    );
  }
}
