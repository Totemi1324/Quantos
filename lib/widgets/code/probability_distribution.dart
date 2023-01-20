import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../containers/panel_card.dart';
import '../part_separator.dart';
import './probability_calculator.dart';

class ProbabilityDistribution extends StatelessWidget {
  const ProbabilityDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PartSeparator(
          AppLocalizations.of(context)!.codingProbabilityTitle,
          verticalMargin: 20,
        ),
        const PanelCard(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: ProbabilityCalculator([
            -37.6,
            -37.1,
            -36.2,
            -33.9,
            -27.7,
          ]),
        ),
      ],
    );
  }
}
