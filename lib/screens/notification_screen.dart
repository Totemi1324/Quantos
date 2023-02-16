import 'package:flutter/material.dart' hide Notification;
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

import './base/flat.dart';
import '../models/news.dart';
import '../models/notification.dart';
import '../widgets/error_page_content.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = "/notifications";

  const NotificationScreen({super.key});

  Widget? _buildPageContent(
      BuildContext buildContext, Notification? notification) {
    if (notification == null) {
      return null;
    }

    switch (notification.type) {
      case NotificationType.news:
        var newsObject = notification as News;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    Assets.images.iconBackgroundGradient.provider(),
                foregroundImage:
                    NetworkImage(newsObject.senderIconNetworkAddress),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(buildContext)!.notificationNewsTitle,
                style: Theme.of(buildContext).textTheme.headlineMedium,
              ),
            ),
            Text(
              DateFormat('d/M/y').format(newsObject.date),
              style: Theme.of(buildContext).textTheme.labelSmall?.copyWith(
                    color: Theme.of(buildContext).colorScheme.surface,
                  ),
            ),
            DividerTheme(
              data: Theme.of(buildContext).dividerTheme.copyWith(space: 60),
              child: const Divider(),
            ),
            Text(
              newsObject.message,
              style: Theme.of(buildContext).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final notification = args as Notification?;
    final content = _buildPageContent(context, notification);

    return Flat(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: content ?? const ErrorPageContent(),
          ),
        ),
      ),
    );
  }
}
