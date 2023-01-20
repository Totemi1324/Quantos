import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/stores/coding_modes_store_service.dart';

import '../containers/panel_card.dart';
import '../part_separator.dart';

enum ConsoleStatus {
  idle,
  loading,
  success,
  failure,
}

class ConsoleOutput extends StatefulWidget {
  final CodingMode mode;

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
          AppLocalizations.of(buildContext)!.codingConsoleOutputMessageIdle,
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
                  FadeAnimatedText(AppLocalizations.of(buildContext)!
                      .codingConsoleOutputMessageLoading),
                  FadeAnimatedText(AppLocalizations.of(buildContext)!
                      .codingConsoleOutputMessageLoading),
                ],
                repeatForever: true,
              ),
            ),
          ],
        );
      case ConsoleStatus.success:
        return Text(
          AppLocalizations.of(buildContext)!.codingConsoleOutputMessageSuccess,
          style: defaultStyle?.copyWith(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        );
      case ConsoleStatus.failure:
        return Text(
          AppLocalizations.of(buildContext)!.codingConsoleOutputMessageFailure,
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
          widget.mode == CodingMode.simulator
              ? AppLocalizations.of(context)!.codingConsoleOutputTitleSimulator
              : AppLocalizations.of(context)!.codingConsoleOutputTitleAnnealer,
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
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground,
                    width: 2,
                  ),
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
