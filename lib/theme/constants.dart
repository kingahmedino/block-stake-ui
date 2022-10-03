// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const primaryColor = Color(0xff009dbf);
const darkBGColor = Color(0xff06283D);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'GTWalsheimPro',
  primarySwatch: createMaterialColor(primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryColor),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontFamily: 'GTWalsheimPro'),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontFamily: 'GTWalsheimPro'),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
      ),
      side: MaterialStateProperty.all(
        BorderSide(color: Colors.black),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: primaryColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 3.0,
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 3.0,
        color: primaryColor,
      ),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'GTWalsheimPro',
  primarySwatch: createMaterialColor(primaryColor),
  scaffoldBackgroundColor: darkBGColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryColor),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontFamily: 'GTWalsheimPro'),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontFamily: 'GTWalsheimPro'),
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
      ),
      side: MaterialStateProperty.all(
        BorderSide(color: Colors.white),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 3.0,
        color: Colors.white,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 3.0,
        color: primaryColor,
      ),
    ),
  ),
);

toggleMode() {
  Get.changeThemeMode(
    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
  );

  if (Get.isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: darkBGColor,
        statusBarColor: darkBGColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
}
