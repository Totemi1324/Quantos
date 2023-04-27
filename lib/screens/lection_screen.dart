import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/content_outline_service.dart';
import '../bloc/lesson_content_service.dart';

import './base/decorated.dart';
import '../widgets/containers/panel_card.dart';
import '../widgets/difficulty_badge.dart';
import '../widgets/part_separator.dart';
import '../widgets/lesson_list.dart';
import '../models/content/lesson_content.dart';

class LectionScreen extends StatelessWidget {
  static const routeName = "/home/lection";

  const LectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final lectionId = args as String;
    final lection = context.read<ContentOutlineService>().lection(lectionId);

    return BlocBuilder<LessonContentService, LessonContent>(
      builder: (context, lessonContent) => Decorated(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PanelCard(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350,
                          height: 350,
                          child: RiveAnimation.asset(
                            "assets/animations/lections/${lection.headerAnimation}",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          context
                              .read<ContentOutlineService>()
                              .state
                              .getLectionTitle(lectionId),
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DifficultyBadge(lection.difficultyLevel),
                        ),
                        Text(
                          context
                              .read<ContentOutlineService>()
                              .state
                              .getLectionDescription(lectionId),
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  PartSeparator(
                    AppLocalizations.of(context)!.lectionScreenLessonsSection,
                    verticalMargin: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: LessonList(
                      lectionId,
                      context
                          .read<ContentOutlineService>()
                          .state
                          .getLessonsOfLection(lectionId),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
