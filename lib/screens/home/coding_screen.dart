import 'package:flutter/material.dart';

import '../../widgets/code/hamiltonian_input.dart';
import '../../widgets/containers/rounded_card.dart';
import '../../widgets/ui/adaptive_dropdown.dart';
import '../../widgets/ui/adaptive_message_dialog.dart';

class CodingScreen extends StatefulWidget {
  const CodingScreen({super.key});

  @override
  State<CodingScreen> createState() => _CodingScreenState();
}

class _CodingScreenState extends State<CodingScreen> {
  final List<DropdownMenuItem> _modes = const [
    DropdownMenuItem(
      value: 0,
      child: Text("Simulator"),
    ),
    DropdownMenuItem(
      value: 1,
      child: Text("DWave Advantage"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "Coding",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: const RoundedCard(
                fillHeight: false,
                fillWidth: true,
                padding: EdgeInsets.all(20),
                child: Text(
                  "Ready to take matters in your own hands? Send your Hamilton matrices to our simulator or a real-life DWave quantum annealer and use the results to solve problems nobody ever attempted before!",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Flexible(
                    child: AdaptiveDropdown(
                      items: _modes,
                      defaultSelectedIndex: 0,
                      expanded: true,
                      onChanged: (newValue) {},
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.info_outline_rounded,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => AdaptiveMessageDialog(
                        title: "Coding modes",
                        message: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: "Simulator",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const TextSpan(
                                text:
                                    " calculates the five best solutions to your Hamiltonian locally and displays them as they would come from a real quantum annealer, giving you freedom to experiment and a sense of how the real thing works. Additionally, it provides an approximate probability distribution to show how likely each result would show up.",
                              ),
                              TextSpan(
                                text: "\n\nDWave Advantage",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const TextSpan(
                                text:
                                    " sends your Hamiltonian to the latest model of a real quantum annealer by DWave Systems with 5627 qubits. In order to use this mode, you have to provide your API token. Instructions on how to create a Leap account and get your token are on our website. For security reasons, we don't save your token, so you have to re-enter it every time if you want to send an optimization problem.",
                              ),
                            ],
                          ),
                        ),
                      ),
                      barrierDismissible: true,
                    ),
                  )
                ],
              ),
            ),
            const HamiltonianInput(),
          ],
        ),
      ),
    );
  }
}
