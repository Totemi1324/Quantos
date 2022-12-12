import 'package:flutter/material.dart';

class PanelCard extends StatelessWidget {
  final Widget child;

  const PanelCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF303859).withOpacity(0.5),
          width: 2,
        ),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF404B75).withOpacity(0.95),
            const Color(0xFF404B75).withOpacity(0.55),
          ],
          stops: const [
            0.0,
            1.0,
          ],
          begin: const Alignment(-1.0, 1.0),
          end: const Alignment(1.0, -1.0),
        ),
      ),
      child: child,
    );
  }
}
