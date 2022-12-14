import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import './notification_item.dart';

class NotificationNews extends NotificationItem {
  static const notificationTypeTitle = "News";
  final String senderIconNetworkAddress;
  final String message;
  final VoidCallback onCloseAction;

  const NotificationNews({
    required this.senderIconNetworkAddress,
    required this.message,
    required this.onCloseAction,
    super.key,
  }) : super(notificationTypeTitle);

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
            foregroundImage: NetworkImage(senderIconNetworkAddress),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: AutoSizeText(
              message,
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
  void onClose() {
    onCloseAction();
  }

  @override
  void onOpen() {
    // TODO: implement onOpen
  }
}
