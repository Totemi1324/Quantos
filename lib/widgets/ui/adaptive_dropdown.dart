import 'package:flutter/material.dart';

class AdaptiveDropdown extends StatefulWidget {
  final List<DropdownMenuItem> items;
  final int defaultSelectedIndex;
  final Function(dynamic) onChanged;
  final bool expanded;

  const AdaptiveDropdown(
      {required this.items,
      required this.onChanged,
      this.expanded = false,
      this.defaultSelectedIndex = 0,
      super.key});

  @override
  State<AdaptiveDropdown> createState() => _AdaptiveDropdownState();
}

class _AdaptiveDropdownState extends State<AdaptiveDropdown> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: widget.items,
      value: widget.items[_selectedIndex].value,
      isExpanded: widget.expanded,
      itemHeight: null,
      onChanged: (value) {
        widget.onChanged(value);
        for (var i = 0; i < widget.items.length; i++) {
          if (widget.items[i].value == value) {
            setState(() {
              _selectedIndex = i;
            });
          }
        }
      },
      dropdownColor: Theme.of(context).colorScheme.surface,
      iconSize: 40,
      icon: const Icon(Icons.expand_more_rounded),
    );
  }
}
