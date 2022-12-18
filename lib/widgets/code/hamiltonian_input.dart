import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../../data/hamiltonian_sizes.dart';

import '../part_separator.dart';
import '../containers/panel_card.dart';
import '../ui/adaptive_dropdown.dart';
import '../ui/adaptive_button.dart';

class HamiltonianInput extends StatefulWidget {
  const HamiltonianInput({super.key});

  @override
  State<HamiltonianInput> createState() => _HamiltonianInputState();
}

class _HamiltonianInputState extends State<HamiltonianInput> {
  late List<DropdownMenuItem> _sizes;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PartSeparator(
          "Hamiltonian",
          verticalMargin: 10,
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
                    onChanged: (p0) {},
                  ),
                  AdaptiveButton.icon(
                    "Load local",
                    onPressed: () {},
                    icon: Icons.file_upload_rounded,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
