import 'package:flutter/material.dart';

import '../../models/content/interactive.dart';

import '../canvas/bar_chart.dart';

class NQueensSuccessRate2000Q extends Interactive {
  static const String identifier = "qhs_graph_2000q";

  NQueensSuccessRate2000Q({
    required super.caption,
    required super.altText,
    required super.args,
  });

  @override
  Widget get content {
    if (args == null) {
      return const Content([], []);
    }

    List<String> labels = [];
    List<List<double>> values = [];

    if (args!.containsKey("labels")) {
      labels = (args!["labels"] as List<dynamic>)
          .map((label) => label as String)
          .toList();
    }
    if (args!.containsKey("values")) {
      var valueArrays = args!["values"] as List<dynamic>;
      for (var array in valueArrays) {
        values.add(
          (array as List<dynamic>).map((value) => value as double).toList(),
        );
      }
    }

    return Content(labels, values);
  }

  @override
  String get id => identifier;
}

class Content extends StatefulWidget {
  final List<String> labels;
  final List<List<double>> values;

  const Content(this.labels, this.values, {super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  double _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BarChart(
          labels: widget.labels,
          values: widget.values[_selected.round()],
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
            divisions: 3,
            min: 0,
            max: 3,
            onChanged: (double value) {
              setState(() {
                _selected = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
