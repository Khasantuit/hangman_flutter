import 'package:flutter/material.dart';
import 'dart:math';
import 'words.dart'; // So‘zlar ro‘yxati (word, type, first_letter)
import 'main.dart';
import 'hangman_painter.dart';

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
      body: Container(
        width: double.infinity, // ✅ Rasmni to‘liq ekranga sig‘dirish
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"), // ✅ Orqa fon rasmi
            fit: BoxFit.cover, // ✅ Rasmni ekranga to‘liq joylashtirish
            alignment: Alignment.center, // ✅ Rasmni to‘g‘ri joylash uchun
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              CustomPaint(
                size: Size(200, 300),
                painter: HangmanPainter(wrongGuesses),
              ),
              SizedBox(height: 20),
              Text(
                'Soʻz turkumi: ${currentWord['type']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),
              ),
              SizedBox(height: 10),
              Text(
                'Bosh harf: ${currentWord['first_letter']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue),
              ),
              SizedBox(height: 20),
              Text(
                currentWord['word']!.split('').map((char) => guessedLetters.contains(char) ? char : '_').join(' '),
                style: TextStyle(fontSize: 24, letterSpacing: 5),
              ),
              SizedBox(height: 20),
              Wrap(
                children: 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЧШЎЪЭЮЯҚҒҲ'.split('').map((letter) {
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
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
