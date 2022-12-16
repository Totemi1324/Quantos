import 'package:flutter/material.dart';

class PartSeparator extends StatelessWidget {
  final double verticalMargin;
  final String title;

  const PartSeparator(this.title, {this.verticalMargin = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
