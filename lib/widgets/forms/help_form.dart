import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui/adaptive_form_field.dart';
import '../ui/adaptive_dropdown.dart';
import '../ui/adaptive_button.dart';

enum HelpCategory {
  accountIssue,
  bugReport,
  featureInquiry,
  other,
}

class HelpForm extends StatefulWidget {
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
    final List<DropdownMenuItem> issues = [
      DropdownMenuItem(
        value: HelpCategory.accountIssue,
        child: Text(AppLocalizations.of(context)!.helpRequestTypeAccont),
      ),
      DropdownMenuItem(
        value: HelpCategory.bugReport,
        child: Text(AppLocalizations.of(context)!.helpRequestTypeBug),
      ),
      DropdownMenuItem(
        value: HelpCategory.featureInquiry,
        child: Text(AppLocalizations.of(context)!.helpRequestTypeFeature),
      ),
      DropdownMenuItem(
        value: HelpCategory.other,
        child: Text(AppLocalizations.of(context)!.helpRequestTypeOther),
      ),
    ];

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Text(
            AppLocalizations.of(context)!.helpInstructions,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: AdaptiveDropdown(
              items: issues,
              expanded: true,
              onChanged: (newValue) {},
            ),
          ),
          AdaptiveFormField.multiline(
            AppLocalizations.of(context)!.helpMessageFormField,
            prefixIcon: Icons.edit_note_rounded,
            autocorrect: true,
            enableSuggestions: true,
            isFinalField: true,
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: AdaptiveButton.secondary(
              AppLocalizations.of(context)!.sendButtonLabel,
              extended: true,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
