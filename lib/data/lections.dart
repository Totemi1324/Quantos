import '../models/lection.dart';

List<Lection> lections = [
  Lection(
    id: "idvN5",
    iconAnimationAsset:
        "assets/animations/icon_introduction_to_quantum_annealers.riv",
    headerAnimationAsset:
        "assets/animations/introduction_to_quantum_annealers.riv",
    title: "Introduction to Quantum Annealers",
    description:
        "...But what are quantum computers exactly? How do they work? These questions and more are addressed in this introductory lecture!",
    difficultyLevel: Difficulty.easy,
    progressPercent: 0.4,
    unlocked: true,
  ),
  Lection(
    id: "dcVWg",
    iconAnimationAsset: "assets/animations/icon_the_n_queens_problem.riv",
    headerAnimationAsset: "assets/animations/the_n_queens_problem.riv",
    title: "The N-Queens Problem",
    description:
        "A matter of optimal chess positions — still complex for many of today's computers. But also for quantum physics?",
    difficultyLevel: Difficulty.advanced,
    unlocked: true,
  ),
  Lection(
    id: "A72NI",
    iconAnimationAsset:
        "assets/animations/icon_the_traveling_salesman_problem.riv",
    headerAnimationAsset:
        "assets/animations/the_traveling_salesman_problem.riv",
    title: "The Traveling Salesman Problem",
    description:
        "Finding the right path isn't always easy. Can you also use quantum computers as a navigation system for that? Find out in this lesson!",
    difficultyLevel: Difficulty.challenging,
    unlocked: true,
  ),
  Lection(
    id: "M70Nk",
    iconAnimationAsset: "assets/animations/icon_solving_sudoku_riddles.riv",
    headerAnimationAsset: "",
    title: "Solving Sudoku Riddles",
    description:
        "Everyone knows them: The magic number tables from Japan. Are they also able to challenge the brains of quantum anealers?",
    difficultyLevel: Difficulty.advanced,
  ),
];
