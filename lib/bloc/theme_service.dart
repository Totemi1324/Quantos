import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeService extends Cubit<ThemeData> {
  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF2EB6E8),
    highlightColor: const Color(0xFF2EB6E8),
    colorScheme: const ColorScheme(
      primary: Color(0xFF2EB6E8),
      secondary: Color(0xFFF1B6E8),
      tertiary: Color(0xFF80F1EF),
      surface: Color(0xFF5C678E),
      background: Color(0xFF1B2033),
      brightness: Brightness.dark,
      error: Color(0xFFBA4360),
      onErrorContainer: Color(0xFF43BA73),
      onBackground: Colors.white,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      primaryContainer: Color(0xFF262D47),
      secondaryContainer: Color(0xFF1B2033),
      tertiaryContainer: Color(0xFF404B75),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.white.withOpacity(0.5),
      space: 30,
      thickness: 3,
    ),
    fontFamily: "Quicksand",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        // Large headers
        fontFamily: "Josefin Sans",
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        // Medium headers
        fontFamily: "Josefin Sans",
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        // Section titles
        fontFamily: "Josefin Sans",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        // Lesson titles
        fontFamily: "Quicksand",
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        // Lesson titles
        fontFamily: "Quicksand",
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        // Standard body
        fontFamily: "Quicksand",
        fontSize: 24,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        // Standard body
        fontFamily: "Quicksand",
        fontSize: 20,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        // Small body
        fontFamily: "Quicksand",
        fontSize: 16,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        // Standard button label
        fontFamily: "Quicksand",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        // Small button label
        fontFamily: "Quicksand",
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        // Form field label
        fontFamily: "Quicksand",
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        // Small label
        fontFamily: "Quicksand",
        fontSize: 15,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    ),
    backgroundColor: const Color(0xFF1B2033),
  );

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF2EB6E8),
    highlightColor: const Color(0xFF2EB6E8),
    colorScheme: ColorScheme(
      primary: const Color(0xFF2EB6E8),
      secondary: const Color(0xFFE78AD8),
      tertiary: const Color(0xFF80F1EF),
      surface: const Color(0xFFB1BADB),
      background: const Color(0xFFC2C2C2),
      brightness: Brightness.light,
      error: const Color(0xFFBA4360),
      onErrorContainer: const Color(0xFF2E9658),
      onBackground: Colors.grey.shade900,
      onError: Colors.grey.shade900,
      onPrimary: Colors.grey.shade900,
      onSecondary: Colors.grey.shade900,
      onSurface: Colors.grey.shade900,
      primaryContainer: const Color(0xFFE8E8E8),
      secondaryContainer: const Color(0xFFC2C2C2),
      tertiaryContainer: Color.fromARGB(255, 128, 145, 214),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade900.withOpacity(0.5),
      space: 30,
      thickness: 3,
    ),
    fontFamily: "Quicksand",
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        // Large headers
        fontFamily: "Josefin Sans",
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade900,
      ),
      headlineMedium: TextStyle(
        // Medium headers
        fontFamily: "Josefin Sans",
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade900,
      ),
      titleLarge: TextStyle(
        // Section titles
        fontFamily: "Josefin Sans",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade900,
      ),
      titleMedium: TextStyle(
        // Lesson titles
        fontFamily: "Quicksand",
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade900,
      ),
      titleSmall: TextStyle(
        // Lesson titles
        fontFamily: "Quicksand",
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade900,
      ),
      bodyLarge: TextStyle(
        // Standard body
        fontFamily: "Quicksand",
        fontSize: 24,
        color: Colors.grey.shade900,
      ),
      bodyMedium: TextStyle(
        // Standard body
        fontFamily: "Quicksand",
        fontSize: 20,
        color: Colors.grey.shade900,
      ),
      bodySmall: TextStyle(
        // Small body
        fontFamily: "Quicksand",
        fontSize: 16,
        color: Colors.grey.shade900,
      ),
      labelLarge: TextStyle(
        // Standard button label
        fontFamily: "Quicksand",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade900,
      ),
      labelMedium: TextStyle(
        // Small button label
        fontFamily: "Quicksand",
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade900,
      ),
      labelSmall: TextStyle(
        // Form field label
        fontFamily: "Quicksand",
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Colors.grey.shade900,
      ),
      displaySmall: TextStyle(
        // Small label
        fontFamily: "Quicksand",
        fontSize: 15,
        fontWeight: FontWeight.w300,
        color: Colors.grey.shade900,
      ),
    ),
    backgroundColor: const Color(0xFFC2C2C2),
  );

  static final _accessibilityTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF2EB6E8),
    highlightColor: const Color(0xFF2EB6E8),
    colorScheme: const ColorScheme(
      primary: Color(0xFF2EB6E8),
      secondary: Color(0xFFF1B6E8),
      tertiary: Color(0xFF80F1EF),
      surface: Color(0xFF333333),
      background: Color(0xFF000000),
      brightness: Brightness.dark,
      error: Color(0xFFFE5D84),
      onErrorContainer: Color(0xFF43BA73),
      onBackground: Color(0xFFFFFD48),
      onError: Color(0xFFFFFD48),
      onPrimary: Color(0xFFFFFD48),
      onSecondary: Color(0xFFFFFD48),
      onSurface: Color(0xFFFFFD48),
      primaryContainer: Color(0xFF000000),
      secondaryContainer: Color(0xFF000000),
      tertiaryContainer: Color(0xFF404B75),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0x7FFFFD48),
      space: 30,
      thickness: 3,
    ),
    fontFamily: "Quicksand",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        // Large headers
        fontFamily: "Josefin Sans",
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFFFD48),
      ),
      headlineMedium: TextStyle(
        // Medium headers
        fontFamily: "Josefin Sans",
        fontSize: 38,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFFFD48),
      ),
      titleLarge: TextStyle(
        // Section titles
        fontFamily: "Josefin Sans",
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFFFD48),
      ),
      titleMedium: TextStyle(
        // Lesson titles
        fontFamily: "Quicksand",
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFFFD48),
      ),
      titleSmall: TextStyle(
        // Lesson titles
        fontFamily: "Quicksand",
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFFFD48),
      ),
      bodyLarge: TextStyle(
        // Standard body
        fontFamily: "Quicksand",
        fontSize: 30,
        color: Color(0xFFFFFD48),
      ),
      bodyMedium: TextStyle(
        // Standard body
        fontFamily: "Quicksand",
        fontSize: 26,
        color: Color(0xFFFFFD48),
      ),
      bodySmall: TextStyle(
        // Small body
        fontFamily: "Quicksand",
        fontSize: 22,
        color: Color(0xFFFFFD48),
      ),
      labelLarge: TextStyle(
        // Standard button label
        fontFamily: "Quicksand",
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFFFD48),
      ),
      labelMedium: TextStyle(
        // Small button label
        fontFamily: "Quicksand",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFFFD48),
      ),
      labelSmall: TextStyle(
        // Form field label
        fontFamily: "Quicksand",
        fontSize: 24,
        fontWeight: FontWeight.w300,
        color: Color(0xFFFFFD48),
      ),
      displaySmall: TextStyle(
        // Small label
        fontFamily: "Quicksand",
        fontSize: 21,
        fontWeight: FontWeight.w300,
        color: Color(0xFFFFFD48),
      ),
    ),
    backgroundColor: const Color(0xFF000000),
  );

  ThemeService() : super(_darkTheme);

  static ThemeData currentTheme = _darkTheme;
  static ThemeData previousTheme = _darkTheme;
  static bool accessibilityModeActivated = false;
  static bool colorblindModeActivated = false;

  bool get accessibilityModeActive => accessibilityModeActivated;
  bool get colorblindModeActive => colorblindModeActivated;

  void selectTheme(Brightness selectedBrightness) {
    if (selectedBrightness == Brightness.dark) {
      currentTheme = _darkTheme;
      emit(_darkTheme);
    } else {
      currentTheme = _lightTheme;
      emit(_lightTheme);
    }
  }

  void toggleAccessibilityMode(bool switchState) {
    if (switchState) {
      previousTheme = state;
      accessibilityModeActivated = true;
      currentTheme =
          _accessibilityTheme.copyWith(brightness: currentTheme.brightness);
      emit(currentTheme);
    } else {
      accessibilityModeActivated = false;
      currentTheme = previousTheme;
      emit(currentTheme);
    }
  }

  void toggleColorblindMode(bool switchState) {
    if (switchState) {
      colorblindModeActivated = true;
      emit(
        currentTheme.copyWith(
          colorScheme: currentTheme.colorScheme.copyWith(
            error: const Color(0xFFBAAE43),
            onErrorContainer: const Color(0xFF2EB6E8),
          ),
        ),
      );
    } else {
      colorblindModeActivated = false;
      emit(currentTheme);
    }
  }
}
