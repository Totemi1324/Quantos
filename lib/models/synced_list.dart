// Code from: Flutter Docs
// https://api.flutter.dev/flutter/widgets/AnimatedList-class.html

import 'package:flutter/material.dart';

typedef RemovedItemBuilder<T1> = Widget Function(
    T1 item, BuildContext context, Animation<double> animation);

class SyncedList<T2> {
  SyncedList({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<T2>? initialItems,
  }) : _items = List<T2>.from(initialItems ?? <T2>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<T2> removedItemBuilder;
  final List<T2> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, T2 item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  T2 removeAt(int index) {
    final T2 removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  bool get isEmpty => _items.isEmpty;

  T2 operator [](int index) => _items[index];

  int indexOf(T2 item) => _items.indexOf(item);
}
