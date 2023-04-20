import 'package:flutter/material.dart';
import 'dart:async';

import 'base/flat.dart';
import '../widgets/custom_circular_progress_indicator.dart';

class LoadingScreen extends StatefulWidget {
  final List<Future> loadingRoutines;
  final String nextRoute;
  final dynamic arguments;

  const LoadingScreen(
    this.loadingRoutines,
    this.nextRoute, {
    this.arguments,
    super.key,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      for (var routine in widget.loadingRoutines) {
        await routine;
      }
      if (!mounted) {
        return;
      }
      _toNextPage(context);
    });
  }

  void _toNextPage(BuildContext buildContext) => Navigator.of(buildContext)
      .pushReplacementNamed(widget.nextRoute, arguments: widget.arguments);

  @override
  Widget build(BuildContext context) {
    return const Flat(
      body: CustomCircularProgressIndicator(),
    );
  }
}
