import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() {
    const background = Color(0xFFFFF8F0);
    const primary = Color(0xFFF28C8C);
    final secondary = primary.withAlpha(90);
    const onPrimary = Colors.white;
    const surface = Colors.white;
    const onSurface = Color(0xFFA67B5B);
    const outline = Color(0xFFD3D3D3);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: Colors.white,
        error: Colors.redAccent,
        onError: Colors.white,
        surface: surface,
        onSurface: onSurface
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        color: secondary
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: primary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: TextStyle(color: onSurface, fontSize: 16),
        bodyMedium: TextStyle(color: onSurface),
        titleLarge: TextStyle(color: onSurface, fontWeight: FontWeight.bold)
      ),
      iconTheme: const IconThemeData(color: outline),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: outline),
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 0.5,
        space: 0.5,
        color: outline
      )
    );
  }
}