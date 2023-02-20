import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stores/difficulty_store_service.dart';
import '../bloc/localization_service.dart';

import '../models/lection.dart';

class DifficultyBadge extends StatefulWidget {
  final Difficulty difficultyLevel;

  const DifficultyBadge(this.difficultyLevel, {super.key});

  @override
  State<DifficultyBadge> createState() => _DifficultyBadgeState();
}

class _DifficultyBadgeState extends State<DifficultyBadge> {
  List<Widget> getStars(List<Color> difficultyColors) {
    switch (widget.difficultyLevel) {
      case Difficulty.easy:
        return [
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[widget.difficultyLevel.index],
          ),
        ];
      case Difficulty.advanced:
        return [
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[widget.difficultyLevel.index],
          ),
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[widget.difficultyLevel.index],
          ),
        ];
      case Difficulty.challenging:
        return [
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[widget.difficultyLevel.index],
          ),
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[widget.difficultyLevel.index],
          ),
          Icon(
            Icons.star_outline_rounded,
            color: difficultyColors[widget.difficultyLevel.index],
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

    return BlocProvider(
      create: (context) =>
          DifficultyStoreService(context.read<LocalizationService>().state),
      child: BlocBuilder<DifficultyStoreService, Map<Difficulty, String>>(
        builder: (context, state) => Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: difficultyColors[widget.difficultyLevel.index],
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    ...getStars(difficultyColors),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      state[widget.difficultyLevel] ?? "",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color:
                                difficultyColors[widget.difficultyLevel.index],
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
