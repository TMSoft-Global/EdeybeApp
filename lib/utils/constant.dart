import 'package:flutter/material.dart';

class Constants {
  static const mainColor = Color(0xFFFCB800);
  static const highlightText = Color(0xFF);
  static const ratingBG = Color(0xFFFFA500);
  static var themeGreyLight = Colors.grey[100];
  static var themeBlueLight = Color(0xFF1890ff);
  static var themeGreen = Color(0xFF0066cc);
  static var themeBlue = Color(0xFF0066cc);
  static var boxShadow = Colors.grey[300];
  static var disabledColor = Color(0xFFC5C9D3);
  static var themeGreyDark = Colors.grey[500];
  static const lightGreen = Color(0xFF11BF5A);
  static const green = Color(0xFF039C43);
  static const dark = Color(0xFF333333);
  static const red = Color(0xFFFF4D00);
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
