import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'screens/notification_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/info_screen.dart';
import 'screens/help_screen.dart';
import 'screens/auth/auth_home_screen.dart';
import 'screens/auth/auth_signup_screen.dart';
import 'screens/auth/auth_login_screen.dart';
import 'screens/auth/auth_groupaccess_screen.dart';
import 'screens/profile/profile_name_screen.dart';
import 'screens/profile/profile_quiz_intro_screen.dart';
import 'screens/profile/profile_quiz_screen.dart';
import 'screens/lection_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/base/home.dart';

class RouteRegister {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Home.routeName:
        return PageTransition(
          child: const Home(),
          type: PageTransitionType.fade,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 1200),
        );
      case NotificationScreen.routeName:
        return PageTransition(
          child: const NotificationScreen(),
          settings: settings,
          type: PageTransitionType.bottomToTop,
        );
      case SettingsScreen.routeName:
        return PageTransition(
          child: const SettingsScreen(),
          type: PageTransitionType.bottomToTop,
        );
      case InfoScreen.routeName:
        return PageTransition(
          child: const InfoScreen(),
          type: PageTransitionType.bottomToTop,
        );
      case HelpScreen.routeName:
        return PageTransition(
          child: const HelpScreen(),
          type: PageTransitionType.bottomToTop,
        );
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
          child: ProfileNameScreen(),
          type: PageTransitionType.fade,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
        );
      case ProfileQuizIntroScreen.routeName:
        return PageTransition(
          child: const ProfileQuizIntroScreen(),
          type: PageTransitionType.fade,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
        );
      case ProfileQuizScreen.routeName:
        return PageTransition(
          child: const ProfileQuizScreen(),
          type: PageTransitionType.fade,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
        );
      case LectionScreen.routeName:
        return PageTransition(
          child: const LectionScreen(),
          settings: settings,
          type: PageTransitionType.bottomToTop,
        );
      case LessonScreen.routeName:
        return PageTransition(
          child: const LessonScreen(),
          settings: settings,
          type: PageTransitionType.fade,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
        );
      default:
        return null;
    }
  }
}
