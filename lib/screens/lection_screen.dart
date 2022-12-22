import 'package:flutter/material.dart';

import './base/decorated.dart';
import '../data/lections.dart';
import '../widgets/containers/panel_card.dart';
import '../widgets/difficulty_badge.dart';
import '../widgets/part_separator.dart';
import '../widgets/lesson_list.dart';

class LectionScreen extends StatelessWidget {
  static const routeName = "/home/lection";

  const LectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final lectionId = args as String?;
    final lection = lections.firstWhere((element) => element.id == lectionId!);

    return Decorated(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PanelCard(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Rive animation,
                      Text(
                        lection.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: DifficultyBadge(lection.difficultyLevel),
                      ),
                      Text(
                        lection.description,
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const PartSeparator(
                  "Lessons",
                  verticalMargin: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LessonList(lection.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
