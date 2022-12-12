import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SliderSelectForm extends StatefulWidget {
  final Map<int, String> divisionToString;
  final int divisions;
  final int? initialDivision;
  final String animationAsset;
  final String stateMachine;

  const SliderSelectForm({
    required this.divisions,
    required this.divisionToString,
    required this.animationAsset,
    required this.stateMachine,
    this.initialDivision,
    super.key,
  });

  @override
  State<SliderSelectForm> createState() => _SliderSelectFormState();
}

class _SliderSelectFormState extends State<SliderSelectForm> {
  late double _selected;
  late StateMachineController _controller;

  void _onInit(Artboard artboard) {
    var controller =
        StateMachineController.fromArtboard(artboard, widget.stateMachine)
            as StateMachineController;
    controller.isActive = true;
    artboard.addController(controller);
    setState(() {
      _controller = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    _selected =
        widget.initialDivision == null ? 0 : widget.initialDivision!.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 300,
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: RiveAnimation.asset(
            widget.animationAsset,
            fit: BoxFit.contain,
            onInit: _onInit,
          ),
        ),
        Text(
          widget.divisionToString[_selected] ?? "NaN",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SliderTheme(
          data: SliderThemeData.fromPrimaryColors(
            primaryColor: Theme.of(context).colorScheme.secondary,
            primaryColorDark: Colors.black,
            primaryColorLight: Colors.black,
            valueIndicatorTextStyle: Theme.of(context).textTheme.labelSmall!,
          ),
          child: Slider(
            value: _selected,
            divisions: widget.divisions,
            min: 0,
            max: widget.divisions.toDouble(),
            onChanged: (double value) {
              setState(() {
                _selected = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
