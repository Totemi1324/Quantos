import 'package:flutter/material.dart';

import '../../models/content/interactive.dart';

class EmptyInteractive extends Interactive {
  EmptyInteractive({
    required super.caption,
    required super.altText,
  });

  @override
  String get id => "000_empty";

  @override
  Widget render() => const Placeholder();
}
