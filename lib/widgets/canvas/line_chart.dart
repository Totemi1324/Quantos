import 'dart:math' show min, max;

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../models/numeric_data_point.dart';

enum ValueFormatMode {
  integer,
  decimalProbability,
}

class LineChart extends StatelessWidget {
  final double height;
  final List<String> labels;
  final List<double> values;
  final ValueFormatMode formatMode;
  final double fixedMin;
  final double fixedMax;

  const LineChart(
      {this.height = 200,
      required this.labels,
      required this.values,
      this.formatMode = ValueFormatMode.integer,
      this.fixedMin = -1,
      this.fixedMax = -1,
      super.key});

  Tuple3<double, double, List<NumericDataPoint>> _calculateData() {
    final double minY = values.fold(0, (v1, v2) => min(v1, v2));
    final double maxY = values.fold(0, (v1, v2) => max(v1, v2));
    List<NumericDataPoint> points = List<NumericDataPoint>.empty();

    if (values.isNotEmpty && labels.length == values.length) {
      points = List<NumericDataPoint>.generate(
        values.length,
        (index) => NumericDataPoint(
          labels[index],
          values[index],
        ),
      );
    }

    return Tuple3<double, double, List<NumericDataPoint>>(minY, maxY, points);
  }

  @override
  Widget build(BuildContext context) {
    final data = _calculateData();

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: LineChartPainter(
          data.item3,
          4,
          fixedMin == -1 ? data.item1 : fixedMin,
          fixedMax == -1 ? data.item2 : fixedMax,
          formatMode,
          Theme.of(context).colorScheme,
          Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16),
          Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14),
        ),
        child: Container(),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  static const double padding = 10;
  final List<NumericDataPoint> points;
  final double minY, maxY;
  final int guides;
  final ColorScheme themeColors;
  final TextStyle dataLabelStyle;
  final TextStyle axisLabelStyle;
  final ValueFormatMode labelFormatMode;

  final Paint guidelinePaint = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke
    ..color = Colors.grey.shade400;

  final Paint pathPaint = Paint()
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  LineChartPainter(
    this.points,
    this.guides,
    this.minY,
    this.maxY,
    this.labelFormatMode,
    this.themeColors,
    this.dataLabelStyle,
    this.axisLabelStyle,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = Colors.transparent);

    final drawableHeight = size.height - 2 * padding;
    final drawableWidth = size.width - 2 * padding;
    final segmentHeight = drawableHeight / 5.0;
    final segmentWidth = drawableWidth /
        (points.length.toDouble() == 0 ? 1 : points.length.toDouble());

    final height = segmentHeight * 4.0;
    final width = drawableWidth;

    if (height <= 0 || width <= 0.0) return;

    final double unitHeight = (maxY - minY) == 0 ? 0 : height / (maxY - minY);
    final centerOfSegment =
        Offset(padding + segmentWidth / 2.0, padding + height / 2.0);

    final yOffsets =
        _computeY(centerOfSegment, segmentWidth, height, unitHeight);
    final path = _computePath(yOffsets, segmentWidth);
    final labels = _computeLabels();

    _drawGuidelines(canvas, centerOfSegment, width, height);
    canvas.drawPath(path, pathPaint..color = themeColors.primary);
    _drawDataPoints(canvas, centerOfSegment, segmentWidth, yOffsets, labels);

    final axisLabelOffset =
        Offset(centerOfSegment.dx, padding + 4.5 * segmentHeight);
    _drawXLabels(canvas, axisLabelOffset, segmentWidth);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  List<Offset> _computeY(Offset centerOfSegment, double segmentWidth,
      double height, double unitHeight) {
    List<Offset> y = [];
    for (var point in points) {
      final scaledY = height - (point.value - minY) * unitHeight;
      final localY = Offset(
          centerOfSegment.dx, centerOfSegment.dy - height / 2.0 + scaledY);
      y.add(localY);
      centerOfSegment += Offset(segmentWidth, 0);
    }
    return y;
  }

  Path _computePath(List<Offset> yOffsets, double segmentWidth) {
    final path = Path();
    for (var i = 0; i < yOffsets.length; i++) {
      final offset = yOffsets[i];

      if (i == 0) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        final previousOffset = yOffsets[i - 1];
        path.cubicTo(
          previousOffset.dx + segmentWidth / 2,
          previousOffset.dy,
          offset.dx - segmentWidth / 2,
          offset.dy,
          offset.dx,
          offset.dy,
        );
      }
    }
    return path;
  }

  List<String> _computeLabels() {
    switch (labelFormatMode) {
      case ValueFormatMode.decimalProbability:
        return points
            .map((point) => "${(point.value * 100).toStringAsFixed(0)}%")
            .toList();
      case ValueFormatMode.integer:
      default:
        return points.map((point) => point.value.toStringAsFixed(0)).toList();
    }
  }

  Size _drawTextCentered(Canvas canvas, Offset center, String text,
      TextStyle textStyle, double segmentWidth) {
    final textPainter =
        _measureText(text, textStyle, segmentWidth, TextAlign.center);
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

  void _drawGuidelines(
      Canvas canvas, Offset centerOfSegment, double width, double height) {
    var begin = const Offset(padding, padding);
    var end = Offset(padding + width, padding);
    for (var i = 0; i < guides; i++) {
      canvas.drawLine(begin, end, guidelinePaint);

      begin += Offset(0, height / (guides - 1));
      end += Offset(0, height / (guides - 1));
    }
  }

  void _drawDataPoints(Canvas canvas, Offset centerOffset, double segmentWidth,
      List<Offset> yOffsets, List<String> labels) {
    for (var i = 0; i < yOffsets.length; i++) {
      final offset = yOffsets[i];
      final label = labels[i];
      final labelOffset =
          offset + Offset(0, (offset.dy - 20) < padding ? 20 : -20);

      canvas.drawCircle(offset, 5, Paint()..color = themeColors.primary);
      _drawTextCentered(
          canvas, labelOffset, label, dataLabelStyle, segmentWidth);
      centerOffset += Offset(segmentWidth, 0);
    }
  }

  void _drawXLabels(Canvas canvas, Offset centerOffset, double segmentWidth) {
    for (var point in points) {
      _drawTextCentered(
          canvas, centerOffset, point.label, axisLabelStyle, segmentWidth);
      centerOffset += Offset(segmentWidth, 0);
    }
  }
}
