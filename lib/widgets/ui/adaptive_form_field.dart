import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final Function(String?) onSaved;

  const AdaptiveFormField(
    this.labelText, {
    required this.autocorrect,
    required this.enableSuggestions,
    required this.isFinalField,
    required this.onSaved,
    this.thisField,
    this.nextField,
    this.prefixIcon,
    this.passwordField = false,
    this.multiline = false,
    this.validator,
    this.autoValidateMode,
    super.key,
  });

  factory AdaptiveFormField.icon(String labelText,
          {required IconData prefixIcon,
          required bool autocorrect,
          required bool enableSuggestions,
          required bool isFinalField,
          required Function(String?) onSaved,
          FocusNode? thisField,
          FocusNode? nextField,
          String? Function(String?)? validator,
          AutovalidateMode? autoValidateMode}) =>
      AdaptiveFormField(
        labelText,
        prefixIcon: prefixIcon,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        isFinalField: isFinalField,
        onSaved: onSaved,
        thisField: thisField,
        nextField: nextField,
        validator: validator,
        autoValidateMode: autoValidateMode,
      );

  factory AdaptiveFormField.password(String labelText,
          {required bool isFinalField,
          required Function(String?) onSaved,
          IconData? prefixIcon,
          FocusNode? thisField,
          FocusNode? nextField,
          String? Function(String?)? validator,
          AutovalidateMode? autoValidateMode}) =>
      AdaptiveFormField(
        labelText,
        autocorrect: false,
        enableSuggestions: false,
        isFinalField: isFinalField,
        onSaved: onSaved,
        thisField: thisField,
        nextField: nextField,
        prefixIcon: prefixIcon,
        passwordField: true,
        validator: validator,
        autoValidateMode: autoValidateMode,
      );

  factory AdaptiveFormField.multiline(String labelText,
          {required bool autocorrect,
          required bool enableSuggestions,
          required bool isFinalField,
          required Function(String?) onSaved,
          IconData? prefixIcon,
          FocusNode? thisField,
          FocusNode? nextField}) =>
      AdaptiveFormField(
        labelText,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        isFinalField: isFinalField,
        onSaved: onSaved,
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
      onSaved: widget.onSaved,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode ?? AutovalidateMode.disabled,
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
                tooltip: AppLocalizations.of(context)?.tooltipShowHidePassword,
                onPressed: () => setState(() {
                  _hidden = !_hidden;
                }),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.labelSmall,
        errorMaxLines: 6,
      ),
    );
  }
}
