import 'package:flutter/material.dart';

import '../models/lesson.dart';
import '../models/content/content_item.dart';
import '../models/content/paragraph.dart';
import '../screens/lesson_screen.dart';
import './lesson_item.dart';

class LessonList extends StatelessWidget {
  final String lectionId;
  final List<Lesson> lessons;

  const LessonList(this.lectionId, this.lessons, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final firstParagraph = lessons[index].content.firstWhere(
              (element) => element.type == ContentType.paragraph,
              orElse: () => const Paragraph(texts: [
                ParagraphSpan(type: ParagraphSpanType.normal, text: ""),
              ]),
            ) as Paragraph;

        final firstText = firstParagraph.texts
            .map((e) => e.text).join();

        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () => Navigator.of(context).pushNamed(
            LessonScreen.routeName,
            arguments: <String>[lectionId, lessons[index].id],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: LessonItem(
              index: index + 1,
              title: lessons[index].title,
              previewText: firstText,
              readTimeInMinutes: lessons[index].readTimeInMinutes,
              progress: lessons[index].progress,
            ),
          ),
        );
      },
    );
  }
}
