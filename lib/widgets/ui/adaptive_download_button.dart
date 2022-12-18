import 'package:flutter/material.dart';

class AdaptiveDownloadButton extends StatelessWidget {
  final String link;

  const AdaptiveDownloadButton(this.link, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [
                Color(0xFFDADADA),
                Color(0xFFBDBDBD),
              ],
              stops: [0.3, 1.0],
              center: Alignment(0.3, -0.5),
              radius: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 5),
                blurRadius: 5,
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          iconSize: 50,
          icon: Icon(
            Icons.download_for_offline_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
