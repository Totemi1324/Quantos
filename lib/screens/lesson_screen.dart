import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './base/flat.dart';
import '../bloc/lesson_manager.dart';
import '../models/lesson.dart';
import '../widgets/lesson_content_renderer.dart';
import '../widgets/ui/adaptive_button.dart';

class LessonScreen extends StatelessWidget {
  static const routeName = "/home/lection/lesson";

  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final ids = args as List<String>;
    final lesson = LessonManager.of(context)?.lesson(ids[0], ids[1]) as Lesson;
    final sectionTitles = LessonManager.of(context)
        ?.lessonOutline(ids[0], ids[1]) as List<String>;

    return Flat(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    lesson.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const Divider(),
                ExpansionTile(
                  title: const Text("Jump to sections"),
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: 25,
                          height: 35.0 * sectionTitles.length,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sectionTitles.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  sectionTitles[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                LessonContentRenderer(lesson),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: AdaptiveButton.primary(
                    AppLocalizations.of(context)!.finishButtonLabel,
                    extended: false,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
