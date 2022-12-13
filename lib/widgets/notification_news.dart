import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import './notification_item.dart';

class NotificationNews extends NotificationItem {
  static const notificationTypeTitle = "News";
  final String senderIconNetworkAddress;
  final String message;

  const NotificationNews({
    required this.senderIconNetworkAddress,
    required this.message,
    super.key,
  }) : super(notificationTypeTitle);

  @override
  Widget buildContent(BuildContext buildContext) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: const AssetImage("assets/images/avatar_background.png"),
            foregroundImage: NetworkImage(senderIconNetworkAddress),
          ),
          const SizedBox(height: 10,),
          AutoSizeText(
            message,
            style: Theme.of(buildContext).textTheme.labelSmall,
            minFontSize: 16,
            maxFontSize: 18,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }
}
