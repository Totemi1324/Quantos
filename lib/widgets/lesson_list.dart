import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/content_outline_service.dart';
import '../bloc/lesson_content_service.dart';
import '../bloc/localization_service.dart';
import '../bloc/database_service.dart';

import '../screens/lesson_screen.dart';
import '../screens/loading_screen.dart';
import '../models/user_data.dart';
import '../models/lesson.dart';
import './lesson_item.dart';

class LessonList extends StatefulWidget {
  final String lectionId;
  final List<String> lessonIds;

  const LessonList(this.lectionId, this.lessonIds, {super.key});

  @override
  State<LessonList> createState() => _LessonListState();
}

Widget _buildLessonItem(BuildContext buildContext, int index, Lesson lesson) {
  return InkWell(
    splashFactory: NoSplash.splashFactory,
    onTap: () => Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buildContext) => LoadingScreen(
        Future(
          () => buildContext.read<LessonContentService>().loadByIdFromLocale(
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
        title: buildContext
            .read<ContentOutlineService>()
            .state
            .getLessonTitle(lesson.id),
        readTimeInMinutes: lesson.readTimeInMinutes,
        progress:
            buildContext.read<DatabaseService>().lessonProgress(lesson.id),
      ),
    ),
  );
}

class _LessonListState extends State<LessonList> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DatabaseService, UserData>(
      listener: (context, state) => setState(() {}),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.lessonIds.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisSpacing: 10,
          crossAxisSpacing: 20,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          final lesson = context
              .read<ContentOutlineService>()
              .lesson(widget.lessonIds[index]);

          return _buildLessonItem(context, index, lesson);
        },
      ),
    );
  }
}

/*(context, index) {
          final lesson = context
              .read<ContentOutlineService>()
              .lesson(widget.lessonIds[index]);

          return _buildLessonItem(context, index, lesson);
        } */
