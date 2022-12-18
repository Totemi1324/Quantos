import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../../data/daily_activites.dart';
import '../../models/boolean_data_point.dart';

class HeatmapChart extends StatefulWidget {
  final double height;

  const HeatmapChart({this.height = 240, super.key});

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
    return SizedBox(
      height: widget.height,
      child: CustomPaint(
        painter: HeatmapChartPainter(
          _points,
          Theme.of(context).colorScheme,
          Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14),
        ),
        child: Container(),
      ),
    );
  }
}

class HeatmapChartPainter extends CustomPainter {
  static const double padding = 10;
  final List<BooleanDataPoint> points;
  final ColorScheme themeColors;
  final TextStyle axisLabelStyle;

  final Paint offlinePaint = Paint()
    ..strokeWidth = 3
    ..style = PaintingStyle.stroke;

  HeatmapChartPainter(this.points, this.themeColors, this.axisLabelStyle);

  @override
  void paint(Canvas canvas, Size size) {
    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = Colors.transparent);

    final drawableHeight = size.height - 2 * padding;
    final drawableWidth = size.width - 2 * padding;
    final segmentHeight = drawableHeight / 7.0;

    final height = segmentHeight * 6;
    final width = drawableWidth;

    final squareSize1 = height / (points.last.y + 1.0);
    final squareSize2 = width / 7.0;
    double squareSize;
    if (squareSize1 < squareSize2) {
      squareSize = squareSize1;
    } else {
      squareSize = squareSize2;
    }

    if (height <= 0 || width <= 0.0) return;
    if (squareSize < 5) return;

    final centerOfSquare = Offset(
      padding + width / 2 + squareSize * (points.first.x - 3),
      padding + squareSize / 2 + segmentHeight,
    );
    _drawDataPoints(canvas, centerOfSquare, squareSize);

    final axisLabelOffset = Offset(
      padding + width / 2 + squareSize * (-3),
      padding + segmentHeight / 2,
    );
    _drawXLabels(canvas, axisLabelOffset, squareSize);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawDataPoints(Canvas canvas, Offset centerOfSquare, squareSize) {
    const border = 5;
    const radius = 5.0;

    points.forEach((point) {
      final center = centerOfSquare +
          Offset(squareSize * (point.x - 3), squareSize * point.y);
      final square = Rect.fromCenter(
        center: center,
        width: squareSize - border * 2,
        height: squareSize - border * 2,
      );
      if (point.value) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(square, const Radius.circular(radius)),
          Paint()..color = themeColors.secondary,
        );
      }
      canvas.drawRRect(
        RRect.fromRectAndRadius(square, const Radius.circular(radius)),
        offlinePaint..color = themeColors.secondary,
      );
    });
  }

  void _drawXLabels(Canvas canvas, Offset centerOffset, double squareSize) {
    final now = DateTime.now();
    DateTime currentDay = now.subtract(Duration(days: now.weekday - 1));

    for (var i = 0; i < 7; i++) {
      final dayName = DateFormat("E").format(currentDay);
      _drawTextCentered(
          canvas, centerOffset, dayName, axisLabelStyle, squareSize);
      centerOffset += Offset(squareSize, 0);
      currentDay = currentDay.add(const Duration(days: 1));
    }
  }

  Size _drawTextCentered(Canvas canvas, Offset center, String text,
      TextStyle textStyle, double segmentWidth) {
    TextPainter textPainter =
        _measureText(text, textStyle, segmentWidth, TextAlign.center);
    if (textPainter.size.height > 20) {
      textPainter =
          _measureText(text[0], textStyle, segmentWidth, TextAlign.center);
    }
    final position =
        center + Offset(-textPainter.width / 2.0, -textPainter.height / 2.0);
    textPainter.paint(canvas, position);
    return textPainter.size;
  }

  TextPainter _measureText(
      String text, TextStyle textStyle, double maxWidth, TextAlign alignment) {
    final span = TextSpan(
      text: text,
      style: textStyle,
    );
    final painter = TextPainter(
        text: span, textAlign: alignment, textDirection: TextDirection.ltr);
    painter.layout(minWidth: 0, maxWidth: maxWidth);
    return painter;
  }
}
