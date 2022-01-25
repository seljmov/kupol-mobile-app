import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

final kNotPrimaryButtonTheme = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      side: BorderSide(
        color: secondaryColor,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);

final primaryColor = Color(0xFFFFCD1A);
final secondaryMaterialColor = MaterialColor(
  secondaryColor.value,
  getSwatch(secondaryColor),
);
final secondaryColor = Color(0xFF02AFDD);
final darkColor = Color(0xFF262626);
final hintColor = Color(0xFFC0C0C0);
final underlineInputBorderPrimary = UnderlineInputBorder(
  borderSide: BorderSide(color: primaryColor),
);
final secondaryGreyColor = Color(0xFFE5E5E5);

final lightDisableColor = Color(0xFFF5F5F5);
final lightTextPrimaryColor = darkColor;
final lightTextSecondaryColor = Color(0xFF888888);
final lightTextDisableColor = lightDisableColor;

final darkDisableColor = Color(0xFF333333);
final darkTextPrimaryColor = Colors.white;
final darkTextSecondaryColor = Color(0xFF888888);
final darkTextDisableColor = darkDisableColor;

var lightThemeData = new ThemeData(
  primaryColor: primaryColor,
  primaryColorDark: primaryColor,
  primaryColorLight: primaryColor,
  primarySwatch: secondaryMaterialColor,
  secondaryHeaderColor: secondaryColor,
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  brightness: Brightness.light,
  hintColor: hintColor,
  fontFamily: "OpenSans",
  focusColor: primaryColor,
  disabledColor: lightDisableColor,
  indicatorColor: secondaryColor,
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: secondaryColor),
    ),
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
      color: lightTextPrimaryColor,
    ),
    bodyText1: TextStyle(
      color: lightTextPrimaryColor,
    ),
    bodyText2: TextStyle(
      color: lightTextSecondaryColor,
    ),
  ).apply(fontFamily: "OpenSans"),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: secondaryColor,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: Colors.white,
    foregroundColor: darkColor,
    elevation: 0,
    centerTitle: true,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: secondaryColor,
    unselectedLabelColor: lightTextSecondaryColor,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.white,
    disabledActionTextColor: lightDisableColor,
    behavior: SnackBarBehavior.floating,
    contentTextStyle: TextStyle(
      color: darkColor,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: secondaryGreyColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all<double?>(0),
      textStyle: MaterialStateProperty.all<TextStyle?>(
        TextStyle(
          fontSize: 16,
          color: darkColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(darkColor),
      minimumSize: MaterialStateProperty.all<Size>(Size(360.0, 50.0)),
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
  primaryColorDark: primaryColor,
  primaryColorLight: primaryColor,
  primarySwatch: secondaryMaterialColor,
  secondaryHeaderColor: secondaryColor,
  scaffoldBackgroundColor: darkColor,
  brightness: Brightness.dark,
  hintColor: hintColor,
  fontFamily: "OpenSans",
  focusColor: primaryColor,
  disabledColor: darkDisableColor,
  indicatorColor: secondaryColor,
  textTheme: TextTheme(
    headline6: TextStyle(
      color: darkTextPrimaryColor,
    ),
    bodyText1: TextStyle(
      color: darkTextPrimaryColor,
    ),
    bodyText2: TextStyle(
      color: darkTextSecondaryColor,
    ),
  ).apply(fontFamily: "OpenSans"),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: secondaryColor,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: darkColor,
    foregroundColor: darkTextPrimaryColor,
    elevation: 0,
    centerTitle: true,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: secondaryColor,
    unselectedLabelColor: darkTextSecondaryColor,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: darkDisableColor,
    behavior: SnackBarBehavior.floating,
    contentTextStyle: TextStyle(
      color: darkTextPrimaryColor,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xFF4F4F4F),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all<double?>(0),
      textStyle: MaterialStateProperty.all<TextStyle?>(
        TextStyle(
          fontSize: 16,
          color: darkColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      foregroundColor: MaterialStateProperty.all<Color>(darkColor),
      minimumSize: MaterialStateProperty.all<Size>(Size(360.0, 50.0)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    ),
  ),
);
