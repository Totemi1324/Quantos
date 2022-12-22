import 'dart:math' show exp, max, log;

import 'package:flutter/material.dart';

import '../canvas/bar_chart.dart';

class ProbabilityCalculator extends StatefulWidget {
  final List<double> energies;

  const ProbabilityCalculator(this.energies, {super.key});

  @override
  State<ProbabilityCalculator> createState() => _ProbabilityCalculatorState();
}

class _ProbabilityCalculatorState extends State<ProbabilityCalculator> {
  double _selected = 16;
  late List<double> _probabilityDistribution;

  List<double> _boltzmannDistribution(
      List<double> energies, double temperature) {
    List<double> factorized = energies.map((e) => -e / temperature).toList();
    double lse = _logsumexp(factorized);
    return factorized.map((e) => exp(e - lse)).toList();
  }

  double _logsumexp(List<double> numbers) {
    double c = numbers.fold(0, (v1, v2) => max(v1, v2));
    return c + log(numbers.map((n) => exp(n - c)).fold(0, (a, b) => a + b));
  }

  @override
  void initState() {
    super.initState();

    _probabilityDistribution = _boltzmannDistribution(
      widget.energies,
      _selected / 100.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BarChart(values: _probabilityDistribution),
        Text(
          "${_selected.toStringAsFixed(1)} Millikelvin",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SliderTheme(
          data: SliderThemeData.fromPrimaryColors(
            primaryColor: Theme.of(context).colorScheme.secondary,
            primaryColorDark: Colors.black,
            primaryColorLight: Colors.black,
            valueIndicatorTextStyle: Theme.of(context).textTheme.labelSmall!,
          ),
          child: Slider(
            value: _selected,
            min: 0.01,
            max: 500,
            onChanged: (double value) {
              setState(() {
                _selected = value;
                _probabilityDistribution = _boltzmannDistribution(
                  widget.energies,
                  _selected / 100.0,
                );
              });
            },
          ),
        ),
        Text(
          "This simulates how likely you would get each result on a real quantum annealer, from best to worst. At this temparature of the QPU, the best solution to your problem has a ${((_probabilityDistribution.isNotEmpty ? _probabilityDistribution[0] : 0) * 100).round()}% chance to be found.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
