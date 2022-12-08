import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum ButtonType {
  primary,
  secondary,
}

class Button extends StatelessWidget {
  final ButtonType type;
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const Button(this.label,
      {required this.type, required this.onPressed, this.icon, super.key});

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

    return SizedBox(
      width: 140,
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
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                onPressed: onPressed,
                child: AutoSizeText(
                  label,
                  textAlign: TextAlign.center,
                  minFontSize: 14,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
