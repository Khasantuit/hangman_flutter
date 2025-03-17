import 'package:flutter/material.dart';

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
