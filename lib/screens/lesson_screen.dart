import 'package:flutter/material.dart';

import './base/flat.dart';
import '../data/lessons.dart';
import '../models/content/content_item.dart';
import '../models/content/section_title.dart';

class LessonScreen extends StatelessWidget {
  static const routeName = "/home/lection/lesson";

  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final id = args as String?;
    final lesson = lessons.firstWhere((lesson) => lesson.id == id);
    final sectionTitles = lesson.content
        .where((item) => item.type == ContentType.sectionTitle)
        .map((e) => e as SectionTitle)
        .toList();

    return Flat(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Divider(),
                ExpansionTile(
                  title: const Text("Jump to sections"),
                  tilePadding: const EdgeInsets.all(0),
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
                                  sectionTitles[index].title,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
