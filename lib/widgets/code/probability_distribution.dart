import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubo_embedder/qubo_embedder.dart';

import '../../bloc/coding_service.dart';

import '../../models/console_content.dart';
import '../containers/panel_card.dart';
import '../part_separator.dart';
import './probability_calculator.dart';

class ProbabilityDistribution extends StatefulWidget {
  const ProbabilityDistribution({super.key});

  @override
  State<ProbabilityDistribution> createState() =>
      _ProbabilityDistributionState();
}

class _ProbabilityDistributionState extends State<ProbabilityDistribution> {
  List<double> _energies = [0.0];

  void _extractEnergies(SolutionRecord? record) {
    if (record != null) {
      setState(() {
        _energies = record.entries().map((entry) => entry.energy).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CodingService, ConsoleContent>(
      listener: (context, state) {
        if (state.status == ConsoleStatus.success) {
          _extractEnergies(state.record);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PartSeparator(
            AppLocalizations.of(context)!.codingProbabilityTitle,
            verticalMargin: 20,
          ),
          PanelCard(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ProbabilityCalculator(_energies),
          ),
        ],
      ),
    );
  }
}
