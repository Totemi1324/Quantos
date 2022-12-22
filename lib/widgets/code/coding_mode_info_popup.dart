import 'package:flutter/material.dart';

import '../ui/adaptive_message_dialog.dart';

class CodingModeInfoPopup extends StatelessWidget {
  const CodingModeInfoPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveMessageDialog(
      title: "Coding modes",
      message: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "Simulator",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const TextSpan(
              text:
                  " calculates the five best solutions to your Hamiltonian locally and displays them as they would come from a real quantum annealer, giving you freedom to experiment and a sense of how the real thing works. Additionally, it provides an approximate probability distribution to show how likely each result would show up.",
            ),
            TextSpan(
              text: "\n\nDWave Advantage",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const TextSpan(
              text:
                  " sends your Hamiltonian to the latest model of a real quantum annealer by DWave Systems with 5627 qubits. In order to use this mode, you have to provide your API token. Instructions on how to create a Leap account and get your token are on our website. For security reasons, we don't save your token, so you have to re-enter it every time you want to send an optimization problem.",
            ),
          ],
        ),
      ),
    );
  }
}
