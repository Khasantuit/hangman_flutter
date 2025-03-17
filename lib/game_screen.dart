import 'package:flutter/material.dart';
import 'dart:math';
import 'words.dart'; // So‘zlar alohida faylda saqlanadi

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Map<String, String> currentWord;
  List<String> guessedLetters = [];
  int wrongGuesses = 0;
  final int maxWrongGuesses = 6;

  @override
  void initState() {
    super.initState();
    pickRandomWord();
  }

  void pickRandomWord() {
    setState(() {
      currentWord = words[Random().nextInt(words.length)];
      guessedLetters.clear();
      wrongGuesses = 0;
    });
  }

  void guessLetter(String letter) {
    setState(() {
      if (currentWord['word']!.contains(letter)) {
        guessedLetters.add(letter);
      } else {
        wrongGuesses++;
      }
    });

    if (isGameWon()) {
      showResultDialog('Siz yutdingiz!', Colors.green);
    } else if (wrongGuesses >= maxWrongGuesses) {
      showResultDialog('Siz yutqazdingiz! Soʻz: ${currentWord['word']}', Colors.red);
    }
  }

  bool isGameWon() {
    return currentWord['word']!.split('').every((char) => guessedLetters.contains(char));
  }

  void showResultDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message, style: TextStyle(color: color)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              pickRandomWord();
            },
            child: Text('Qayta boshlash'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Виселица')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            size: Size(200, 300),
            painter: HangmanPainter(wrongGuesses),
          ),
          SizedBox(height: 20),
          Text(
            'Soʻz turkumi: ${currentWord['type']}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          SizedBox(height: 10),
          Text(
            'Bosh harf: ${currentWord['first_letter']}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          SizedBox(height: 20),
          Text(
            currentWord['word']!.split('').map((char) => guessedLetters.contains(char) ? char : '_').join(' '),
            style: TextStyle(fontSize: 24, letterSpacing: 5, fontFamily: 'Courier', color: Colors.black),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 8, // Harflarni sig‘dirish uchun 8 ta ustun
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              padding: EdgeInsets.all(10),
              children: 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЧШЎЪЭЮЯҚҒҲ'.split('').map((letter) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: guessedLetters.contains(letter) || wrongGuesses >= maxWrongGuesses
                      ? null
                      : () => guessLetter(letter),
                  child: Text(letter, style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Courier')),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class HangmanPainter extends CustomPainter {
  final int wrongGuesses;
  HangmanPainter(this.wrongGuesses);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.black;

    // O‘lim maydonini chizish
    canvas.drawLine(Offset(20, size.height), Offset(120, size.height), paint);
    canvas.drawLine(Offset(70, size.height), Offset(70, 20), paint);
    canvas.drawLine(Offset(70, 20), Offset(150, 20), paint);
    canvas.drawLine(Offset(150, 20), Offset(150, 40), paint);

    if (wrongGuesses > 0) canvas.drawCircle(Offset(150, 60), 20, paint); // Bosh
    if (wrongGuesses > 1) canvas.drawLine(Offset(150, 80), Offset(150, 140), paint); // Tana
    if (wrongGuesses > 2) canvas.drawLine(Offset(150, 90), Offset(130, 120), paint); // Chap qo‘l
    if (wrongGuesses > 3) canvas.drawLine(Offset(150, 90), Offset(170, 120), paint); // O‘ng qo‘l
    if (wrongGuesses > 4) canvas.drawLine(Offset(150, 140), Offset(130, 180), paint); // Chap oyoq
    if (wrongGuesses > 5) canvas.drawLine(Offset(150, 140), Offset(170, 180), paint); // O‘ng oyoq
  }

  @override
  bool shouldRepaint(HangmanPainter oldDelegate) => true;
}