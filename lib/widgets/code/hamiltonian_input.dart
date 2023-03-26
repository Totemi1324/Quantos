import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:qubo_embedder/qubo_embedder.dart';

import '../../bloc/stores/coding_modes_store_service.dart';
import '../../bloc/coding_service.dart';

import '../../data/hamiltonian_sizes.dart';
import '../../models/console_content.dart';
import '../part_separator.dart';
import '../containers/panel_card.dart';
import '../ui/adaptive_dropdown.dart';
import '../ui/adaptive_button.dart';

class HamiltonianInput extends StatefulWidget {
  final CodingMode Function() getCurrentMode;
  final VoidCallback onSubmit;

  const HamiltonianInput({
    required this.getCurrentMode,
    required this.onSubmit,
    super.key,
  });

  @override
  State<HamiltonianInput> createState() => _HamiltonianInputState();
}

class _HamiltonianInputState extends State<HamiltonianInput> {
  late List<DropdownMenuItem> _sizes;
  late Qubo _qubo;
  int _selectedSize = 4;
  bool _canSend = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setState(() {
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
        _sizes = sizes.where((item) => item.value <= 6).toList();
      } else {
        _sizes = sizes;
      }
      _qubo = Qubo(size: _selectedSize);
    });
  }

  Widget _buildInputField(BuildContext buildContext, int i, int j) =>
      TextFormField(
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) =>
            value != null && value != "" && double.tryParse(value) == null
                ? ""
                : null,
        onSaved: (newValue) {
          final value = double.tryParse(newValue ?? "");
          if (value != null) {
            _qubo.addEntry(i, j, value: value);
          }
        },
      );

  List<Widget> _buildGrid(BuildContext buildContext) {
    var result = List<Widget>.empty(growable: true);
    for (var i = 0; i < _selectedSize; i++) {
      for (var j = 0; j < _selectedSize; j++) {
        if (j >= i) {
          result.add(
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(buildContext)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildInputField(buildContext, i, j),
            ),
          );
        } else {
          result.add(
            Container(
              alignment: Alignment.center,
              child: Text(
                "0",
                style: Theme.of(buildContext).textTheme.labelLarge,
              ),
            ),
          );
        }
      }
    }
    return result;
  }

  bool _submitHamiltonian(BuildContext buildContext, CodingMode codingMode) {
    final inputsAreValid = _formKey.currentState?.validate();
    if (inputsAreValid == null || !inputsAreValid) {
      return false;
    }
    _formKey.currentState?.save();

    switch (codingMode) {
      case CodingMode.simulator:
        buildContext.read<CodingService>().add(SendSimulator(_qubo));
        _qubo = Qubo(size: _selectedSize);
        break;
      case CodingMode.annealer:
        buildContext.read<CodingService>().add(SendAdvantage(_qubo));
        _qubo = Qubo(size: _selectedSize);
        break;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CodingService, ConsoleContent>(
      listener: (context, state) {
        if (state.status == ConsoleStatus.loading) {
          _canSend = false;
        } else {
          if (!_canSend) {
            _canSend = true;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PartSeparator(
            AppLocalizations.of(context)!.codingHamiltonianInputTitle,
            verticalMargin: 20,
          ),
          PanelCard(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AdaptiveDropdown(
                      items: _sizes,
                      defaultSelectedIndex: 2,
                      onChanged: (newValue) {
                        if (newValue is int) {
                          setState(() {
                            _selectedSize = newValue;
                            _qubo = Qubo(size: newValue);
                            _formKey.currentState?.reset();
                          });
                        }
                      },
                    ),
                    AdaptiveButton.icon(
                      AppLocalizations.of(context)!
                          .codingHamiltonianInputLoadButtonLabel,
                      enabled: true,
                      onPressed: () {},
                      icon: Icons.file_upload_rounded,
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: UniversalPlatform.isWeb ? 600 : 350,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: GridView.custom(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _selectedSize,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        childrenDelegate: SliverChildListDelegate.fixed(
                          _buildGrid(context),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    AppLocalizations.of(context)!
                        .codingHamiltonianInputInstructions,
                    textAlign: TextAlign.center,
                  ),
                ),
                AdaptiveButton.secondary(
                  AppLocalizations.of(context)!.sendButtonLabel,
                  extended: false,
                  enabled: _canSend,
                  onPressed: () {
                    final selectedMode = widget.getCurrentMode();
                    final success = _submitHamiltonian(context, selectedMode);
                    if (success) {
                      widget.onSubmit();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
