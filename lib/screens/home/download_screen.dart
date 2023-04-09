import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../widgets/containers/rounded_card.dart';
import '../../widgets/category_list.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: UniversalPlatform.isWeb
                  ? Alignment.center
                  : Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                AppLocalizations.of(context)!.downloadScreenTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: RoundedCard(
                fillHeight: false,
                fillWidth: true,
                padding: const EdgeInsets.all(20),
                child: Text(
                  AppLocalizations.of(context)!.downloadScreenInstructions,
                ),
              ),
            ),
            const CategoryList(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
