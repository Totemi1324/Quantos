import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../bloc/content_outline_service.dart';
import '../bloc/lesson_content_service.dart';
import '../bloc/database_service.dart';
import '../bloc/authentication_service.dart';

import './base/flat.dart';
import '../widgets/section_navigation.dart';
import '../widgets/lesson_content_renderer.dart';
import '../widgets/ui/adaptive_button.dart';
import '../widgets/ui/adaptive_progress_bar.dart';
import '../models/navigation_action.dart';

class LessonScreen extends StatefulWidget {
  static const routeName = "/home/lection/lesson";

  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final _navigationController =
      StreamController<Tuple3<BuildContext, NavigationAction, String?>>();
  double _progressPercent = 0.0;

  @override
  void dispose() {
    _navigationController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final lessonId = args as String;
    final lessonTitle =
        context.read<ContentOutlineService>().state.getLessonTitle(lessonId);
    final lessonContent = context.read<LessonContentService>().state;

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
                sectionTitles: lessonContent.sectionTitles,
                onTap: (selectedTitle) => _navigationController.add(
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
                    navigationStream: _navigationController.stream,
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
                      tooltip:
                          AppLocalizations.of(context)!.tooltipPreviousPage,
                      onPressed: () {
                        if (_progressPercent > 0.0) {
                          setState(() {
                            _progressPercent -= 1 /
                                context
                                    .read<LessonContentService>()
                                    .state
                                    .pages;
                            if (_progressPercent < 0.02) {
                              _progressPercent = 0.0;
                            }
                          });
                          context
                              .read<DatabaseService>()
                              .updateProgressOfLesson(
                                lessonId,
                                _progressPercent,
                                context
                                    .read<AuthenticationService>()
                                    .state
                                    .userId,
                              );
                        }
                        _navigationController.add(
                          Tuple3(context, NavigationAction.previous, null),
                        );
                      },
                      icon: Icons.navigate_before_rounded,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (_progressPercent != 1.0)
                      Expanded(
                        child: AdaptiveProgressBar(
                          _progressPercent,
                          withIcon: false,
                          withText: false,
                        ),
                      ),
                    if (_progressPercent == 1.0)
                      Center(
                        child: AdaptiveButton.primary(
                          AppLocalizations.of(context)!.finishButtonLabel,
                          extended: false,
                          enabled: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    AdaptiveButton.navigator(
                      type: ButtonType.secondary,
                      tooltip: AppLocalizations.of(context)!.tooltipNextPage,
                      onPressed: () {
                        if (_progressPercent < 1.0) {
                          setState(() {
                            _progressPercent += 1 /
                                context
                                    .read<LessonContentService>()
                                    .state
                                    .pages;
                            if (_progressPercent > 0.98) {
                              _progressPercent = 1.0;
                            }
                          });
                          context
                              .read<DatabaseService>()
                              .updateProgressOfLesson(
                                lessonId,
                                _progressPercent,
                                context
                                    .read<AuthenticationService>()
                                    .state
                                    .userId,
                              );
                        }
                        _navigationController.add(
                          Tuple3(context, NavigationAction.next, null),
                        );
                      },
                      icon: Icons.navigate_next_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
