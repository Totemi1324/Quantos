import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

import 'base/flat.dart';
import 'auth/auth_home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splash-screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = _onSplashStart();
  }

  Timer _onSplashStart() {
    return Timer(const Duration(seconds: 12), () => _toNextPage(context));
  }

  void _onTap() {
    _timer.cancel();
    _toNextPage(context);
  }

  void _toNextPage(BuildContext buildContext) =>
      Navigator.of(buildContext).pushNamed(AuthHomeScreen.routeName);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Flat(
        body: Center(
          child: RiveAnimation.asset(
            Assets.animations.quantosLogoIntro,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
