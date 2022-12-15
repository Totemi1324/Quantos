import 'package:flutter/material.dart';

class ErrorPageContent extends StatelessWidget {
  const ErrorPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "404",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontSize: 90,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Sorry, we couldn't find the page you're looking for...",
        )
      ],
    );
  }
}
