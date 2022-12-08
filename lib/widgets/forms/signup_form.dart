import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _passwordHidden = true;
  bool _confirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    final TextStyle? inputStyle = Theme.of(context).textTheme.bodyMedium;
    final TextStyle? labelStyle = Theme.of(context).textTheme.labelSmall;

    return Form(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
            obscureText: _passwordHidden,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordHidden
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
                onPressed: () => setState(() {
                  _passwordHidden = !_passwordHidden;
                }),
              ),
              labelText: "Password",
              labelStyle: labelStyle,
            ),
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            style: inputStyle,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: _confirmPasswordHidden,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.spellcheck_rounded),
              suffixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordHidden
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
                onPressed: () => setState(() {
                  _confirmPasswordHidden = !_confirmPasswordHidden;
                }),
              ),
              labelText: "Confirm password",
              labelStyle: labelStyle,
            ),
            textInputAction: TextInputAction.send,
          )
        ],
      ),
    );
  }
}
