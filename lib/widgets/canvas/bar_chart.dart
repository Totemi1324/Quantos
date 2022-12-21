import 'dart:math' show min, max;

import 'package:flutter/material.dart';

import '../../models/numeric_data_point.dart';

class BarChart extends StatefulWidget {
  final double height;
  final List<double> values;

  const BarChart({this.height = 200, required this.values, super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  late double _minY, _maxY;
  late List<NumericDataPoint> _points;

  @override
  void initState() {
    super.initState();

    setState(() {
      _minY = widget.values.fold(0, (v1, v2) => min(v1, v2));
      _maxY = widget.values.fold(0, (v1, v2) => max(v1, v2));
      if (widget.values.length >= 5) {
        _points = List<NumericDataPoint>.generate(
          5,
          (index) => NumericDataPoint(
            "#${index + 1}",
            widget.values[index],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: CustomPaint(
        painter: BarChartPainter(
            _points,
            5,
            _minY,
            _maxY,
            Theme.of(context).colorScheme,
            Theme.of(context).textTheme.labelMedium!,
            Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14)),
        child: Container(),
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  static const double padding = 10;
  static const double barWidth = 20;
  final List<NumericDataPoint> points;
  final double minY, maxY;
  final int guides;
  final ColorScheme themeColors;
  final TextStyle dataLabelStyle;
  final TextStyle axisLabelStyle;

  final Paint guidelinePaint = Paint()
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke
    ..color = Colors.grey.shade400;

  final Paint barPaint = Paint()..style = PaintingStyle.fill;

  BarChartPainter(this.points, this.guides, this.minY, this.maxY,
      this.themeColors, this.dataLabelStyle, this.axisLabelStyle);

  @override
  void paint(Canvas canvas, Size size) {
    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = Colors.transparent);

    final drawableHeight = size.height - 2 * padding;
    final drawableWidth = size.width - 2 * padding;
    final segmentHeight = drawableHeight / 5.0;
    final segmentWidth = drawableWidth / points.length.toDouble();

    final height = segmentHeight * 4.0;
    final width = drawableWidth;

    if (height <= 0 || width <= 0.0) return;
    if (maxY - minY < 1.0e-6) return;

    final centerOfSegment = Offset(
      padding + segmentWidth / 2.0,
      padding + height / 2.0,
    );

    final yOffsets = _computeY(centerOfSegment, segmentWidth, height);

    _drawGuidelines(canvas, centerOfSegment, width, height);
    _drawDataPoints(canvas, centerOfSegment, segmentWidth, yOffsets, height);

    final axisLabelOffset =
        Offset(centerOfSegment.dx, padding + 4.5 * segmentHeight);
    _drawXLabels(canvas, axisLabelOffset, segmentWidth);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    /*bool repaint = false;
    BarChartPainter old = oldDelegate as BarChartPainter;

    if (points.length == old.points.length) {
      for (var i = 0; i < points.length; i++) {
        if ((points[i].value - old.points[i].value).abs() > 1.0e-6) {
          repaint = true;
        }
      }
    } else {
      repaint = true;
    }*/

    return true;
  }

  List<Offset> _computeY(
      Offset centerOfSegment, double segmentWidth, double height) {
    List<Offset> top = [];
    for (var point in points) {
      final scaledTop = height - (point.value - minY) * height;
      final localTop = Offset(
        centerOfSegment.dx - barWidth / 2,
        centerOfSegment.dy - height / 2.0 + scaledTop,
      );
      top.add(localTop);
      centerOfSegment += Offset(segmentWidth, 0);
    }
    return top;
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
      List<Offset> yOffsets, double height) {
    for (var i = 0; i < yOffsets.length; i++) {
      final offset = yOffsets[i];
      final label = "${(points[i].value * 100).toStringAsFixed(1)}%";
      final labelOffset =
          offset + Offset(barWidth / 2, (offset.dy - 20) < padding ? 20 : -20);

      final rect = Rect.fromPoints(
        offset,
        Offset(offset.dx + barWidth, centerOffset.dy + height / 2),
      );
      canvas.drawRect(rect, barPaint..color = themeColors.secondary);
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
}
