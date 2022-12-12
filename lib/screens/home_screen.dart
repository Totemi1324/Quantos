import 'package:flutter/material.dart';

import 'base/decorated.dart';
import '../widgets/panel_card.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  final String? name = "Tamas";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Decorated(
      enableNavigationBar: true,
      body: Padding(
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
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => Container(
                      width: 100,
                      color: Colors.red,
                    ),
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (buildContext, index) => PanelCard(
                    child: Container(height: 1,),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
