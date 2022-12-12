import 'package:flutter/material.dart';

import '../ui/adaptive_form_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _form = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          AdaptiveFormField.icon(
            "Email",
            prefixIcon: Icons.alternate_email_rounded,
            autocorrect: false,
            enableSuggestions: true,
            isFinalField: false,
            nextField: _passwordFocusNode,
          ),
          AdaptiveFormField.password(
            "Password",
            isFinalField: false,
            thisField: _passwordFocusNode,
            nextField: _confirmPasswordFocusNode,
          ),
          AdaptiveFormField.password(
            "Confirm password",
            prefixIcon: Icons.spellcheck_rounded,
            isFinalField: true,
            thisField: _confirmPasswordFocusNode,
          )
        ],
      ),
    );
  }
}
