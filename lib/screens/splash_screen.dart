import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication_service.dart';
import '../loading_routines.dart';

import 'base/flat.dart';
import 'base/home.dart';
import 'auth/auth_home_screen.dart';
import './loading_screen.dart';

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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Timer _onSplashStart() {
    return Timer(const Duration(seconds: 12), () => _toNextPage(context));
  }

  void _onTap() {
    _timer.cancel();
    _toNextPage(context);
  }

  Future _toNextPage(BuildContext buildContext) async {
    _timer.cancel();
    final autoLoginSuccessful =
        await buildContext.read<AuthenticationService>().attemptAutoLogIn();
    if (!mounted) return;

    if (autoLoginSuccessful ||
        buildContext.read<AuthenticationService>().isAuthenticated) {
      Navigator.of(buildContext).pushReplacement(
        MaterialPageRoute(
          builder: (buildContext) => LoadingScreen(
            [
              getDefaultLoadingRoutine(buildContext),
            ],
            Home.routeName,
          ),
        ),
      );
    } else {
      Navigator.of(buildContext).pushReplacementNamed(AuthHomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Flat(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: RiveAnimation.asset(
              Assets.animations.quantosLogoIntro,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
