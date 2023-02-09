import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: Color.fromARGB(255, 23, 86, 167),
    secondaryHeaderColor: const Color.fromARGB(255, 70, 79, 151),
    hintColor: Color.fromARGB(255, 25, 30, 61),
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Color.fromARGB(255, 216, 218, 221),
    fontFamily: 'Optima',
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      headline2: TextStyle(
        color: Color.fromRGBO(83, 109, 254, 1),
        fontWeight: FontWeight.bold,
        fontSize: 27,
      ),
      headline3: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline5: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyText2: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    ),
  );
}
