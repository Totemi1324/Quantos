import 'package:flutter/material.dart';

import './content_item.dart';

class Interactive extends ContentItem {
  static const contentType = ContentType.interactive;

  final Widget content;
  final String caption;

  const Interactive({
    required this.content,
    required this.caption,
    required String altText,
  }) : super(type: contentType, altText: altText);
}
