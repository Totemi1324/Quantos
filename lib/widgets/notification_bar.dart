import 'package:flutter/material.dart';

class NotificationBar extends StatelessWidget {
  final height;

  const NotificationBar({required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          width: 100,
          color: Colors.red,
        ),
      ),
    );
  }
}
