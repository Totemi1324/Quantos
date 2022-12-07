import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async';

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

  void _toNextPage(BuildContext buildContext) {
    Navigator.of(buildContext).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const AuthHomeScreen(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var animationCurve =
            CurvedAnimation(parent: animation, curve: Curves.ease);
        return FadeTransition(
          opacity: animationCurve,
          child: child,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: const Flat(
        body: Center(
          child: RiveAnimation.asset(
            "assets/animations/quantos_logo_intro.riv",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
