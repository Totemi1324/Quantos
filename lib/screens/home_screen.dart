import 'package:flutter/material.dart';

import 'base/decorated.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Decorated(
      enableNavigationBar: true,
      body: Container(),
    );
  }
}
