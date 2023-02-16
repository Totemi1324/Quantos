import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        child: RiveAnimation.asset(
          Assets.animations.circularProgressIndicator,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
