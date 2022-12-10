import 'package:flutter/material.dart';

import '../base/flat.dart';
import '../../widgets/button.dart';

class ProfileNameScreen extends StatelessWidget {
  static const routeName = "/profile-name";

  const ProfileNameScreen({super.key});

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
                      "Hi!\nWhat's your name?",
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
                          labelText: "First name",
                          labelStyle: Theme.of(context).textTheme.labelSmall,
                        ),
                        onFieldSubmitted: (_) {},
                      ),
                    ),
                  ),
                  Button.primary(
                    "Confirm",
                    extended: true,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "I don't want to be called by my name",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                    ),
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
