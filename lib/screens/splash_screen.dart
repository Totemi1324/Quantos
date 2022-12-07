import 'package:flutter/material.dart';

import 'base/flat.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/splash-screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Flat(
      body: Center(
        child: Text(
          "Splash screen",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
