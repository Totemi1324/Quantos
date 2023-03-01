import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AdaptiveSwitch extends StatefulWidget {
  final bool? defaultEnabled;
  final Function onToggle;

  const AdaptiveSwitch(
      {required this.onToggle, this.defaultEnabled, super.key});

  @override
  State<AdaptiveSwitch> createState() => _AdaptiveSwitchState();
}

class _AdaptiveSwitchState extends State<AdaptiveSwitch> {
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _enabled = widget.defaultEnabled ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _enabled
          ? AppLocalizations.of(context)!.tooltipToggleOn
          : AppLocalizations.of(context)!.tooltipToggleOff,
      child: FlutterSwitch(
        value: _enabled,
        inactiveColor: Theme.of(context).colorScheme.error,
        activeColor: Theme.of(context).colorScheme.onErrorContainer,
        switchBorder: Border.all(
          color: Theme.of(context).colorScheme.onBackground,
          width: 2,
        ),
        onToggle: (newValue) {
          widget.onToggle(newValue);
          setState(() {
            _enabled = newValue;
          });
        },
      ),
    );
  }
}
