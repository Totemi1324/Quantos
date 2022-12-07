import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'base/flat.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/splash-screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Flat(
      body: Center(
        child: RiveAnimation.asset(
          "assets/animations/quantos_logo_intro.riv",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
