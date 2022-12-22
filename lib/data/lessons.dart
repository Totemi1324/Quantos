import 'package:flutter/material.dart' show Container;

import '../models/lesson.dart';

import '../models/content/paragraph.dart';
import '../models/content/section_title.dart';
import '../models/content/interactive.dart';
import '../models/content/image.dart';
import '../models/content/equation.dart';

List<Lesson> lessons = [
  Lesson(
    id: "p27Fn",
    lectionId: "idvN5",
    title: "What is a qubit?",
    content: [
      SectionTitle(
        title: "Bits - but different",
        id: "XiwGc",
      ),
      Paragraph(
        text:
            "Qubits, in contrast to classical computers, are not realized with transistors but with artificial atoms of a certain spin, which allows them to assume two states simultaneously (spin up and spin down) according to the rules of quantum physics until they are measured.",
        id: "o9bQT",
      ),
      Paragraph(
        text:
            "The quantum annealer derives its potentially enormous computing power from this state called superposition.",
        id: "gnlM5",
      ),
    ],
    readTimeInMinutes: 5,
    progress: 0.8,
  ),
  Lesson(
    id: "ukoUM",
    lectionId: "idvN5",
    title: "The inner workings of quantum annealers",
    content: [
      SectionTitle(
        title: "The insides",
        id: "i7Hg6",
      ),
      Paragraph(
        text:
            "But how does a quantum annealer work on the inside? This is a more complicated subject, which we can only treat superficially here without having advanced knowledge of quantum physics.",
        id: "Mrrjg",
      ),
      SectionTitle(
        title: "Processing power",
        id: "9s7Nb",
      ),
      Paragraph(
        text:
            "The heart of a quantum annealer is the QPU (Quantum Processing Unit3), a few square centimeters large chip, which is equipped with the before explained qubits. The current model D-Wave Advantage has exactly 5627 qubits. These are interconnected with so-called couplers, which allow the qubits to interact with each other. The number of couplers per qubit ultimately determines the computing power of the annealer.",
        id: "oAxwT",
      ),
    ],
    readTimeInMinutes: 7,
    progress: 0.35,
  ),
  Lesson(
    id: "boEYU",
    lectionId: "idvN5",
    title: "Optimization problems and anneals",
    content: [
      SectionTitle(
        title: "The embedding",
        id: "cfpjD",
      ),
      Image(
        asset: "assets/images/lessons/ucDIs.png",
        caption:
            "The graphs of the (a) Chimera architecture of the D-Wave 2000Q and the newer (b) Pegasus architecture",
        id: "ucDIs",
        altText:
            "Two QPU graphs, first of the Chimera architecture where qubits are connected to six others each, second of the Pegasus architecture with 15 couplers each.",
      ),
    ],
    readTimeInMinutes: 3,
  ),
  Lesson(
    id: "8l3Nq",
    lectionId: "idvN5",
    title: "The QUBO equation",
    content: [
      SectionTitle(
        title: "Solve the puzzle",
        id: "dwdc1",
      ),
      Interactive(
        content: Container(),
        caption: "Connect the qubits to create a valid embedding!",
        id: "j8hv2",
        altText:
            "Since every physical qubit only has the potential to connect to six others, one can depend on six by default. For more complex problems, multiple qubits have to be connected with strong equality couplers to form a logical qubit.",
      ),
    ],
    readTimeInMinutes: 6,
  ),
  Lesson(
    id: "IdiOX",
    lectionId: "idvN5",
    title: "Some mathematics: (Hamiltonian) matrices",
    content: [
      SectionTitle(
        title: "A fancy equation",
        id: "mbXwg",
      ),
      Equation(
        tex: "\\min C\\left(q\\right)=\\min_{q_i=0,1}\\left(\\sum_{i=1}^{N}a_iq_i+\\sum_{i<j}^{N}b_{ij}q_iq_j\\right)=\\min\\left(\\vec{q}^TH\\vec{q}\\right)",
        id: "tpzFo",
        altText:
            "The minimum of the function C of q is the minimum of the sum of two sum operators, the first one being a product of all q and their factor a, the second a product of all pairs of q and their factor b, which equals the minimum of vector q transposed times the matrix H times the vector q.",
      ),
    ],
    readTimeInMinutes: 4,
  ),
];
