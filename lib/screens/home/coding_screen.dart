import 'package:flutter/material.dart';

import '../../widgets/code/hamiltonian_input.dart';
import '../../widgets/containers/rounded_card.dart';
import '../../widgets/ui/adaptive_dropdown.dart';

class CodingScreen extends StatefulWidget {
  const CodingScreen({super.key});

  @override
  State<CodingScreen> createState() => _CodingScreenState();
}

class _CodingScreenState extends State<CodingScreen> {
  final List<DropdownMenuItem> _modes = const [
    DropdownMenuItem(
      child: Text("Simulator"),
      value: 0,
    ),
    DropdownMenuItem(
      child: Text("DWave Advantage"),
      value: 1,
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
                    onPressed: () {},
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
