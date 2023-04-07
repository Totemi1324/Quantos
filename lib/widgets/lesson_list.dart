import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

class _LessonListState extends State<LessonList> {
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 250),
          child: LessonItem(
            index: index,
            title: buildContext
                .read<ContentOutlineService>()
                .state
                .getLessonTitle(lesson.id),
            readTimeInMinutes: lesson.readTimeInMinutes,
            progress:
                buildContext.read<DatabaseService>().lessonProgress(lesson.id),
          ),
        ),
      ),
    );
  }

  List<String> _transformLessonIds(
      BuildContext buildContext, List<String> ids) {
    final List<String> result = [];
    final conditionalIds = ["TE0", "s0f", "fAX", "Ydj"];
    final service = buildContext.read<DatabaseService>();

    for (var id in ids) {
      if (conditionalIds.contains(id)) {
        var index = conditionalIds.indexOf(id);
        if (service.answerForQuestion(index) != QuizAnswer.yes) {
          result.add(id);
        }
      } else {
        result.add(id);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    int itemIndex = 0;

    return BlocListener<DatabaseService, UserData>(
      listener: (context, state) => setState(() {}),
      child: StaggeredGrid.extent(
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 20,
        children:
            _transformLessonIds(context, widget.lessonIds).map<Widget>((id) {
          itemIndex++;

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: _buildLessonItem(
              context,
              itemIndex,
              context.read<ContentOutlineService>().lesson(id),
            ),
          );
        }).toList(),
      ),
    );
  }
}
