import 'dart:core';

class Formatter {
  static String currencyFormat(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }
}