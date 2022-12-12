import 'package:flutter/material.dart';

class LectionItem extends StatelessWidget {
  final String previewImageAsset;
  final String title;
  final double progressPercent;
  final bool unlocked;

  const LectionItem(
    this.title, {
    required this.previewImageAsset,
    required this.progressPercent,
    required this.unlocked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  previewImageAsset,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Flexible(
              flex: 8,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.emoji_events_rounded,
              size: 30,
              color: Color(0xFF43BA73),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: SizedBox(
                height: 15,
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: progressPercent,
                      child: Container(
                          decoration: BoxDecoration(
                        color: const Color(0xFF43BA73),
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF43BA73),
                          width: 3,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
