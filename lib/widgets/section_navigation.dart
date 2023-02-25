import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionNavigation extends StatefulWidget {
  final List<String> sectionTitles;
  final Function(String) onTap;

  const SectionNavigation(
      {required this.sectionTitles, required this.onTap, super.key});

  @override
  State<SectionNavigation> createState() => _SectionNavigationState();
}

class _SectionNavigationState extends State<SectionNavigation> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        AppLocalizations.of(context)!.lessonScreenOutlinesNavigation,
      ),
      children: [
        Row(
          children: [
            const SizedBox(
              width: 25,
            ),
            Container(
              width: 25,
              height: 35.0 * widget.sectionTitles.length,
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
                itemCount: widget.sectionTitles.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    widget.onTap(widget.sectionTitles[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.sectionTitles[index],
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
