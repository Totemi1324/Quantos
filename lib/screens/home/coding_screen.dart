import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../bloc/stores/coding_modes_store_service.dart';
import '../../bloc/coding_service.dart';
import '../../bloc/localization_service.dart';
import '../../bloc/database_service.dart';

import '../../models/console_content.dart';
import '../../models/user_data.dart';
import '../../widgets/code/token_input.dart';
import '../../widgets/code/coding_mode_info_popup.dart';
import '../../widgets/code/beginner_warning_popup.dart';
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
  final GlobalKey<TokenInputState> _tokenInputKey = GlobalKey();

  CodingMode _selectedMode = CodingMode.simulator;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final databaseService = context.read<DatabaseService>();
      if (databaseService.state.experience == Experience.beginner &&
          databaseService.lectionProgress("8hg") == 0.0) {
        showDialog(
          context: context,
          builder: (_) => const BeginnerWarningPopup(),
          barrierDismissible: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CodingModesStoreService(
              context.read<LocalizationService>().state),
        ),
        BlocProvider(
          create: (_) => CodingService(),
        ),
      ],
      child: BlocBuilder<CodingModesStoreService,
          List<DropdownMenuItem<CodingMode>>>(
        builder: (context, _) => BlocBuilder<CodingService, ConsoleContent>(
          builder: (context, _) => BlocListener<LocalizationService, Locale>(
            listener: (context, state) =>
                context.read<CodingModesStoreService>().updateStore(state),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: UniversalPlatform.isWeb
                            ? Alignment.center
                            : Alignment.centerLeft,
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
                            AppLocalizations.of(context)!
                                .codingScreenInstructions,
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
                                items: context
                                    .read<CodingModesStoreService>()
                                    .state,
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
                              tooltip: AppLocalizations.of(context)!
                                  .tooltipInformation,
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
                      if (_selectedMode == CodingMode.annealer)
                        TokenInput(
                          key: _tokenInputKey,
                        ),
                      HamiltonianInput(
                        getCurrentMode: () => _selectedMode,
                        tokenInputKey: _tokenInputKey,
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
                      if (_selectedMode == CodingMode.simulator)
                        const ProbabilityDistribution(),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
