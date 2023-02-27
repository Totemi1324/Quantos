import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// State management
import 'bloc/theme_service.dart';
import 'bloc/localization_service.dart';
import 'bloc/authentication_service.dart';
import 'bloc/content_outline_service.dart';
import 'bloc/lesson_content_service.dart';
import '../../bloc/profile_info_service.dart';

// Screens
import 'screens/splash_screen.dart';

import './route_register.dart';
import './models/content/content_outline.dart';
import './models/user_credentials.dart';

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
        BlocProvider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        BlocProvider<ProfileInfoService>(
          create: (_) => ProfileInfoService(),
        ),
      ],
      child: BlocBuilder<LocalizationService, Locale>(
        builder: (context, currentLocale) =>
            BlocBuilder<ThemeService, ThemeData>(
          builder: (context, activeTheme) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Quantos",
            theme: activeTheme,
            locale: currentLocale,
            supportedLocales:
                context.read<LocalizationService>().supportedLocales,
            localizationsDelegates:
                context.read<LocalizationService>().localizationsDelegates,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
            },
            onGenerateRoute: RouteRegister.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
