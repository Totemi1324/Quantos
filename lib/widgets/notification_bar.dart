import 'package:flutter/material.dart';

import '../widgets/notification_news.dart';
import '../data/news_data.dart';

class NotificationBar extends StatefulWidget {
  final double height;

  const NotificationBar({required this.height, super.key});

  @override
  State<NotificationBar> createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar> {
  late List _notifications; //TODO: Notification model superclass

  @override
  void initState() {
    super.initState();
    _notifications = [...news];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: news.isEmpty ? widget.height : 0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: NotificationNews(
            senderIconNetworkAddress: news[index].senderIconNetworkAddress,
            message: news[index].message,
            onCloseAction: () {
              setState(() {
                news.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
