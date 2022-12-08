import 'package:flutter/material.dart';

class Flat extends StatelessWidget {
  final Widget body;

  const Flat({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.7, -0.6),
          radius: 2,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: ModalRoute.of(context)?.canPop == true
              ? IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                  ),
                )
              : null,
        ),
        body: body,
      ),
    );
  }
}
