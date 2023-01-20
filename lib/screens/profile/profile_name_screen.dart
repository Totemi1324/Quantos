import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../base/flat.dart';
import './profile_age_screen.dart';
import '../../widgets/ui/adaptive_button.dart';

class ProfileNameScreen extends StatelessWidget {
  static const routeName = "/profile";

  const ProfileNameScreen({super.key});

  void _onSubmit(BuildContext buildContext, String? name) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(buildContext)
        .pushNamed(ProfileAgeScreen.routeName, arguments: name);
  }

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
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      AppLocalizations.of(context)!.profileNameScreenTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 120),
                    child: Form(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        autocorrect: false,
                        enableSuggestions: true,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.profileNameScreenFormField,
                          labelStyle: Theme.of(context).textTheme.labelSmall,
                        ),
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                  ),
                  AdaptiveButton.primary(
                    AppLocalizations.of(context)!.confirmButtonLabel,
                    extended: true,
                    onPressed: () => _onSubmit(context, "Tamas"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () => _onSubmit(context, null),
                    child: Text(
                      AppLocalizations.of(context)!.profileNameScreenTextButtonLabel,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
