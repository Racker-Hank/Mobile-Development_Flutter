import 'package:flutter/material.dart';

class UIConfig {
  static BorderRadius borderRadius = BorderRadius.circular(8);

  static Color primaryColor = const Color(0xFF1CA0E3);
  static Color accentColor = const Color(0xFF086FCC);
  static Color tertiaryColor = const Color(0xFF5FFBF1);
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color screenBackgroundColor = const Color(0xFFF2F5FA);
  static Color darkGrey = const Color(0xFF79747E);

  static TextStyle titleLargeTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    height: 1.3,
    color: black,
  );
  static TextStyle bodyMediumTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 1.5,
    letterSpacing: .5,
    // color: Color(0xFF49454F),
    color: black,
  );
  static TextStyle buttonTextStyle = const TextStyle(
    fontFamily: 'Nunito Sans',
    fontSize: 18,
    height: 1.6,
    color: Color(0xFFFFFFFF),
  );
  static TextStyle textFieldInputTextStyle = TextStyle(
    fontFamily: 'Nunito Sans',
    fontSize: 18,
    height: 1.6,
    color: black,
  );
  static TextStyle indicationTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: primaryColor,
  );

  static String capitalize(String s) {
    var splitted = s.split(' ');
    String cap = '';
    for (var e in splitted) {
      if (e.isNotEmpty) {
        cap += e.trim()[0].toUpperCase() + e.trim().substring(1) + ' ';
      }
    }
    return cap.trim();
  }

  static void darkMode() {
    black = const Color(0xFFFFFFFF);
    white = const Color(0xFF000000);
    screenBackgroundColor = const Color(0xFFFFFFFF).withAlpha(230);
    accentColor = const Color(0xFFFFFFFF);
    darkGrey = const Color(0xFFA29AAC);
    titleLargeTextStyle = titleLargeTextStyle.copyWith(color: black);
    bodyMediumTextStyle = bodyMediumTextStyle.copyWith(color: black);
    textFieldInputTextStyle = textFieldInputTextStyle.copyWith(color: black);
  }
}
