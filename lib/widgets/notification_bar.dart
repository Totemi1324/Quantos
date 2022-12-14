import 'package:flutter/material.dart' hide Notification;

import '../widgets/notification_news.dart';
import '../models/notification.dart';
import '../models/news.dart';
import '../data/notifications.dart';

class NotificationBar extends StatefulWidget {
  final double height;

  const NotificationBar({required this.height, super.key});

  @override
  State<NotificationBar> createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar> {
  late List<Notification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = [...news];
  }

  Widget _buildNotificationItem(int listIndex) {
    var notification = _notifications[listIndex];

    switch (notification.type) {
      case NotificationType.news:
        var newsObject = _notifications[listIndex] as News;
        return NotificationNews(
          senderIconNetworkAddress: newsObject.senderIconNetworkAddress,
          message: newsObject.message,
          onCloseAction: () {
            setState(() {
              _notifications.removeAt(listIndex);
            });
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _notifications.isEmpty ? 0 : widget.height,
      child: RawScrollbar(
        thumbColor: Theme.of(context).colorScheme.surface.withOpacity(0.3),
        radius: const Radius.circular(5),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _notifications.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: _buildNotificationItem(index),
          ),
        ),
      ),
    );
  }
}
