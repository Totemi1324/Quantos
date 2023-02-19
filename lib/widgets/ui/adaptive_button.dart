import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../bloc/theme_service.dart';

enum ButtonType {
  primary,
  secondary,
}

class AdaptiveButton extends StatelessWidget {
  final ButtonType type;
  final String label;
  final bool extended;
  final bool navigator;
  final VoidCallback onPressed;
  final IconData? icon;

  const AdaptiveButton(this.label,
      {required this.type,
      required this.extended,
      required this.navigator,
      required this.onPressed,
      this.icon,
      super.key});

  factory AdaptiveButton.primary(String label,
          {required bool extended, required VoidCallback onPressed}) =>
      AdaptiveButton(
        label,
        type: ButtonType.primary,
        extended: extended,
        navigator: false,
        onPressed: onPressed,
      );

  factory AdaptiveButton.secondary(String label,
          {required bool extended, required VoidCallback onPressed}) =>
      AdaptiveButton(
        label,
        type: ButtonType.secondary,
        extended: extended,
        navigator: false,
        onPressed: onPressed,
      );

  factory AdaptiveButton.icon(String label,
          {required VoidCallback onPressed, required IconData icon}) =>
      AdaptiveButton(
        label,
        type: ButtonType.primary,
        extended: false,
        navigator: false,
        onPressed: onPressed,
        icon: icon,
      );

  factory AdaptiveButton.navigator(
          {required ButtonType type,
          required VoidCallback onPressed,
          required IconData icon}) =>
      AdaptiveButton(
        "",
        type: type,
        extended: false,
        navigator: true,
        onPressed: onPressed,
        icon: icon,
      );

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decorationFirstLayer = BoxDecoration(
      gradient: LinearGradient(
        colors: type == ButtonType.primary
            ? [
                const Color(0xFF0282B1),
                const Color(0xFF2EB6E8),
              ]
            : [
                const Color(0xFFE78AD8),
                const Color(0xFFF1B6E8),
              ],
        stops: const [0.0, 1.0],
        begin: const Alignment(-0.3, 1.0),
        end: const Alignment(0.3, -1.0),
      ),
    );

    final BoxDecoration decorationSecondLayer = BoxDecoration(
      gradient: RadialGradient(
        colors: [
          Colors.transparent,
          type == ButtonType.primary
              ? const Color.fromRGBO(12, 43, 54, 0.2)
              : const Color.fromRGBO(70, 19, 62, 0.2),
        ],
        center: const Alignment(0.6, -1.5),
        radius: 2,
        stops: const [0.5, 1.0],
      ),
    );

    final AutoSizeText labelText = AutoSizeText(
      label,
      textAlign: TextAlign.center,
      minFontSize: 12,
      maxLines: 2,
      overflow: TextOverflow.fade,
    );

    return SizedBox(
      width: navigator ? 60 : (extended ? double.infinity : 140),
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Container(
                decoration: decorationFirstLayer,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: decorationSecondLayer,
              ),
            ),
            Positioned.fill(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor:
                      context.read<ThemeService>().accessibilityModeActive
                          ? Theme.of(context).colorScheme.onPrimary
                          : Colors.white,
                  padding: navigator
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                onPressed: onPressed,
                child: icon == null
                    ? labelText
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            icon,
                            color: context
                                    .read<ThemeService>()
                                    .accessibilityModeActive
                                ? Theme.of(context).colorScheme.onPrimary
                                : Colors.white,
                            size: navigator ? 50 : 30,
                          ),
                          if (!navigator) Flexible(child: labelText),
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
