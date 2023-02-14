import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

// State management
import 'bloc/theme_service.dart';
import 'bloc/localization_service.dart';
import 'bloc/content_outline_service.dart';
import 'bloc/lesson_content_service.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/info_screen.dart';
import 'screens/help_screen.dart';
import 'screens/auth/auth_home_screen.dart';
import 'screens/auth/auth_signup_screen.dart';
import 'screens/auth/auth_login_screen.dart';
import 'screens/auth/auth_groupaccess_screen.dart';
import 'screens/profile/profile_name_screen.dart';
import 'screens/profile/profile_age_screen.dart';
import 'screens/profile/profile_experience_screen.dart';
import 'screens/lection_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/base/home.dart';

import './models/content/content_outline.dart';

void main() {
  Paint.enableDithering = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeService>(
          create: (_) => ThemeService(),
        ),
        BlocProvider<LocalizationService>(
          create: (_) => LocalizationService(),
        ),
        BlocProvider<ContentOutlineService>(
          create: (_) => ContentOutlineService(),
        ),
        BlocProvider<LessonContentService>(
          create: (_) => LessonContentService(),
        ),
      ],
      child: BlocBuilder<LocalizationService, Locale>(
        builder: (context, currentLocale) =>
            BlocBuilder<ThemeService, ThemeData>(
          builder: (context, activeTheme) =>
              BlocBuilder<ContentOutlineService, ContentOutline>(
            builder: (context, contentOutline) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Quantos",
              theme: activeTheme,
              locale: context.read<LocalizationService>().state,
              supportedLocales:
                  context.read<LocalizationService>().supportedLocales,
              localizationsDelegates:
                  context.read<LocalizationService>().localizationsDelegates,
              initialRoute: SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (context) => const SplashScreen(),
              },
              onGenerateRoute: (settings) {
                //TODO: Extract in separate class
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
                      child: const ProfileNameScreen(),
                      type: PageTransitionType.fade,
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 500),
                    );
                  case ProfileAgeScreen.routeName:
                    return PageTransition(
                      child: const ProfileAgeScreen(),
                      settings: settings,
                      type: PageTransitionType.fade,
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 500),
                    );
                  case ProfileExperienceScreen.routeName:
                    return PageTransition(
                      child: const ProfileExperienceScreen(),
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
