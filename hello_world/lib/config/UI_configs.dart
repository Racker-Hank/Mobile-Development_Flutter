import 'package:flutter/material.dart';

class UIConfig {
  static double borderRadius = 8;

  static Color primaryColor = const Color(0xFF1CA0E3);
  static Color accentColor = const Color(0xFF086FCC);
  static Color white = const Color(0xFFFFFFFF);
  static Color screenBackgroundColor = const Color(0xFFF2F5FA);
  static Color darkGrey = const Color(0xFF79747E);

  static TextStyle titleLargeTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22,
    height: 1.3,
  );
  static TextStyle bodyMediumTextStyle = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    height: 1.4,
    letterSpacing: .25,
    color: Color(0xFF49454F),
  );
  static TextStyle buttonTextStyle = const TextStyle(
    fontFamily: 'Nunito Sans',
    fontSize: 18,
    height: 1.6,
    color: Color(0xFFFFFFFF),
  );
}
