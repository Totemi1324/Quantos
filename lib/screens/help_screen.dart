import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './base/flat.dart';
import '../widgets/forms/help_form.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = "/settings/help";

  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Flat(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 50),
                    child: Text(
                      AppLocalizations.of(context)!.helpScreenTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      AppLocalizations.of(context)!.helpScreenInstructions,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 50),
                    child: const HelpForm(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
