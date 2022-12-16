import 'package:flutter/material.dart';

import '../widgets/notification_bar.dart';
import '../widgets/lection_list.dart';

class HomeScreen extends StatelessWidget {
  final String? name = "Tamas";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  "Hello${name == null ? "" : " $name"}!",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: NotificationBar(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Lections",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const LectionList(),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
