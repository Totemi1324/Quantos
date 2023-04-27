import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/coding_service.dart';

import '../containers/panel_card.dart';
import '../part_separator.dart';
import '../ui/adaptive_form_field.dart';

class TokenInput extends StatefulWidget {
  const TokenInput({super.key});

  @override
  State<TokenInput> createState() => TokenInputState();
}

class TokenInputState extends State<TokenInput> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PartSeparator(
          AppLocalizations.of(context)!.codingTokenFormFieldSectionTitle,
          verticalMargin: 20,
        ),
        PanelCard(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.codingTokenFormFieldTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Form(
                key: _formKey,
                child: AdaptiveFormField.password(
                  AppLocalizations.of(context)!.codingTokenFormField,
                  isFinalField: true,
                  onSaved: (currentValue) => context
                      .read<CodingService>()
                      .add(UpdateToken(currentValue)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void saveToken() => _formKey.currentState?.save();
}
