import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color(0xFF18181B),
      secondary: Color(0xFF27272A),
      surface: Color(0xFFFAFAFA),
      onSurface: Color(0xFF18181B),
      onPrimary: Color(0xFFFFFFFF),
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFFDC2626),
    ),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    cardColor: Color(0xFFFAFAFA),
    dividerColor: Color(0xFFE4E4E7),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFFA1A1AA),
      surface: Color(0xFF18181B),
      onSurface: Color(0xFFFFFFFF),
      onPrimary: Color(0xFF09090B),
      error: Color(0xFFEF4444),
      errorContainer: Color(0xFFDC2626),
    ),
    scaffoldBackgroundColor: Color(0xFF09090B),
    cardColor: Color(0xFF18181B),
    dividerColor: Color(0xFF27272A),
  );
}
