import 'package:flutter_test/flutter_test.dart';
import 'package:quantos/bloc/lesson_content_parser.dart';

void main() {
  test("extractSpans returns correct list", () {
    const text = r"The **qubit**, a blend between 'quantum' and 'bit' and the heart of this new technology, is responsible for its enormous computing power. It scales with $$n^{2}$$.";

    final spans = LessonContentParser.extractSpans(text);

    print(spans);
  });
}