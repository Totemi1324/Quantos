import 'package:flutter/material.dart';

class SectionSeparator extends StatelessWidget {
  final String title;
  final double topMargin;

  const SectionSeparator(this.title, {this.topMargin = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
