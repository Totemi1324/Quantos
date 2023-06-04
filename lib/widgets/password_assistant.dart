import 'package:flutter/material.dart';

/*
- Länge >= 8: +1 Punkt
- Länge >= 10: +1 Punkt
- Länge >= 12: +1 Punkt
- Hat Buchstabe: +1 Punkt
- Hat Zahl: +1 Punkt
- Hat Sonderzeichen: +1 Punkt
- Groß- und Kleinbuchstaben: +1 Punkt
- Hat 3+ Sonderzeichen: +1 Punkt
- Min. 1 Großschreibung, die nicht am Anfang ist: +1 Punkt
- Min. 1 Zahl, die nicht am Ende ist: +1 Punkt

SCHWACH: 0 - 5 | MITTEL: 6 - 8 | STARK: 9 - 10
*/

enum SecurityLevel {
  weak,
  medium,
  strong,
}

class PasswordAssistant extends StatefulWidget {
  final Stream<String> passwordStream;

  const PasswordAssistant(this.passwordStream, {super.key});

  @override
  State<PasswordAssistant> createState() => _PasswordAssistantState();
}

class _PasswordAssistantState extends State<PasswordAssistant> {
  static const double maximumScore = 11.0;

  static final RegExp atLeastOneLetter = RegExp(r'[A-Za-z]+');
  static final RegExp atLeastOneNumber = RegExp(r'\d+');
  static final RegExp atLeastOneSpecialChar =
      RegExp(r'[!\^"§$%&\/=?*+~#,;.:\-_@><]+');
  static final RegExp atLeastOneCapitalLetter = RegExp(r'[A-Z]+');
  static final RegExp atLeastOneSmallLetter = RegExp(r'[a-z]+');
  static final RegExp atLeastOneCapitalNotAtStart =
      RegExp(r'^.*[^A-Z]+[A-Z]+.*$');
  static final RegExp atLeastOneNumberNotAtEnd = RegExp(r'^.*\d+\D+.*$');

  int _score = 0;

  @override
  void initState() {
    widget.passwordStream.listen((currentPassword) {
      setState(() {
        _score = calculateScore(currentPassword);
      });
    });

    super.initState();
  }

  int calculateScore(String passwordPhrase) {
    int result = 0;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 10,
        child: Stack(
          children: [
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn,
              widthFactor: _score / maximumScore,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  width: 3,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
