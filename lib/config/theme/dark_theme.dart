import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youapp_challenge/config/theme/palette.dart';
import 'package:youapp_challenge/config/theme/sub_theme_mixin.dart';

const Color mainTextColorDark = Colors.white;

class DarkTheme with SubThemeMixin {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark(useMaterial3: true);

    return systemDarkTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: Palette.primaryDark,
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: mainTextColorDark),
        titleTextStyle: TextStyle(color: mainTextColorDark),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
      ),
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: getTextTheme().apply(
        displayColor: mainTextColorDark,
        bodyColor: mainTextColorDark,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.greenAccent
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white.withOpacity(.05),
        side: BorderSide.none,
        surfaceTintColor: Colors.transparent
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(.4),
          fontWeight: FontWeight.w300,
          fontSize: 14
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none
        ),
        contentPadding: const EdgeInsets.fromLTRB(16, 14, 0, 14)
      )
    );
  }
}