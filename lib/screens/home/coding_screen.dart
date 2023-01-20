import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/coding_mode.dart';
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
  final List<DropdownMenuItem<CodingMode>> _modes = [
    const DropdownMenuItem(
      value: CodingMode.simulator,
      child: Text("Simulator"),
    ),
    const DropdownMenuItem(
      value: CodingMode.annealer,
      child: Text("DWave Advantage"),
    ),
  ];

  CodingMode _selectedMode = CodingMode.simulator;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _modes[0] = DropdownMenuItem(
      value: CodingMode.simulator,
      child: Text(AppLocalizations.of(context)!.codingModeSimulator),
    );
    _modes[1] = DropdownMenuItem(
      value: CodingMode.annealer,
      child: Text(AppLocalizations.of(context)!.codingModeAnnealer),
    );

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
                  AppLocalizations.of(context)!.codingScreenTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: RoundedCard(
                  fillHeight: false,
                  fillWidth: true,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    AppLocalizations.of(context)!.codingScreenInstructions,
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
                          if (newValue is CodingMode) {
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
              if (_selectedMode == CodingMode.annealer) const TokenInput(),
              HamiltonianInput(
                onSubmit: () {
                  if (_outputConsoleKey.currentContext != null) {
                    Scrollable.ensureVisible(
                      _outputConsoleKey.currentContext as BuildContext,
                    );
                  }
                },
              ),
              ConsoleOutput(
                _selectedMode,
                key: _outputConsoleKey,
              ),
              if (_selectedMode == CodingMode.simulator) const ProbabilityDistribution(),
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
