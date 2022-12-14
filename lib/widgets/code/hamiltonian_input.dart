import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../../data/hamiltonian_sizes.dart';

import '../part_separator.dart';
import '../containers/panel_card.dart';
import '../ui/adaptive_dropdown.dart';
import '../ui/adaptive_button.dart';

class HamiltonianInput extends StatefulWidget {
  final VoidCallback onSubmit;

  const HamiltonianInput({required this.onSubmit, super.key});

  @override
  State<HamiltonianInput> createState() => _HamiltonianInputState();
}

class _HamiltonianInputState extends State<HamiltonianInput> {
  late List<DropdownMenuItem> _sizes;
  int _selectedSize = 4;

  final _formKey = GlobalKey<FormState>();
  final Widget _inputField = TextFormField(
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.all(0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none, //<-- SEE HERE
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none, //<-- SEE HERE
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();

    setState(() {
      if (Platform.isAndroid || Platform.isIOS) {
        _sizes = sizes.where((item) => item.value <= 6).toList();
      } else {
        _sizes = sizes;
      }
    });
  }

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
              child: _inputField,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PartSeparator(
          "Hamiltonian",
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
                          _formKey.currentState?.reset();
                        });
                      }
                    },
                  ),
                  AdaptiveButton.icon(
                    "Load local",
                    onPressed: () {},
                    icon: Icons.file_upload_rounded,
                  ),
                ],
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 350),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: GridView.count(
                      crossAxisCount: _selectedSize,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: _buildGrid(context),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Upon sending, empty fields will be set to 0.",
                  textAlign: TextAlign.center,
                ),
              ),
              AdaptiveButton.secondary(
                "Send",
                extended: false,
                onPressed: widget.onSubmit,
              )
            ],
          ),
        ),
      ],
    );
  }
}
