import 'package:flutter/material.dart';

import '../widgets/notification_news.dart';

class NotificationBar extends StatelessWidget {
  final double height;

  const NotificationBar({required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: NotificationNews(
            senderIconNetworkAddress: "https://cdn.iconscout.com/icon/free/png-256/flutter-3629369-3032362.png",
            message: "Version 1.0.0 is out! ^_^\nThe full version contains various bug fixes and improvenets.",
          ),
        ),
      ),
    );
  }
}
