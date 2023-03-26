import 'package:flutter/material.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

import '../../models/content/interactive.dart';

class NQueensDemo extends Interactive {
  static const String identifier = "uFZ_nqueens_demo";

  NQueensDemo({required super.caption, required super.altText});

  @override
  Widget get content => const Content();

  @override
  String get id => identifier;
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final Map<int, int> queenPositions = {
    0: -1,
    1: -1,
    2: -1,
    3: -1,
    4: -1,
  };

  Widget _getQueen(int index) => Draggable<int>(
        data: index,
        childWhenDragging: const SizedBox(
          height: 40,
          width: 44,
        ),
        feedback: SizedBox(
          height: 40,
          width: 44,
          child: Image.asset(
            Assets.images.interactives.queen.path,
            fit: BoxFit.contain,
          ),
        ),
        child: SizedBox(
          height: 40,
          width: 44,
          child: Image.asset(
            Assets.images.interactives.queen.path,
            fit: BoxFit.contain,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              5,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: IgnorePointer(
                  ignoring: queenPositions[index] != -1,
                  child: Opacity(
                    opacity: queenPositions[index] == -1 ? 1 : 0,
                    child: _getQueen(index),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  Assets.images.interactives.chessboard.path,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 5,
                    children: List<Widget>.generate(
                      25,
                      (index) => Padding(
                        padding: const EdgeInsets.all(6),
                        child: DragTarget<int>(
                          onWillAccept: (data) =>
                              data != null &&
                              queenPositions[data] != index &&
                              !queenPositions.values.contains(index),
                          onAccept: (data) => setState(() {
                            queenPositions[data] = index;
                          }),
                          builder: (context, _, __) => queenPositions.values
                                  .contains(index)
                              ? _getQueen(queenPositions.keys.firstWhere(
                                  (queen) => queenPositions[queen] == index))
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
