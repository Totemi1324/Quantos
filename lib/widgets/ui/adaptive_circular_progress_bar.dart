import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AdaptiveCircularProgressBar extends StatelessWidget {
  final double progress;
  final String? footer;
  final double? radius;

  const AdaptiveCircularProgressBar(this.progress,
      {this.footer, this.radius, super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius ?? MediaQuery.of(context).size.width * 0.2,
      lineWidth: 12,
      animation: true,
      animationDuration: 1000,
      curve: Curves.elasticOut,
      progressColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Colors.transparent,
      percent: progress,
      center: Text(
        "${(progress * 100).toStringAsFixed(0)}%",
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 32,
            ),
      ),
      footer: footer == null
          ? null
          : Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                footer ?? "",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
    );
  }
}
