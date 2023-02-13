import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/lesson_content_service.dart';

//import '../models/content/content_item.dart';
//import '../models/content/paragraph.dart';
import '../screens/lesson_screen.dart';
import './lesson_item.dart';

class LessonList extends StatelessWidget {
  final String lectionId;
  final List<String> lessonIds;

  const LessonList(this.lectionId, this.lessonIds, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessonIds.length,
      itemBuilder: (context, index) {
        final lesson =
            context.read<LessonContentService>().lesson(lessonIds[index]);
        /*final firstParagraph = lessons[index].content.firstWhere(
              (element) => element.type == ContentType.paragraph,
              orElse: () => const Paragraph(texts: [
                ParagraphSpan(type: ParagraphSpanType.normal, text: ""),
              ]),
            ) as Paragraph;

        final firstText = firstParagraph.texts.map((e) => e.text).join();*/

        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () => Navigator.of(context).pushNamed(
            LessonScreen.routeName,
            arguments: lesson.id,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: LessonItem(
              index: index + 1,
              title: context
                  .read<LessonContentService>()
                  .state
                  .getLessonTitle(lesson.id),
              previewText: "",
              readTimeInMinutes: lesson.readTimeInMinutes,
              progress: lesson.progress,
            ),
          ),
        );
      },
    );
  }
}
