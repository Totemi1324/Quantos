import 'package:flutter/material.dart';

import '../adaptive_form_field.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _form = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AdaptiveFormField.icon(
              "Email",
              prefixIcon: Icons.alternate_email_rounded,
              autocorrect: false,
              enableSuggestions: true,
              isFinalField: false,
              nextField: _passwordFocusNode,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AdaptiveFormField.password(
              "Password",
              isFinalField: true,
              thisField: _passwordFocusNode,
            ),
          ),
        ],
      ),
    );
  }
}
