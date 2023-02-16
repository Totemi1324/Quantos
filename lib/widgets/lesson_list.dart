import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/content_outline_service.dart';
import '../bloc/lesson_content_service.dart';
import '../bloc/localization_service.dart';

import '../screens/lesson_screen.dart';
import '../screens/loading_screen.dart';
import './lesson_item.dart';

class LessonList extends StatelessWidget {
  final String lectionId;
  final List<String> lessonIds;

  const LessonList(this.lectionId, this.lessonIds, {super.key});

  Future loadLessonAndProceed(BuildContext context, String lessonId) async {
    /*await context.read<LessonContentService>().loadByIdFromLocale(
                  lesson.id,
                  locale,
                  notFoundParagraph,
                );
            
            if (!context.)

            Navigator.of(context).pushNamed(
              LessonScreen.routeName,
              arguments: lesson.id,
            );*/
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessonIds.length,
      itemBuilder: (context, index) {
        final lesson =
            context.read<ContentOutlineService>().lesson(lessonIds[index]);

        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (buildContext) => LoadingScreen(
              Future(
                () => buildContext
                    .read<LessonContentService>()
                    .loadByIdFromLocale(
                      lesson.id,
                      buildContext.read<LocalizationService>().state,
                      AppLocalizations.of(buildContext)!,
                    ),
              ),
              LessonScreen.routeName,
              arguments: lesson.id,
            ),
          )),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: LessonItem(
              index: index + 1,
              title: context
                  .read<ContentOutlineService>()
                  .state
                  .getLessonTitle(lesson.id),
              readTimeInMinutes: lesson.readTimeInMinutes,
              progress: lesson.progress,
            ),
          ),
        );
      },
    );
  }
}
