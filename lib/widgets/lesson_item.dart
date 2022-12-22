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

  final gradient = const LinearGradient(
    colors: [
      Color(0xFFF1B6E8),
      Color(0xFFBB7FB2),
    ],
    stops: [0.0, 1.0],
    begin: Alignment(1.0, -1.0),
    end: Alignment(-1.0, 1.0),
  );

  @override
  Widget build(BuildContext context) {
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
              const Icon(
                Icons.schedule_rounded,
                color: Colors.white,
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
              minFontSize: 18,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
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
