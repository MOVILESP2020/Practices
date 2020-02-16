import 'package:flutter/material.dart';
import 'package:practice_one/colors.dart';

class ThemeUtil {
  static ThemeData createAppTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: blue2,
      primaryColor: blue1,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: gray1,
        textTheme: ButtonTextTheme.normal,
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: gray1,
      primaryIconTheme: base.iconTheme.copyWith(color: Colors.white),
    );
  }

  static TextStyle productTitleTheme() {
    return TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: blue2
    );
  }

  static TextStyle productDescriptionTheme() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: Colors.white,
      fontWeight: FontWeight.w500
    );
  }

  static TextStyle productPriceTheme() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        color: blue2,
        fontWeight: FontWeight.w500
    );
  }

  static TextStyle categoryTitleTheme() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 24,
        color: blue2,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle detailTitleTheme() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 24,
        color: blue2,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle detailDescriptionTheme() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 18,
        color: blue2,
    );
  }

  static TextStyle detailInfoTheme() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 12,
        color: blue2,
    );
  }

  static TextStyle detailPriceTheme() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 28,
        color: blue2,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle itemCartTitle() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: blue2,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle itemCartDescription() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle itemCartQty() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: blue1,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle itemCartPrice() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: blue2,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle paymentDialogTitle() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: blue1,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle paymentDialogSubtitle() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 12,
        color: gray2,
        fontWeight: FontWeight.bold
    );
  }

  static TextStyle paymentDialogMessage() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 12,
        color: gray2,
    );
  }

  static TextStyle paymentDialogButton() {
    return TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        color: blue1,
        fontWeight: FontWeight.bold
    );
  }

}
