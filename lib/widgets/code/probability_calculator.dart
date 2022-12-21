import 'dart:math' show exp;

import 'package:flutter/material.dart';

import '../canvas/bar_chart.dart';

class ProbabilityCalculator extends StatefulWidget {
  final List<double> energies;

  const ProbabilityCalculator(this.energies, {super.key});

  @override
  State<ProbabilityCalculator> createState() => _ProbabilityCalculatorState();
}

class _ProbabilityCalculatorState extends State<ProbabilityCalculator> {
  double _selected = 0.05;
  late List<double> _probabilityDistribution;

  List<double> _boltzmannDistribution(
      List<double> energies, double temperature) {
    List<double> scaledEnergies = _scaleListOfNumbersToRange(energies, 0, 1);
    double normalizationDenominator = scaledEnergies
        .map((e) => _boltzmannFactor(e, temperature))
        .fold(0, (e1, e2) => e1 + e2);

    return scaledEnergies
        .map((e) =>
            (1 / normalizationDenominator) * _boltzmannFactor(e, temperature))
        .toList();
  }

  double _boltzmannFactor(double energy, double temperature) =>
      exp(-energy / temperature);

  List<double> _scaleListOfNumbersToRange(
      List<double> inputs, double lower, double upper) {
    List<double> numbers = List<double>.from(inputs);
    numbers.sort();
    double lowest = numbers[0];
    double highest = numbers[numbers.length - 1];

    for (var i = 0; i < numbers.length; i++) {
      if (i == 0) {
        numbers[i] = lower;
      } else if (i == numbers.length - 1) {
        numbers[i] = upper;
      } else {
        numbers[i] = (numbers[i] - lowest).abs() / (highest - lowest).abs();
      }
    }

    return numbers;
  }

  @override
  void initState() {
    super.initState();

    _probabilityDistribution = _boltzmannDistribution(
      widget.energies,
      _selected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BarChart(values: _probabilityDistribution), //Graph
        Text(
          "${_selected.toStringAsFixed(2)} Millikelvin",
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
            max: 1,
            onChanged: (double value) {
              setState(() {
                _selected = value;
                _probabilityDistribution = _boltzmannDistribution(
                  widget.energies,
                  _selected,
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
