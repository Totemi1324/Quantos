import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import './base/flat.dart';

class TestScreen extends StatelessWidget {
  static const routeName = "/authenticate/test";

  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Flat(
      body: Center(
        child: RichText(
          
          text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall,
            children: [
              const TextSpan(text: "This "),
              TextSpan(
                text: "is",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const TextSpan(
                  text:
                      " a paragraph that is of longer nature. It could be a content paragraph, a help or news article... basically everything! "),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Math.tex(
                  r"n=n^{2}",
                  mathStyle: MathStyle.text,
                ),
              ),
              const TextSpan(text: " is always true, as it shows the very nature of human soul itself."),
            ],
          ),
        ),
      ),
    );
  }
}

/*RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall,
            children: [
              TextSpan(text: "This "),
              TextSpan(text: "is", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),),
              TextSpan(text: " a paragraph that is of longer nature. It could be a content paragraph, a help or news article... basically everything!"),
              
            ],
          ),
        ),
      )*/

/*final longEquation = Math.tex(
          r"\min C\left(q\right)=\min_{q_i=0,1}\left(\sum_{i=1}^{N}a_iq_i+\sum_{i<j}^{N}b_{ij}q_iq_j\right)=\min\left(\vec{q}^TH\vec{q}\right)",
          mathStyle: MathStyle.display,
          textStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        );
    final equationWithBreaks = Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: longEquation.texBreak().parts,
    );*/