import 'package:flutter/material.dart';

Map<int, Color> getSwatch(Color color) {
  final hslColor = HSLColor.fromColor(color);
  final lightness = hslColor.lightness;
  final lowDivisor = 6;
  final highDivisor = 5;
  final lowStep = (1.0 - lightness) / lowDivisor;
  final highStep = lightness / highDivisor;

  return {
    50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
    100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
    200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
    300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
    400: (hslColor.withLightness(lightness + lowStep)).toColor(),
    500: (hslColor.withLightness(lightness)).toColor(),
    600: (hslColor.withLightness(lightness - highStep)).toColor(),
    700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
    800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
    900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
  };
}

final primaryColor = Color(0xFFFFCD1A);
final primaryMaterialColor = MaterialColor(
  primaryColor.value,
  getSwatch(primaryColor),
);
final darkColor = Color(0xFF262626);
final hintColor = Color(0xFFC0C0C0);
final disableColor = Color(0xFFF5F5F5);
final underlineInputBorderPrimary = UnderlineInputBorder(
  borderSide: BorderSide(color: primaryColor),
);

var lightThemeData = new ThemeData(
  primaryColor: primaryColor,
  primaryColorDark: primaryColor,
  primaryColorLight: primaryColor,
  primarySwatch: primaryMaterialColor,
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  brightness: Brightness.light,
  hintColor: hintColor,
  fontFamily: "Open Sans",
  focusColor: primaryColor,
  disabledColor: disableColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(darkColor),
      fixedSize: MaterialStateProperty.all<Size>(Size(360.0, 50.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    ),
  ),
);

var darkThemeData = ThemeData(
  primaryColor: primaryColor,
  textTheme: new TextTheme(button: TextStyle(color: Colors.black54)),
  scaffoldBackgroundColor: Color(0xFF262626),
  brightness: Brightness.dark,
);
