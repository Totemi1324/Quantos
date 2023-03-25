import 'package:flutter/material.dart';

import '../../models/content/interactive.dart';

import '../canvas/line_chart.dart';

class AnnealingTimeSuccessRate extends Interactive {
  static const String identifier = "56h_graph_annealingtime";

  AnnealingTimeSuccessRate({
    required super.caption,
    required super.altText,
    required super.args,
  });

  List<String> _generateSpacedLabels() {
    return List<String>.generate(10, (index) {
      if (index == 0) return "20ms";
      if (index == 9) return "20000ms";
      return "";
    });
  }

  @override
  Widget get content {
    if (args == null) {
      return const Content("", "", [], [], []);
    }

    String titleSimple = "";
    String titleComplex = "";
    List<List<double>> valuesSimple = [];
    List<List<double>> valuesComplex = [];

    if (args!.containsKey("title_simple")) {
      titleSimple = args!["title_simple"] as String;
    }
    if (args!.containsKey("title_complex")) {
      titleComplex = args!["title_complex"] as String;
    }
    if (args!.containsKey("values_simple")) {
      var simpleValueArrays = args!["values_simple"] as List<dynamic>;
      for (var array in simpleValueArrays) {
        valuesSimple.add(
          (array as List<dynamic>).map((value) => value as double).toList(),
        );
      }
    }
    if (args!.containsKey("values_complex")) {
      var complexValueArrays = args!["values_complex"] as List<dynamic>;
      for (var array in complexValueArrays) {
        valuesComplex.add(
          (array as List<dynamic>).map((value) => value as double).toList(),
        );
      }
    }

    return Content(titleSimple, titleComplex, _generateSpacedLabels(),
        valuesSimple, valuesComplex);
  }

  @override
  String get id => identifier;
}

class Content extends StatefulWidget {
  final String titleSimple;
  final String titleComplex;
  final List<String> labels;
  final List<List<double>> valuesSimple;
  final List<List<double>> valuesComplex;

  const Content(this.titleSimple, this.titleComplex, this.labels,
      this.valuesSimple, this.valuesComplex,
      {super.key});

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
        Text(
          "n = ${_selected.round() + 3}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.titleSimple,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        LineChart(
          height: 170,
          labels: widget.labels,
          values: widget.valuesSimple[_selected.round()],
          formatMode: ValueFormatMode.decimalProbability,
          fixedMin: 0,
          fixedMax: 1,
        ),
        Text(
          widget.titleComplex,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        LineChart(
          height: 170,
          labels: widget.labels,
          values: widget.valuesComplex[_selected.round()],
          formatMode: ValueFormatMode.decimalProbability,
          fixedMin: 0,
          fixedMax: 1,
        ),
        SliderTheme(
          data: SliderThemeData.fromPrimaryColors(
            primaryColor: Theme.of(context).colorScheme.primary,
            primaryColorDark: Colors.black,
            primaryColorLight: Colors.black,
            valueIndicatorTextStyle: Theme.of(context).textTheme.labelSmall!,
          ),
          child: Slider(
            value: _selected,
            divisions: 5,
            min: 0,
            max: 5,
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
