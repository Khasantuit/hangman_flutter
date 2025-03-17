import 'package:flutter/material.dart';
import 'game_screen.dart';


void main() {
  runApp(HangmanApp());
}

class HangmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Виселица',
      theme: ThemeData.dark(),
      home: GameScreen(),
    );
  }
}
