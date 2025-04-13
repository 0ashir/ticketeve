import 'package:flutter/material.dart';
import 'package:event_right_scanner/DeviceUtil/palette.dart';

class AppThemes {
  AppThemes._();

  static const Color _lightPrimaryColor = Palette.black;
  static const Color _lightPrimaryVariantColor = Palette.white;
  static const Color _lightSecondaryColor = Palette.green;
  static const Color _lightOnPrimaryColor = Palette.black;
  static const Color _lightOnSecondaryColor = Palette.darkGrey;
  static const Color _lightButtonPrimaryColor = Palette.primary;
  static const Color _lightAppBarColor = Palette.white;
  static const Color _lightIconColor = Palette.black;
  static const Color _lightSnackBarBackgroundErrorColor = Colors.redAccent;

  static const TextStyle _lightScreenHeadingTextStyle =
      TextStyle(fontSize: 18.0, color: _lightOnPrimaryColor, fontWeight: FontWeight.w500);
  static const TextStyle _lightScreenTaskNameTextStyle = TextStyle(fontSize: 16.0, color: _lightOnPrimaryColor);
  static const TextStyle _lightScreenTaskDurationTextStyle = TextStyle(fontSize: 14.0, color: _lightOnSecondaryColor);
  static const TextStyle _lightScreenButtonTextStyle = TextStyle(fontSize: 18.0, color: _lightOnPrimaryColor);
  static const TextStyle _lightScreenCaptionTextStyle = TextStyle(fontSize: 12.0, color: _lightOnPrimaryColor);
  static const TextStyle _lightButtonTextStyle = TextStyle(fontSize: 16.0, color: _lightAppBarColor);

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightScreenHeadingTextStyle,
    headlineMedium: _lightScreenTaskNameTextStyle,
    bodyLarge: _lightScreenTaskNameTextStyle,
    bodyMedium: _lightScreenTaskDurationTextStyle,
    labelLarge: _lightScreenButtonTextStyle,
    titleMedium: _lightScreenTaskNameTextStyle,
    titleSmall: _lightScreenTaskDurationTextStyle,
    bodySmall: _lightScreenCaptionTextStyle,
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryVariantColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _lightButtonPrimaryColor, extendedTextStyle: _lightButtonTextStyle),
    textTheme: _lightTextTheme,
    appBarTheme: const AppBarTheme(
      color: _lightButtonPrimaryColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(backgroundColor: _lightSnackBarBackgroundErrorColor),
    iconTheme: const IconThemeData(
      color: _lightIconColor,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: _lightAppBarColor),
    buttonTheme: const ButtonThemeData(buttonColor: _lightButtonPrimaryColor, textTheme: ButtonTextTheme.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(backgroundColor: _lightButtonPrimaryColor, textStyle: _lightScreenTaskNameTextStyle),
    ),
    unselectedWidgetColor: _lightPrimaryColor,
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: _lightPrimaryColor,
        labelStyle: TextStyle(
          color: _lightPrimaryColor,
        )),
  );

  ///constants color range for dark theme
  static const Color _darkPrimaryColor = Palette.white;
  static const Color _darkPrimaryVariantColor = Palette.black;
  static const Color _darkSecondaryColor = Palette.white;
  static const Color _darkOnPrimaryColor = Palette.white;
  static const Color _darkOnSecondaryColor = Palette.white;
  static const Color _darkButtonPrimaryColor = Palette.primary;
  static const Color _darkAppBarColor = Palette.primary;
  static const Color _darkIconColor = Palette.white;
  static const Color _darkSnackBarBackgroundErrorColor = Colors.redAccent;

  ///text theme for dark theme
  static const TextStyle _darkScreenHeadingTextStyle =
      TextStyle(fontSize: 18.0, color: _darkOnPrimaryColor, fontWeight: FontWeight.w500);
  static const TextStyle _darkScreenTaskNameTextStyle = TextStyle(fontSize: 16.0, color: _darkOnSecondaryColor);
  static const TextStyle _darkScreenSubTitleTextStyle = TextStyle(fontSize: 16.0, color: _darkPrimaryVariantColor);
  static const TextStyle _darkScreenTaskDurationTextStyle = TextStyle(fontSize: 14.0, color: _darkOnPrimaryColor);
  static const TextStyle _darkScreenButtonTextStyle = TextStyle(fontSize: 18.0, color: _darkOnPrimaryColor);
  static const TextStyle _darkScreenCaptionTextStyle = TextStyle(fontSize: 12.0, color: _darkOnPrimaryColor);
  static const TextStyle _darkButtonTextStyle = TextStyle(fontSize: 16.0, color: _darkAppBarColor);

  ///text theme dark for assign in theme
  static const TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkScreenHeadingTextStyle,
    headlineMedium: _darkScreenTaskNameTextStyle,
    bodyLarge: _darkScreenTaskNameTextStyle,
    bodyMedium: _darkScreenTaskDurationTextStyle,
    labelLarge: _darkScreenButtonTextStyle,
    titleMedium: _darkScreenSubTitleTextStyle,
    titleSmall: _darkScreenTaskDurationTextStyle,
    bodySmall: _darkScreenCaptionTextStyle,
  );

  ///the dark theme
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryVariantColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _darkButtonPrimaryColor, extendedTextStyle: _darkButtonTextStyle),
    textTheme: _darkTextTheme,
    appBarTheme: const AppBarTheme(
      color: _darkAppBarColor,
      iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    ),
    colorScheme: const ColorScheme.light(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(backgroundColor: _darkSnackBarBackgroundErrorColor),
    iconTheme: const IconThemeData(
      color: _darkIconColor,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: _darkAppBarColor),
    buttonTheme: const ButtonThemeData(buttonColor: _darkButtonPrimaryColor, textTheme: ButtonTextTheme.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(backgroundColor: _darkButtonPrimaryColor, textStyle: _darkScreenTaskNameTextStyle),
    ),
    unselectedWidgetColor: _darkAppBarColor,
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: _darkPrimaryColor,
        labelStyle: TextStyle(
          color: _darkPrimaryColor,
        )),
  );
}
