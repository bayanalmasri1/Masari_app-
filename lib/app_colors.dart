import 'package:flutter/material.dart';

class AppColors {
  static const deepNavy = Color(0xFF081630); // #081630
  static const tealDark = Color(0xFF125358); // #125358
  static const teal = Color(0xFF3B878C); // #3B878C
  static const lightGray = Color(0xFFC2C3C5); // #C2C3C5
  static const pale = Color(0xFFEBEBED); // #EBEBED

  static const onPrimary = Colors.white;

  static LinearGradient primaryGradient = LinearGradient(
    colors: [teal, tealDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxShadow softShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 12,
    offset: Offset(0, 6),
  );
}
