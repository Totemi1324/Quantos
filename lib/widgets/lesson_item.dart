import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import './containers/rounded_card.dart';
import './ui/adaptive_progress_bar.dart';

class LessonItem extends StatelessWidget {
  final int index;
  final String title;
  final String previewText;
  final int readTimeInMinutes;
  final double progress;

  const LessonItem({
    required this.index,
    required this.title,
    required this.previewText,
    required this.readTimeInMinutes,
    required this.progress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [
        Theme.of(context).colorScheme.secondary,
        const Color(0xFFBB7FB2),
      ],
      stops: const [0.0, 1.0],
      begin: const Alignment(1.0, -1.0),
      end: const Alignment(-1.0, 1.0),
    );

    return RoundedCard(
      fillWidth: true,
      fillHeight: false,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Colors.white,
                ),
                shape: BoxShape.circle,
              ),
              child: Text(
                "$index",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.schedule_rounded,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(
                width: 5,
              ),
              Text("$readTimeInMinutes min."),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: AutoSizeText(
              previewText,
              minFontSize:
                  Theme.of(context).textTheme.displaySmall?.fontSize ?? 15,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          AdaptiveProgressBar(
            progress,
            withIcon: false,
            withText: false,
          ),
        ],
      ),
    );
  }
}
