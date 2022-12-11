import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 100,
        child: RiveAnimation.asset(
          "assets/animations/circular_progress_indicator.riv",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
