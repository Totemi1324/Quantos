import 'package:flutter/material.dart' hide Notification;

import '../screens/notification_screen.dart';

import '../widgets/notification_news.dart';
import '../models/synced_list.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Animatable<double> animationTween =
      Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOutBack));
  late SyncedList<Notification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = SyncedList<Notification>(
      listKey: _listKey,
      initialItems: news.map((element) => element).toList(),
      removedItemBuilder: _buildRemovedItem,
    );
  }

  Widget _buildItem(
      BuildContext buildContext, int listIndex, Animation<double> animation) {
    var notification = _notifications[listIndex];

    switch (notification.type) {
      case NotificationType.news:
        return SizeTransition(
          sizeFactor: animation.drive(animationTween),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: NotificationNews(
              newsObject: notification as News,
              onOpenAction: () {
                Navigator.of(buildContext).pushNamed(
                  NotificationScreen.routeName,
                  arguments: notification,
                );
              },
              onCloseAction: () {
                setState(() {
                  _notifications.removeAt(listIndex);
                });
              },
            ),
          ),
        );
    }
  }

  Widget _buildRemovedItem(Notification notification, BuildContext buildContext,
      Animation<double> animation) {
    switch (notification.type) {
      case NotificationType.news:
        return ScaleTransition(
          scale: animation.drive(animationTween),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: NotificationNews(
              newsObject: notification as News,
              onOpenAction: () {},
              onCloseAction: () {},
            ),
          ),
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
        child: AnimatedList(
          scrollDirection: Axis.horizontal,
          key: _listKey,
          initialItemCount: _notifications.length,
          itemBuilder: _buildItem,
        ),
      ),
    );
  }
}
