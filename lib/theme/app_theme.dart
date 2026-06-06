import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color bgColor = Color(0xFF0A0A0A);
  static const Color cardBg = Color(0xFF111111);
  static const Color cardBgSecondary = Color(0xFF1A1A1A);
  static const Color primaryAccent = Color(0xFF00E5CC);
  static const Color secondaryAccent = Color(0xFFAAFF00);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF888888);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgColor,
    primaryColor: primaryAccent,
    colorScheme: const ColorScheme.dark(
      primary: primaryAccent,
      secondary: secondaryAccent,
      surface: cardBg,
      background: bgColor,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );

  static TextStyle headingStyle = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
}
