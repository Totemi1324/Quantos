import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../models/notification.dart';
import '../../models/news.dart';
import 'notification_item.dart';

class NotificationNews extends NotificationItem {
  final News newsObject;
  final VoidCallback onCloseAction;
  final VoidCallback onOpenAction;

  const NotificationNews({
    required this.newsObject,
    required this.onCloseAction,
    required this.onOpenAction,
    super.key,
  }) : super(NotificationType.news, dismissible: true);

  @override
  Widget buildContent(BuildContext buildContext) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage:
                const AssetImage("assets/images/avatar_background.png"),
            foregroundImage: NetworkImage(newsObject.senderIconNetworkAddress),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: AutoSizeText(
              newsObject.message,
              style: Theme.of(buildContext).textTheme.labelSmall,
              overflow: TextOverflow.fade,
              minFontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() => onCloseAction();

  @override
  void onOpen() => onOpenAction();
}
