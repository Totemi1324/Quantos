import 'package:flutter/material.dart';
import 'package:quantos/widgets/ui/adaptive_button.dart';

import '../ui/adaptive_form_field.dart';
import '../ui/adaptive_dropdown.dart';

class HelpForm extends StatefulWidget {
  final List<DropdownMenuItem> _issues = const [
    DropdownMenuItem(
      child: Text("I have a problem regarding my account"),
      value: "Account issue",
    ),
    DropdownMenuItem(
      child: Text("I want to report a bug/error in the app"),
      value: "Bug report",
    ),
    DropdownMenuItem(
      child: Text("I have an inquiry about the app or its contents"),
      value: "Feature inquiry",
    ),
    DropdownMenuItem(
      child: Text("Other"),
      value: "Other",
    ),
  ];

  const HelpForm({super.key});

  @override
  State<HelpForm> createState() => _HelpFormState();
}

class _HelpFormState extends State<HelpForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Text(
            "Select a category:",
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: AdaptiveDropdown(
              items: widget._issues,
              expanded: true,
              onChanged: (newValue) {},
            ),
          ),
          AdaptiveFormField.multiline(
            "Your message",
            prefixIcon: Icons.edit_note_rounded,
            autocorrect: true,
            enableSuggestions: true,
            isFinalField: true,
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: AdaptiveButton.secondary(
              "Send",
              extended: true,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
