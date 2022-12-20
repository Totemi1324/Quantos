import 'package:flutter/material.dart';

import '../containers/panel_card.dart';
import '../part_separator.dart';
import './probability_calculator.dart';

class ProbabilityDistribution extends StatelessWidget {
  const ProbabilityDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        PartSeparator(
          "Probability distribution",
          verticalMargin: 20,
        ),
        PanelCard(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: ProbabilityCalculator(),
        ),
      ],
    );
  }
}
