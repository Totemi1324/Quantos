import 'package:flutter/material.dart';


class RoundedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool fillWidth;
  final bool fillHeight;
  final double? aspectRatio;
  final AlignmentGeometry? alignment;

  const RoundedCard({this.padding, this.alignment, required this.fillWidth, required this.fillHeight, this.aspectRatio, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: fillWidth ? double.infinity : null,
      height: fillHeight ? double.infinity : null,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: padding,
      alignment: alignment,
      child: child,
    );

    if (aspectRatio != null) {
      return AspectRatio(
        aspectRatio: aspectRatio!,
        child: card,
      );
    }
    else {
      return card;
    }
  }
}