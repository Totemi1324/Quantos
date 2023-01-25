import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import './ui/adaptive_progress_bar.dart';

class LectionItem extends StatefulWidget {
  final String iconAnimationAsset;
  final String title;
  final double progressPercent;
  final bool unlocked;

  static const ColorFilter grayscaleImageFilter = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  const LectionItem(
    this.title, {
    required this.iconAnimationAsset,
    required this.progressPercent,
    required this.unlocked,
    super.key,
  });

  @override
  State<LectionItem> createState() => _LectionItemState();
}

class _LectionItemState extends State<LectionItem> {
  SMIBool? _pressed;

  void _onIconInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Mobile');
    artboard.addController(controller!);
    _pressed = controller.findInput<bool>('Pressed') as SMIBool;
  }

  @override
  Widget build(BuildContext context) {
    final icon = Stack(
      alignment: Alignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 60, maxHeight: 60),
          child: Image.asset(
            "assets/images/icon_background.png",
            fit: BoxFit.contain,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 80, maxHeight: 80),
          child: RiveAnimation.asset(
            widget.iconAnimationAsset,
            fit: BoxFit.contain,
            onInit: _onIconInit,
          ),
        ),
      ],
    );
    final progressBar = AdaptiveProgressBar.icon(widget.progressPercent);

    return GestureDetector(
      onLongPress: () {
        if (_pressed?.value != null && widget.unlocked) {
          _pressed!.value = !_pressed!.value;
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 10, bottom: 10, top: 10),
                  child: widget.unlocked
                      ? icon
                      : ColorFiltered(
                          colorFilter: LectionItem.grayscaleImageFilter,
                          child: icon,
                        ),
                ),
              ),
              Flexible(
                flex: 8,
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
          widget.unlocked
              ? progressBar
              : ColorFiltered(
                  colorFilter: LectionItem.grayscaleImageFilter,
                  child: progressBar,
                ),
        ],
      ),
    );
  }
}
