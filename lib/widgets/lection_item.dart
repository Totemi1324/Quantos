import 'package:flutter/material.dart';

import './ui/adaptive_progress_bar.dart';

class LectionItem extends StatelessWidget {
  final String previewImageAsset;
  final String title;
  final double progressPercent;
  final bool unlocked;

  static const ColorFilter grayscaleImageFilter = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  const LectionItem(
    this.title, {
    required this.previewImageAsset,
    required this.progressPercent,
    required this.unlocked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final icon = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 80),
      child: Image.asset(
        previewImageAsset,
        fit: BoxFit.contain,
      ),
    );
    final _progressBar = AdaptiveProgressBar.icon(progressPercent);

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10, top: 10),
                child: unlocked
                    ? icon
                    : ColorFiltered(
                        colorFilter: grayscaleImageFilter,
                        child: icon,
                      ),
              ),
            ),
            Flexible(
              flex: 8,
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
        unlocked
            ? _progressBar
            : ColorFiltered(
                colorFilter: grayscaleImageFilter,
                child: _progressBar,
              ),
      ],
    );
  }
}
