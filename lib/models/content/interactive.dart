import 'package:flutter/material.dart';

import './content_item.dart';

abstract class Interactive extends ContentItem {
  static const contentType = ContentType.interactive;

  final String caption;
  final Map<String, dynamic>? args;

  const Interactive({
    required this.caption,
    required String altText,
    this.args,
  }) : super(type: contentType, altText: altText);

  String get id;
  Widget get content;
}
