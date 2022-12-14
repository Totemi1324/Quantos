import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AdaptiveSwitch extends StatefulWidget {
  final bool? defaultEnabled;
  final VoidCallback onToggle;

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
    return FlutterSwitch(
      value: _enabled,
      inactiveColor: Theme.of(context).colorScheme.error,
      activeColor: const Color(0xFF43BA73),
      switchBorder: Border.all(
        color: Theme.of(context).colorScheme.onBackground,
        width: 2,
      ),
      onToggle: (newValue) {
        widget.onToggle();
        setState(() {
          _enabled = newValue;
        });
      },
    );
  }
}
