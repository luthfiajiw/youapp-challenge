import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin SubThemeMixin {
  TextTheme getTextTheme() {
    return GoogleFonts.interTextTheme();
  }
}