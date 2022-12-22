import 'package:flutter/material.dart';
import 'package:quantos/models/content/content_item.dart';

import '../data/lessons.dart';
import '../models/lesson.dart';
import '../models/content/content_item.dart';
import '../models/content/paragraph.dart';
import '../screens/lesson_screen.dart';
import './lesson_item.dart';

class LessonList extends StatelessWidget {
  final String lectionId;

  const LessonList(this.lectionId, {super.key});

  List<Lesson> get lessonsOfCurrentCategory {
    return lessons.where((element) => element.lectionId == lectionId).toList();
  }

  @override
  Widget build(BuildContext context) {
    final lessonsToDisplay = lessonsOfCurrentCategory;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lessonsToDisplay.length,
      itemBuilder: (context, index) {
        final firstTextElement = lessonsToDisplay[index].content.firstWhere(
              (element) => element.type == ContentType.paragraph,
              orElse: () => Paragraph(id: "", text: ""),
            ) as Paragraph;

        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () => Navigator.of(context).pushNamed(
            LessonScreen.routeName,
            arguments: lessonsToDisplay[index].id,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: LessonItem(
              index: index + 1,
              title: lessonsToDisplay[index].title,
              previewText: firstTextElement.text,
              readTimeInMinutes: lessonsToDisplay[index].readTimeInMinutes,
              progress: lessonsToDisplay[index].progress,
            ),
          ),
        );
      },
    );
  }
}
