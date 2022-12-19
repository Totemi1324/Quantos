import 'package:flutter/material.dart';

import '../data/lections.dart';
import './ui/adaptive_progress_bar.dart';

class ProgressList extends StatelessWidget {
  const ProgressList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lections.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lections[index].title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AdaptiveProgressBar.text(lections[index].progressPercent),
          ],
        ),
      ),
    );
  }
}
