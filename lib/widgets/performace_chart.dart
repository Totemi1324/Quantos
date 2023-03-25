import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:intl/date_symbol_data_local.dart';

import '../../bloc/localization_service.dart';

import '../../data/daily_activites.dart';
import 'canvas/line_chart.dart';

class PerformanceChart extends StatefulWidget {
  const PerformanceChart({super.key});

  @override
  State<PerformanceChart> createState() => _PerformanceChartState();
}

class _PerformanceChartState extends State<PerformanceChart> {
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  List<String> _generateLabels(BuildContext buildContext) {
    return List<String>.generate(
      7,
      (index) => DateFormat(
        "E",
        buildContext.read<LocalizationService>().state.languageCode,
      ).format(
        DateTime.now().subtract(
          Duration(days: index),
        ),
      ),
    ).reversed.toList();
  }

  List<double> _generateValues() {
    final result = List<double>.generate(7, (index) => 0);

    for (var element in dailyActivities) {
      var differenceInDays = _daysBetween(element.lastOnline, DateTime.now());
      if (differenceInDays < 7) {
        result[differenceInDays] = element.completedLessons.toDouble();
      }
    }

    return result.reversed.toList();
  }

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    final labels = _generateLabels(context);
    final values = _generateValues();

    return BlocListener<LocalizationService, Locale>(
      listener: (context, state) => setState(() {}),
      child: LineChart(labels: labels, values: values),
    );
  }
}
