import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    final TextStyle? inputStyle = Theme.of(context).textTheme.bodyMedium;
    final TextStyle? labelStyle = Theme.of(context).textTheme.labelSmall;

    return Form(
      child: Flexible(
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              style: inputStyle,
              autocorrect: false,
              enableSuggestions: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.alternate_email_rounded),
                labelText: "Email",
                labelStyle: labelStyle,
              ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              style: inputStyle,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                labelText: "Password",
                labelStyle: labelStyle,
              ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              style: inputStyle,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.spellcheck_rounded),
                labelText: "Confirm password",
                labelStyle: labelStyle,
              ),
              textInputAction: TextInputAction.send,
            )
          ],
        ),
      ),
    );
  }
}
