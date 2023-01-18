import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../models/lesson.dart';
import '../models/content/content_item.dart';
import '../models/content/section_title.dart';
import '../models/content/paragraph.dart';
import '../models/content/interactive.dart';
import '../models/content/image.dart' as image_content;
import '../models/content/equation.dart';

class LessonContentRenderer extends StatelessWidget {
  final Lesson lesson;

  const LessonContentRenderer(this.lesson, {super.key});

  Widget _buildContentItem(BuildContext buildContext, ContentItem item) {
    switch (item.type) {
      case ContentType.paragraph:
        final paragraph = item as Paragraph;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            paragraph.text,
            textAlign: TextAlign.justify,
            style: Theme.of(buildContext).textTheme.bodySmall,
          ),
        );
      case ContentType.sectionTitle:
        final sectionTitle = item as SectionTitle;
        return Container(
          margin: const EdgeInsets.only(top: 20, bottom: 15),
          child: Text(
            sectionTitle.title,
            style: Theme.of(buildContext).textTheme.titleLarge,
          ),
        );
      case ContentType.interactive:
        final interactive = item as Interactive;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              interactive.content,
              Row(
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: IconButton(
                      onPressed: () {},
                      color: Theme.of(buildContext).colorScheme.secondary,
                      padding: const EdgeInsets.all(2),
                      icon: const Icon(
                        Icons.record_voice_over_rounded,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      interactive.caption,
                      style: Theme.of(buildContext).textTheme.displaySmall,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      case ContentType.image:
        final image = item as image_content.Image;
        return Column(
          children: [
            Image.asset(
              fit: BoxFit.fitWidth,
              image.asset,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              image.caption,
              style: Theme.of(buildContext).textTheme.displaySmall,
            )
          ],
        );
      case ContentType.equation:
        final equation = item as Equation;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: Math.tex(
                equation.tex,
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lesson.content.length,
      itemBuilder: (context, index) =>
          _buildContentItem(context, lesson.content[index]),
    );
  }
}
