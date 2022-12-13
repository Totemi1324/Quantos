import 'package:flutter/material.dart';

import './containers/rounded_card.dart';

abstract class NotificationItem extends StatelessWidget {
  final String title;

  const NotificationItem(this.title, {super.key});

  Widget buildContent(BuildContext buildContext);
  void onClose();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: onClose,
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
    );
  }
}
