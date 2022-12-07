import 'package:flutter/material.dart';

import '../base/flat.dart';

class AuthHomeScreen extends StatelessWidget {
  static const routeName = "/authenticate";

  const AuthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Flat(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("1"),
            Text("2"),
          ],
        ),
      ),
    );
  }
}
