import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../base/flat.dart';
import '../../widgets/forms/accesscode_form.dart';

class AuthGroupAccessScreen extends StatelessWidget {
  static const routeName = "/authenticate/group-access";

  const AuthGroupAccessScreen({super.key});

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
                      AppLocalizations.of(context)!.authGroupAccessScreenTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 70),
                    child: Text(
                      AppLocalizations.of(context)!.authGroupAccessScreenInstructions,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: const AccessCodeForm(),
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
