import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionNavigation extends StatelessWidget {
  final List<String> sectionTitles;

  const SectionNavigation({required this.sectionTitles, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(AppLocalizations.of(context)!.lessonScreenOutlinesNavigation),
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
                  onTap: () {}, //TODO
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
    );
  }
}
