import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/notification.dart';
import '../containers/rounded_card.dart';

abstract class NotificationItem extends StatelessWidget {
  final NotificationType type;
  final bool dismissible;

  const NotificationItem(this.type, {required this.dismissible, super.key});

  Widget buildContent(BuildContext buildContext);
  void onClose();
  void onOpen();

  @protected
  String _typeToString(BuildContext buildContext, NotificationType type) {
    switch (type) {
      case NotificationType.news:
        return AppLocalizations.of(buildContext)!.notificationNewsTitle;
      case NotificationType.statistic:
        return AppLocalizations.of(buildContext)!.notificationStatisticTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpen,
      child: Stack(
        children: [
          RoundedCard(
            fillHeight: true,
            fillWidth: true,
            aspectRatio: 3 / 2,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: buildContent(context),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              _typeToString(context, type),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          if (dismissible)
            Positioned(
              top: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: onClose,
                    tooltip: AppLocalizations.of(context)!.tooltipClose,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
