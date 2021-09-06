import 'package:edeybe/utils/constant.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final themeLight = ThemeData(
    primaryColor: Constants.mainColor,
    fontFamily: 'Arabic',
    textTheme: TextTheme(
      headline5: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 28,
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
    ),
    buttonTheme: ButtonThemeData(
      height: 44,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Constants.mainColor,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final themeDark = ThemeData(
    primaryColor: Constants.mainColor,
    fontFamily: 'Arabic',
    textTheme: TextTheme(
      headline5: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 28,
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
    ),
    buttonTheme: ButtonThemeData(
      height: 44,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Constants.mainColor,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
