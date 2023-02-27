import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile_info_service.dart';

import '../base/flat.dart';
import './profile_age_screen.dart';
import '../../models/profile_info.dart';
import '../../widgets/ui/adaptive_button.dart';

class ProfileNameScreen extends StatelessWidget {
  static const routeName = "/profile";
  final _formKey = GlobalKey<FormState>();

  ProfileNameScreen({super.key});

  void _onSubmit(BuildContext buildContext) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(buildContext).pushNamed(ProfileAgeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileInfoService, ProfileInfo>(
      builder: (context, state) => GestureDetector(
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
                        key: _formKey,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          autocorrect: false,
                          enableSuggestions: true,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .profileNameScreenFormField,
                            labelStyle: Theme.of(context).textTheme.labelSmall,
                          ),
                          onSaved: (newValue) {
                            if (newValue == null || newValue == "") {
                              context.read<ProfileInfoService>().eraseName();
                            } else {
                              context
                                  .read<ProfileInfoService>()
                                  .updateName(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                    AdaptiveButton.primary(
                      AppLocalizations.of(context)!.confirmButtonLabel,
                      extended: true,
                      enabled: true,
                      onPressed: () {
                        _formKey.currentState?.save();
                        _onSubmit(context);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        _formKey.currentState?.save();
                        _onSubmit(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .profileNameScreenTextButtonLabel,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
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
      ),
    );
  }
}
