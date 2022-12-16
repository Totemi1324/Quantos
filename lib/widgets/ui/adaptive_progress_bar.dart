import 'package:flutter/material.dart';

class AdaptiveProgressBar extends StatelessWidget {
  final double progressPercent;
  final bool withIcon;
  final bool withText;

  const AdaptiveProgressBar(this.progressPercent,
      {required this.withIcon, required this.withText, super.key});

  factory AdaptiveProgressBar.icon(double progressPercent) =>
      AdaptiveProgressBar(
        progressPercent,
        withIcon: true,
        withText: false,
      );

  factory AdaptiveProgressBar.text(double progressPercent) =>
      AdaptiveProgressBar(
        progressPercent,
        withIcon: false,
        withText: true,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (withIcon)
          const Icon(
            Icons.emoji_events_rounded,
            size: 30,
            color: Color(0xFF43BA73),
          ),
        if (withIcon)
          const SizedBox(
            width: 15,
          ),
        Flexible(
          child: SizedBox(
            height: 10,
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
        if (withText)
          const SizedBox(
            width: 15,
          ),
        if (withText)
          Text(
            "${(progressPercent * 100).round()}%",
            style: Theme.of(context).textTheme.labelSmall,
          )
      ],
    );
  }
}
