import 'package:flutter/material.dart';

class CustomAppTheme {
  /* Color */
  static const kPrimaryColor = Color(0xFF6C5ECF);
  static const kSecondaryColor = Color(0xFF38ABBE);
  static const kAlertColor = Color(0xFFED6363);
  static const kDodgerBlue = Color(0xFF2C96F1);

  static const kGhostWhite = Color(0xFFF8F5FA);
  static const kPrimaryTextColor = Color(0xFFF1F0F2);
  static const kSecondaryTextColor = Color(0xFF999999);
  static const kStrokeColor = Color(0xFFE1E1E1);

  /* Icon Assets */
  static const kIconLogo = 'assets/images/nike_logo.png';
  

  static MaterialColor getMaterialColor(Color color) {
    final red = color.red;
    final green = color.green;
    final blue = color.blue;
    final alpha = color.alpha;

    final shades = <int, Color>{
      50: Color.fromARGB(alpha, red, green, blue),
      100: Color.fromARGB(alpha, red, green, blue),
      200: Color.fromARGB(alpha, red, green, blue),
      300: Color.fromARGB(alpha, red, green, blue),
      400: Color.fromARGB(alpha, red, green, blue),
      500: Color.fromARGB(alpha, red, green, blue),
      600: Color.fromARGB(alpha, red, green, blue),
      700: Color.fromARGB(alpha, red, green, blue),
      800: Color.fromARGB(alpha, red, green, blue),
      900: Color.fromARGB(alpha, red, green, blue),
    };

    return MaterialColor(color.value, shades);
  }
}
