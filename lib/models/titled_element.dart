import 'package:flutter/material.dart';

class TitledElement {
  final String title;
  final Widget element;

  const TitledElement({required this.title, required this.element});

  factory TitledElement.empty() => TitledElement(
        title: "",
        element: Container(),
      );
}
