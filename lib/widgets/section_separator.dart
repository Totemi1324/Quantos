import 'package:flutter/material.dart';

class SectionSeparator extends StatelessWidget {
  final String title;

  const SectionSeparator(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const Divider(),
      ],
    );
  }
}
