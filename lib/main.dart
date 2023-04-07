import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

// State management
import 'bloc/theme_service.dart';
import 'bloc/localization_service.dart';
import 'bloc/authentication_service.dart';
import 'bloc/content_outline_service.dart';
import 'bloc/lesson_content_service.dart';
import 'bloc/database_service.dart';
import 'bloc/profile_quiz_service.dart';
import 'bloc/download_service.dart';
import 'bloc/text_to_speech_service.dart';

// Screens
import 'screens/splash_screen.dart';

// Models
import 'models/content/content_outline.dart';

import './route_register.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        BlocProvider<ProfileQuizService>(
          create: (_) => ProfileQuizService(),
        ),
        BlocProvider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        BlocProvider<TextToSpeechService>(
          create: (_) => TextToSpeechService(),
        ),
        BlocProvider<DownloadService>(
          create: (_) => DownloadService(),
        ),
      ],
      child: BlocBuilder<LocalizationService, Locale>(
        builder: (context, currentLocale) {
          context.read<TextToSpeechService>().setLanguage(currentLocale);
          return BlocBuilder<ThemeService, ThemeData>(
            builder: (context, activeTheme) =>
                BlocBuilder<ContentOutlineService, ContentOutline>(
              builder: (context, outlines) => BlocProvider(
                create: (_) => DatabaseService(outlines),
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Quantos",
                  theme: activeTheme,
                  locale: currentLocale,
                  supportedLocales:
                      context.read<LocalizationService>().supportedLocales,
                  localizationsDelegates: context
                      .read<LocalizationService>()
                      .localizationsDelegates,
                  initialRoute: SplashScreen.routeName,
                  routes: {
                    SplashScreen.routeName: (context) => const SplashScreen(),
                  },
                  onGenerateRoute: RouteRegister.onGenerateRoute,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
