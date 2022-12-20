import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../containers/panel_card.dart';
import '../part_separator.dart';

enum ConsoleStatus {
  idle,
  loading,
  success,
  failure,
}

class ConsoleOutput extends StatefulWidget {
  final int mode;

  const ConsoleOutput(this.mode, {super.key});

  @override
  State<ConsoleOutput> createState() => _ConsoleOutputState();
}

class _ConsoleOutputState extends State<ConsoleOutput> {
  ConsoleStatus _status = ConsoleStatus.success;

  Widget _buildMessageForStatus(
      BuildContext buildContext, ConsoleStatus status) {
    final defaultStyle = Theme.of(buildContext).textTheme.labelMedium;
    const fallbackStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    switch (status) {
      case ConsoleStatus.idle:
        return Text(
          "Waiting for input.",
          style: defaultStyle,
        );
      case ConsoleStatus.loading:
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            const SizedBox(
              height: 25,
            ),
            DefaultTextStyle(
              style: defaultStyle ?? fallbackStyle,
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText("Waiting for response..."),
                  FadeAnimatedText("Waiting for response..."),
                ],
                repeatForever: true,
              ),
            ),
          ],
        );
      case ConsoleStatus.success:
        return Text(
          "Operation successful! Here are the top 5 solutions, sorted from best to worst energy:",
          style: defaultStyle?.copyWith(
            color: const Color(0xFF43BA73),
          ),
        );
      case ConsoleStatus.failure:
        return Text(
          "Something went wrong - unable to fetch response. If you're using DWave Advantage mode, check your internet connection, or try again.",
          style: defaultStyle?.copyWith(
            color: Theme.of(buildContext).colorScheme.error,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PartSeparator(
          "Response from the ${widget.mode == 0 ? "simulator" : "DWave"}",
          verticalMargin: 20,
        ),
        PanelCard(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMessageForStatus(context, _status),
              Container(
                height: 300,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "#1: -36.5 E\n[0, 1, 0, 0, 1, 1] x 15\n\n#2: -32.5 E\n[0, 1, 0, 0, 1, 0] x 13\n\n...",
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
