import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF18181B), // Zinc 900
      onPrimary: Colors.white,
      secondary: Color(0xFFF4F4F5), // Zinc 100
      onSecondary: Color(0xFF18181B),
      surface: Colors.white,
      onSurface: Color(0xFF18181B),
      error: Color(0xFFEF4444),
      outline: Color(0xFFE4E4E7), // Zinc 200
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: const Color(0xFF18181B),
      displayColor: const Color(0xFF18181B),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF18181B)),
      titleTextStyle: TextStyle(
        color: Color(0xFF18181B),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE4E4E7)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF18181B), width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF18181B),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
    extensions: const [
      SemanticColors(
        success: Color(0xFF10B981), // Emerald 500
        error: Color(0xFFEF4444),   // Red 500
        warning: Color(0xFFF59E0B), // Amber 500
        info: Color(0xFF3B82F6),    // Blue 500
        onStatus: Colors.white,
      ),
      InfographicColors(
        palette: [
          Color(0xFF3B82F6), // Blue 500
          Color(0xFF8B5CF6), // Violet 500
          Color(0xFFEC4899), // Pink 500
          Color(0xFFF43F5E), // Rose 500
          Color(0xFFF97316), // Orange 500
          Color(0xFFF59E0B), // Amber 500
          Color(0xFF10B981), // Emerald 500
          Color(0xFF06B6D4), // Cyan 500
          Color(0xFF6366F1), // Indigo 500
          Color(0xFFD946EF), // Fuchsia 500
        ],
      )
    ],
  );
}

@immutable
class SemanticColors extends ThemeExtension<SemanticColors> {
  final Color? success;
  final Color? error;
  final Color? warning;
  final Color? info;
  final Color? onStatus;

  const SemanticColors({
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
    required this.onStatus,
  });

  @override
  SemanticColors copyWith({
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
    Color? onStatus,
  }) {
    return SemanticColors(
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      onStatus: onStatus ?? this.onStatus,
    );
  }

  @override
  SemanticColors lerp(ThemeExtension<SemanticColors>? other, double t) {
    if (other is! SemanticColors) {
      return this;
    }
    return SemanticColors(
      success: Color.lerp(success, other.success, t),
      error: Color.lerp(error, other.error, t),
      warning: Color.lerp(warning, other.warning, t),
      info: Color.lerp(info, other.info, t),
      onStatus: Color.lerp(onStatus, other.onStatus, t),
    );
  }
}

@immutable
class InfographicColors extends ThemeExtension<InfographicColors> {
  final List<Color>? palette;

  const InfographicColors({required this.palette});

  @override
  InfographicColors copyWith({List<Color>? palette}) {
    return InfographicColors(palette: palette ?? this.palette);
  }

  @override
  InfographicColors lerp(ThemeExtension<InfographicColors>? other, double t) {
    if (other is! InfographicColors) {
      return this;
    }
    return this;
  }
}
