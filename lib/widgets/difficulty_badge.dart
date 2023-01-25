import 'package:flutter/material.dart';

import '../models/lection.dart';

class DifficultyBadge extends StatelessWidget {
  final Difficulty difficultyLevel;

  const DifficultyBadge(this.difficultyLevel, {super.key});

  String get difficultyName {
    switch (difficultyLevel) {
      case Difficulty.easy:
        return "Easy";
      case Difficulty.advanced:
        return "Advanced";
      case Difficulty.challenging:
        return "Challenging";
    }
  }

  List<Widget> getStars(List<Color> difficultyColors) {
    switch (difficultyLevel) {
      case Difficulty.easy:
        return [
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[difficultyLevel.index],
          ),
        ];
      case Difficulty.advanced:
        return [
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[difficultyLevel.index],
          ),
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[difficultyLevel.index],
          ),
        ];
      case Difficulty.challenging:
        return [
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[difficultyLevel.index],
          ),
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[difficultyLevel.index],
          ),
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[difficultyLevel.index],
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> difficultyColors = [
      Theme.of(context).colorScheme.onErrorContainer,
      const Color(0xFFBAAE43),
      Theme.of(context).colorScheme.error,
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: difficultyColors[difficultyLevel.index],
                width: 3,
              ),
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                ...getStars(difficultyColors),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  difficultyName,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: difficultyColors[difficultyLevel.index],
                        fontWeight: FontWeight.w700,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
