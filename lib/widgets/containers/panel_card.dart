import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme_service.dart';

class PanelCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const PanelCard({this.padding, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.watch<ThemeService>().accessibilityModeActive
        ? Colors.white
        : const Color(0xFF303859).withOpacity(0.5);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 2,
        ),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.95),
            Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.55),
          ],
          stops: const [
            0.0,
            1.0,
          ],
          begin: const Alignment(-1.0, 1.0),
          end: const Alignment(1.0, -1.0),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}
