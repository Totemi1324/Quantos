import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccessCodeForm extends StatefulWidget {
  const AccessCodeForm({super.key});

  @override
  State<AccessCodeForm> createState() => _AccessCodeFormState();
}

class _AccessCodeFormState extends State<AccessCodeForm> {
  final _form = GlobalKey<FormState>();
  final _nodes = List<FocusNode>.generate(6, (index) => FocusNode());

  Widget _buildAutoFormField(
    BuildContext buildContext, {
    required int index,
  }) {
    return SizedBox(
      width: 35,
      child: TextFormField(
        style: Theme.of(buildContext).textTheme.bodyLarge,
        textAlign: TextAlign.center,
        textCapitalization: TextCapitalization.characters,
        inputFormatters: [
          UpperCaseTextFormatter(),
          LengthLimitingTextInputFormatter(1),
        ],
        autocorrect: false,
        enableSuggestions: false,
        focusNode: _nodes[index],
        onChanged: (value) => _onFormFieldChange(
          buildContext,
          value,
          index > 0 ? _nodes[index - 1] : null,
          index < 5 ? _nodes[index + 1] : null,
        ),
      ),
    );
  }

  void _onFormFieldChange(
    BuildContext buildContext,
    String newValue,
    FocusNode? prev,
    FocusNode? next,
  ) {
    if (next != null) {
      if (newValue.isEmpty) {
        FocusScope.of(context).requestFocus(prev);
      } else {
        FocusScope.of(context).requestFocus(next);
      }
    } else if (prev != null && newValue.isEmpty) {
      FocusScope.of(context).requestFocus(prev);
    } else {
      // Submit
    }
  }

  @override
  void dispose() {
    _nodes.forEach((element) => element.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAutoFormField(context, index: 0),
          _buildAutoFormField(context, index: 1),
          _buildAutoFormField(context, index: 2),
          Text(
            "-",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          _buildAutoFormField(context, index: 3),
          _buildAutoFormField(context, index: 4),
          _buildAutoFormField(context, index: 5),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
