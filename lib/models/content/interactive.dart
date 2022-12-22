import 'package:flutter/material.dart';

import './content_item.dart';

class Interactive extends ContentItem {
  static const contentType = ContentType.interactive;

  final Widget content;
  final String caption;

  Interactive({
    required this.content,
    required this.caption,
    required String id,
    required String altText,
  }) : super(id: id, type: contentType, altText: altText);
}