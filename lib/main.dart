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
      theme: ThemeData(
        // primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Color(0xFFF5E1B3), // Qog‘oz fon rangi
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Courier', color: Colors.black),
        ),
      ),
      home: GameScreen(),
    );
  }
}
