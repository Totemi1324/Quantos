import 'package:flutter/material.dart';

class AdaptiveFormField extends StatefulWidget {
  final String labelText;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool isFinalField;
  final FocusNode? thisField;
  final FocusNode? nextField;
  final IconData? prefixIcon;
  final bool passwordField;
  final bool multiline;

  const AdaptiveFormField(
    this.labelText, {
    required this.autocorrect,
    required this.enableSuggestions,
    required this.isFinalField,
    this.thisField,
    this.nextField,
    this.prefixIcon,
    this.passwordField = false,
    this.multiline = false,
    super.key,
  });

  factory AdaptiveFormField.icon(String labelText,
          {required IconData prefixIcon,
          required bool autocorrect,
          required bool enableSuggestions,
          required bool isFinalField,
          FocusNode? thisField,
          FocusNode? nextField}) =>
      AdaptiveFormField(
        labelText,
        prefixIcon: prefixIcon,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        isFinalField: isFinalField,
        thisField: thisField,
        nextField: nextField,
      );

  factory AdaptiveFormField.password(String labelText,
          {required bool isFinalField,
          IconData? prefixIcon,
          FocusNode? thisField,
          FocusNode? nextField}) =>
      AdaptiveFormField(
        labelText,
        autocorrect: false,
        enableSuggestions: false,
        isFinalField: isFinalField,
        thisField: thisField,
        nextField: nextField,
        prefixIcon: prefixIcon,
        passwordField: true,
      );

  factory AdaptiveFormField.multiline(String labelText,
          {required bool autocorrect,
          required bool enableSuggestions,
          required bool isFinalField,
          IconData? prefixIcon,
          FocusNode? thisField,
          FocusNode? nextField}) =>
      AdaptiveFormField(
        labelText,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        isFinalField: isFinalField,
        prefixIcon: prefixIcon,
        multiline: true,
        thisField: thisField,
        nextField: nextField,
      );

  @override
  State<AdaptiveFormField> createState() => _AdaptiveFormFieldState();
}

class _AdaptiveFormFieldState extends State<AdaptiveFormField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      obscureText: widget.passwordField ? _hidden : false,
      focusNode: widget.thisField,
      keyboardType: widget.multiline ? TextInputType.multiline : null,
      maxLines: widget.multiline ? null : 1,
      textInputAction: widget.multiline
          ? TextInputAction.newline
          : (widget.isFinalField ? TextInputAction.done : TextInputAction.next),
      onFieldSubmitted: !widget.isFinalField
          ? (_) => FocusScope.of(context).requestFocus(widget.nextField)
          : null,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon)
            : (widget.passwordField
                ? const Icon(Icons.lock_outline_rounded)
                : null),
        suffixIcon: widget.passwordField
            ? IconButton(
                icon: Icon(
                  _hidden
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
                tooltip: "Show or hide password",
                onPressed: () => setState(() {
                  _hidden = !_hidden;
                }),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
