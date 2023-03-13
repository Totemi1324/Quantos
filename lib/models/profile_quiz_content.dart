import './content/content_item.dart';

class ProfileQuizContent {
  final List<List<ContentItem>> questions;
  final List<ContentItem> questionCache = [];
  int currentQuestion;

  ProfileQuizContent({required this.questions, this.currentQuestion = 0});

  factory ProfileQuizContent.empty() => ProfileQuizContent(questions: []);

  int get numberOfQuestions => questions.length;
  bool get moveNextIsSafe => currentQuestion + 1 < numberOfQuestions;
  bool get movePreviousIsSafe => currentQuestion - 1 >= 0;

  void addContentItem(ContentItem item) => questionCache.add(item);

  void finalizeQuestion() {
    questions.add(questionCache.toList());
    questionCache.clear();
  }

  void clearData() {
    questions.clear();
    questionCache.clear();
  }
}
