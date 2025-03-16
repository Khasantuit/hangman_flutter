import 'package:flutter/material.dart';
import 'hangman_painter.dart';
import 'words.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String word;
  List<String> guessedLetters = [];
  int wrongGuesses = 0;
  final int maxWrongGuesses = 6;

  @override
  void initState() {
    super.initState();
    word = getRandomWord();
  }

  void guessLetter(String letter) {
    setState(() {
      if (word.contains(letter)) {
        guessedLetters.add(letter);
      } else {
        wrongGuesses++;
      }
    });

    if (isGameWon()) {
      showResultDialog('Siz yutdingiz!', Colors.green);
    } else if (wrongGuesses >= maxWrongGuesses) {
      showResultDialog('Siz yutqazdingiz! Soʻz: $word', Colors.red);
    }
  }

  bool isGameWon() {
    return word.split('').every((char) => guessedLetters.contains(char));
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
              resetGame();
            },
            child: Text('Qayta boshlash'),
          )
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      word = getRandomWord();
      guessedLetters.clear();
      wrongGuesses = 0;
    });
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
            word.split('').map((char) => guessedLetters.contains(char) ? char : '_').join(' '),
            style: TextStyle(fontSize: 24, letterSpacing: 5),
          ),
          SizedBox(height: 20),
          Wrap(
            children: 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'.split('').map((letter) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: guessedLetters.contains(letter) || wrongGuesses >= maxWrongGuesses
                      ? null
                      : () => guessLetter(letter),
                  child: Text(letter, style: TextStyle(fontSize: 18)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
