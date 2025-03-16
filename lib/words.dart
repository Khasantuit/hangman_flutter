import 'dart:math';

final List<String> words = [
  'ПРИВЕТ', 'ФЛАТТЕР', 'ДЖАНГО', 'ТЕЛЕФОН', 'КОМПЬЮТЕР', 'ПРОГРАММА', 'КНИГА', 'ДОМ'
];

String getRandomWord() {
  return words[Random().nextInt(words.length)];
}
