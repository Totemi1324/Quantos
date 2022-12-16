import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    appName: "Loading...",
    packageName: "Loading...",
    version: "Loading...",
    buildNumber: "Loading...",
    buildSignature: "Loading...",
    installerStore: "Loading...",
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
                      "assets/images/logo.png",
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
                        title: "Version number",
                        data: _packageInfo.version,
                      ),
                      _buildDataItem(
                        context,
                        title: "Build number",
                        data: _packageInfo.buildNumber,
                      ),
                      const SectionSeparator(
                        "Imprint",
                        topMargin: 30,
                      ),
                      _buildTextParagraph(
                        context,
                        title: "Responsible party",
                        text:
                            "Tamas Nemes\nAdolf-Schmetzer-Strasse 54\n93055 Regensburg\nGERMANY",
                      ),
                      _buildTextParagraph(
                        context,
                        title: "Contact",
                        text:
                            "Email: info@quantos-learning.com\nWeb: www.quantos-learning.com",
                      ),
                      const SectionSeparator(
                        "Privacy policy",
                        topMargin: 30,
                      ),
                      _buildTextParagraph(
                        context,
                        text:
                            "Visit our website www.quantos-learning.com to learn more about our Privacy Policy.\n\nIn short: We don't collect data about you, other the ones you personally provided :)",
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
