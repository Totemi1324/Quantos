import 'package:flutter/material.dart';
import 'dart:async';

import 'base/flat.dart';
import '../widgets/custom_circular_progress_indicator.dart';

class LoadingScreen extends StatefulWidget {
  final String nextRoute;

  const LoadingScreen(this.nextRoute, {super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // TEMPORARY CODE
    _timer = _onSplashStart();
  }

  Timer _onSplashStart() {
    return Timer(const Duration(seconds: 3), () => _toNextPage(context));
  }

  void _toNextPage(BuildContext buildContext) =>
      Navigator.of(buildContext).pushReplacementNamed(widget.nextRoute);

  @override
  Widget build(BuildContext context) {
    return const Flat(
      body: CustomCircularProgressIndicator(),
    );
  }
}
