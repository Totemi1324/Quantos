import 'package:flutter/material.dart';

import '../data/lessons.dart';
import '../models/lesson.dart';
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
      itemBuilder: (context, index) => InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: LessonItem(
            index: index + 1,
            title: lessonsToDisplay[index].title,
            previewText: lessonsToDisplay[index].content,
            readTimeInMinutes: lessonsToDisplay[index].readTimeInMinutes,
            progress: lessonsToDisplay[index].progress,
          ),
        ),
      ),
    );
  }
}
