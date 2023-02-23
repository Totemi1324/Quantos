import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen/assets.gen.dart';

import './base/flat.dart';
import '../widgets/section_separator.dart';

class InfoScreen extends StatefulWidget {
  static const routeName = "/settings/info";

  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: "...",
    packageName: "...",
    version: "...",
    buildNumber: "...",
    buildSignature: "...",
    installerStore: "...",
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _buildDataItem(
    BuildContext buildContext, {
    required String title,
    required String data,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Text(
              title,
              style: Theme.of(buildContext).textTheme.bodyMedium,
            ),
          ),
          const Flexible(
            flex: 1,
            child: SizedBox(),
          ),
          Text(
            data,
            style: Theme.of(buildContext).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildTextParagraph(
    BuildContext buildContext, {
    String? title,
    required String text,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                title,
                style: Theme.of(buildContext).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            Text(
              text,
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Flat(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: 130,
                    child: Image.asset(
                      Assets.images.logo.path,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 50),
                  child: Text(
                    "QUANTOS",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDataItem(
                        context,
                        title: AppLocalizations.of(context)!.infoScreenVersion,
                        data: _packageInfo.version,
                      ),
                      _buildDataItem(
                        context,
                        title: AppLocalizations.of(context)!.infoScreenBuild,
                        data: _packageInfo.buildNumber,
                      ),
                      SectionSeparator(
                        AppLocalizations.of(context)!.infoScreenImprintSection,
                        topMargin: 30,
                      ),
                      _buildTextParagraph(
                        context,
                        title: AppLocalizations.of(context)!
                            .infoScreenImprintResponsiblePartyTitle,
                        text:
                            "Tamas Nemes\nAdolf-Schmetzer-Strasse 54\n93055 Regensburg\nGERMANY",
                      ),
                      _buildTextParagraph(
                        context,
                        title: AppLocalizations.of(context)!
                            .infoScreenImprintContactTitle,
                        text: AppLocalizations.of(context)!
                            .infoScreenImprintContactDescription(
                                "hi@quantos.online",
                                "www.quantos.online"),
                      ),
                      SectionSeparator(
                        AppLocalizations.of(context)!.infoScreenPrivacySection,
                        topMargin: 30,
                      ),
                      _buildTextParagraph(
                        context,
                        text: AppLocalizations.of(context)!
                            .infoScreenPrivacyDescription(
                                "www.quantos.online"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
