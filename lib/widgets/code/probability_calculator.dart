import 'package:flutter/material.dart';

class ProbabilityCalculator extends StatefulWidget {
  const ProbabilityCalculator({super.key});

  @override
  State<ProbabilityCalculator> createState() => _ProbabilityCalculatorState();
}

class _ProbabilityCalculatorState extends State<ProbabilityCalculator> {
  double _selected = 0.16;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(), //Graph
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
            min: 0,
            max: 1,
            onChanged: (double value) {
              setState(() {
                _selected = value;
              });
            },
          ),
        ),
        Text(
          "This simulates how likely you would get each result on a real quantum annealer, from best to worst. At this temparature of the QPU, the best solution to your problem has a ${(_selected * 100).round()}% chance to be found.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
