import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/daily_activites.dart';
import '../../models/boolean_data_point.dart';

class HeatmapChart extends StatefulWidget {
  final double height;

  const HeatmapChart({this.height = 200, super.key});

  @override
  State<HeatmapChart> createState() => _HeatmapChartState();
}

class _HeatmapChartState extends State<HeatmapChart> {
  late List<BooleanDataPoint> _points;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final firstWeekday = DateTime(now.year, now.month, 1).weekday - 1;
    int columnIndex = firstWeekday;
    int rowIndex = 0;

    _points = List<BooleanDataPoint>.generate(
      DateTime(now.year, now.month + 1, 0).day,
      (index) {
        final point = BooleanDataPoint(
          x: columnIndex,
          y: rowIndex,
          value: false,
        );
        if (columnIndex == 6) {
          columnIndex = 0;
          rowIndex += 1;
        } else {
          columnIndex += 1;
        }
        return point;
      },
    );

    setState(() {
      dailyActivities
          .where(
        (element) => !element.lastOnline.isBefore(
          DateTime(now.year, now.month, 1),
        ),
      )
          .forEach((element) {
        final dayOfActivity = element.lastOnline.day;
        _points[dayOfActivity - 1] = BooleanDataPoint(
            x: _points[dayOfActivity - 1].x,
            y: _points[dayOfActivity - 1].y,
            value: true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
