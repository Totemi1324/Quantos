import 'package:flutter/material.dart';

import '../../widgets/code/token_input.dart';
import '../../widgets/code/coding_mode_info_popup.dart';
import '../../widgets/code/hamiltonian_input.dart';
import '../../widgets/code/console_output.dart';
import '../../widgets/code/probability_distribution.dart';
import '../../widgets/containers/rounded_card.dart';
import '../../widgets/ui/adaptive_dropdown.dart';

class CodingScreen extends StatefulWidget {
  const CodingScreen({super.key});

  @override
  State<CodingScreen> createState() => _CodingScreenState();
}

class _CodingScreenState extends State<CodingScreen> {
  final _outputConsoleKey = GlobalKey();
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
  late List<List<Widget>> _modeContent;

  int _selectedMode = 0;

  @override
  void initState() {
    super.initState();
    _modeContent = List<List<Widget>>.empty(growable: true);

    _modeContent.add([
      HamiltonianInput(
        onSubmit: () =>
            Scrollable.ensureVisible(_outputConsoleKey.currentContext!),
      ),
      ConsoleOutput(_selectedMode),
      const ProbabilityDistribution(),
    ]);
    _modeContent.add([
      const TokenInput(),
      HamiltonianInput(
        onSubmit: () =>
            Scrollable.ensureVisible(_outputConsoleKey.currentContext!),
      ),
      ConsoleOutput(_selectedMode),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
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
                        onChanged: (newValue) {
                          if (newValue is int) {
                            setState(() {
                              _selectedMode = newValue;
                            });
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info_outline_rounded,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => const CodingModeInfoPopup(),
                        barrierDismissible: true,
                      ),
                    )
                  ],
                ),
              ),
              if (_modeContent.isNotEmpty) ..._modeContent[_selectedMode],
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
