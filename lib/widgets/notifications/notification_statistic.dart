import 'package:flutter/material.dart';

import '../../models/notification.dart';
import '../../models/statistic.dart';
import 'notification_item.dart';

class NotificationStatistic extends NotificationItem {
  final Statistic statisticObject;
  final VoidCallback onOpenAction;
  final VoidCallback onCloseAction;

  const NotificationStatistic({
    required this.statisticObject,
    required this.onOpenAction,
    required this.onCloseAction,
    super.key,
  }) : super(NotificationType.statistic, dismissible: false);

  @override
  Widget buildContent(BuildContext buildContext) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: statisticObject.statistics,
    );
  }

  @override
  void onClose() => onCloseAction();

  @override
  void onOpen() => onOpenAction();
}
