import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/auth/auth_home_screen.dart';
import 'screens/auth/auth_signup_screen.dart';
import 'screens/auth/auth_login_screen.dart';
import 'screens/auth/auth_groupaccess_screen.dart';
import 'screens/profile/profile_name_screen.dart';
import 'screens/profile/profile_age_screen.dart';
import 'screens/profile/profile_experience_screen.dart';
import 'screens/home_screen.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final activeTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF2EB6E8),
    colorScheme: const ColorScheme(
      primary: Color(0xFF2EB6E8),
      secondary: Color(0xFFF1B6E8),
      tertiary: Color(0xFF80F1EF),
      surface: Color(0xFF5C678E),
      background: Color(0xFF1B2033),
      brightness: Brightness.dark,
      error: Color(0xFFBA4360),
      onBackground: Colors.white,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      primaryContainer: Color(0xFF262D47),
      secondaryContainer: Color(0xFF1B2033),
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
    ),
    backgroundColor: const Color(0xFF1B2033),
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quantos",
      theme: activeTheme,
      initialRoute: ProfileNameScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AuthHomeScreen.routeName:
            return PageTransition(
              child: const AuthHomeScreen(),
              type: PageTransitionType.fade,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 1200),
            );
          case AuthSignUpScreen.routeName:
            return PageTransition(
              child: const AuthSignUpScreen(),
              type: PageTransitionType.rightToLeft,
            );
          case AuthLogInScreen.routeName:
            return PageTransition(
              child: const AuthLogInScreen(),
              type: PageTransitionType.rightToLeft,
            );
          case AuthGroupAccessScreen.routeName:
            return PageTransition(
              child: const AuthGroupAccessScreen(),
              type: PageTransitionType.rightToLeft,
            );
          case ProfileNameScreen.routeName:
            return PageTransition(
              child: const ProfileNameScreen(),
              type: PageTransitionType.fade,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
            );
          case ProfileAgeScreen.routeName:
            return PageTransition(
              child: ProfileAgeScreen(),
              settings: settings,
              type: PageTransitionType.fade,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
            );
          case ProfileExperienceScreen.routeName:
            return PageTransition(
              child: ProfileExperienceScreen(),
              settings: settings,
              type: PageTransitionType.fade,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
            );
          default:
            return null;
        }
      },
    );
  }
}
