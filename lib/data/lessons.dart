import '../models/lesson.dart';

List<Lesson> lessons = const [
  Lesson(
    id: "p27Fn",
    lectionId: "idvN5",
    title: "What is a Qubit?",
    content:
        "There is large media coverage on quantum computing - and on the fact, that it is superior to the (oftentimes already \"traditional\") methods of computing we practice today.",
    readTimeInMinutes: 5,
    progress: 0.8,
  ),
  Lesson(
    id: "ukoUM",
    lectionId: "idvN5",
    title: "The inner workings of quantum annealers",
    content:
        "How a quantum annealer works on the inside is a more complicated subject, but luckily, the basic concepts can be grasped without extensive knowledge of quantum physics.",
    readTimeInMinutes: 7,
    progress: 0.35,
  ),
  Lesson(
    id: "boEYU",
    lectionId: "idvN5",
    title: "Optimization problems and anneals",
    content:
        "Since there exist some problems we can't try all solutions to without waiting for decades and can't calculate the best one definitively, we give our best and try to make good approximations.",
    readTimeInMinutes: 3,
  ),
  Lesson(
    id: "8l3Nq",
    lectionId: "idvN5",
    title: "The QUBO equation",
    content:
        "For a quantum annealer to solve a task, it must be defined as a quadratic unconstrained binary optimization problem or QUBO problem for short.",
    readTimeInMinutes: 6,
  ),
  Lesson(
    id: "IdiOX",
    lectionId: "idvN5",
    title: "Some mathematics: (Hamiltonian) matrices",
    content:
        "A standardized equation allows us to concatenate the coefficients (the only values that change) in a compact format to create a representation of our problem's definition.",
    readTimeInMinutes: 4,
  ),
];
