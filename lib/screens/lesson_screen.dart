import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../bloc/content_outline_service.dart';
import '../bloc/lesson_content_service.dart';

import './base/flat.dart';
import '../widgets/section_navigation.dart';
import '../widgets/lesson_content_renderer.dart';
import '../widgets/ui/adaptive_button.dart';
import '../widgets/ui/adaptive_progress_bar.dart';

class LessonScreen extends StatefulWidget {
  static const routeName = "/home/lection/lesson";

  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final navigationController =
      StreamController<Tuple3<BuildContext, NavigationAction, String?>>();

  @override
  void dispose() {
    navigationController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final lessonId = args as String;
    final lessonTitle =
        context.read<ContentOutlineService>().state.getLessonTitle(lessonId);
    final sectionTitles =
        context.read<LessonContentService>().state.sectionTitles;

    return Flat(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  lessonTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
              const Divider(),
              SectionNavigation(
                sectionTitles: sectionTitles,
                onTap: (selectedTitle) => navigationController.add(
                  Tuple3(context, NavigationAction.skip, selectedTitle),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.transparent,
                      ],
                      stops: [0.9, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: LessonContentRenderer(
                    navigationStream: navigationController.stream,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdaptiveButton.navigator(
                      type: ButtonType.secondary,
                      onPressed: () => navigationController.add(
                        Tuple3(context, NavigationAction.previous, null),
                      ),
                      icon: Icons.navigate_before_rounded,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: AdaptiveProgressBar(
                        0.4,
                        withIcon: false,
                        withText: false,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AdaptiveButton.navigator(
                      type: ButtonType.secondary,
                      onPressed: () => navigationController.add(
                        Tuple3(context, NavigationAction.next, null),
                      ),
                      icon: Icons.navigate_next_rounded,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*Center(
                  child: AdaptiveButton.primary(
                    AppLocalizations.of(context)!.finishButtonLabel,
                    extended: false,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),*/
