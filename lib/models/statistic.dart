import 'package:flutter/material.dart' show Widget;

import './notification.dart';

class Statistic extends Notification {
  static const notificationType = NotificationType.statistic;

  final Widget statistics;

  Statistic({
    required this.statistics,
    required DateTime date
  }) : super(type: notificationType, date: date);
}