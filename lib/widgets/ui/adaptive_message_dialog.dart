import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';

class AdaptiveMessageDialog extends StatelessWidget {
  final String? title;
  final Widget message;
  final String dismissActionName;

  const AdaptiveMessageDialog({
    required this.message,
    this.title,
    this.dismissActionName = "OK",
    super.key,
  });

  Widget _buildMaterialDialog(BuildContext buildContext) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      content: SingleChildScrollView(child: message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(buildContext).pop(),
          child: Text(
            dismissActionName,
            style: TextStyle(
              color: Theme.of(buildContext).colorScheme.secondary,
            ),
          ),
        )
      ],
      elevation: 24,
      backgroundColor: Theme.of(buildContext).colorScheme.surface,
    );
  }

  Widget _buildCupertinoDialog(BuildContext buildContext) {
    return CupertinoAlertDialog(
      title: title != null ? Text(title!) : null,
      content: SingleChildScrollView(child: message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(buildContext).pop(),
          child: Text(
            dismissActionName,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return UniversalPlatform.isIOS || UniversalPlatform.isMacOS
        ? _buildCupertinoDialog(context)
        : _buildMaterialDialog(context);
  }
}
