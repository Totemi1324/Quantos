import '../models/download.dart';

List<Download> downloads = const [
  Download(
    "TSP Benchmarking Results",
    categoryId: "VpJsk",
    description:
        "All relevant experimental and benchmarking data, concatenated into a single document.",
    size: DownloadSize(size: 2.5, unit: DownloadSizeUnit.megabyte),
    type: FileType.pdf,
    link: "https://tsp-quantum.netlify.app/docs/Resultsbook.pdf",
  ),
  Download(
    "Standard Problems and Their QUBO Form",
    categoryId: "VpJsk",
    description:
        "The QUBO bible — contains every single known problem and its QUBO implementation.",
    size: DownloadSize(size: 3.4, unit: DownloadSizeUnit.megabyte),
    type: FileType.pdf,
    link: "",
  ),
  Download(
    "Experimental Results",
    categoryId: "U7s8F",
    description:
        "This file contains the raw data of the measurements made to evaluate the performance of this course's algorithms.",
    size: DownloadSize(size: 44.3, unit: DownloadSizeUnit.kilobyte),
    type: FileType.json,
    link: "https://tsp-quantum.netlify.app/docs/data.json",
  ),
  Download(
    "Tutorial notebook for TSPs",
    categoryId: "ft1Tj",
    description:
        "An interactive Python notebook for those who are interested in the code for TSPs and the DWave API.",
    size: DownloadSize(size: 1.2, unit: DownloadSizeUnit.megabyte),
    type: FileType.ipynb,
    link:
        "https://tsp-quantum.netlify.app/docs/Solving%20the%20Traveling%20Salesman%20Problem%20with%20quantum%20annealers.ipynb",
  ),
  Download(
    "Graph to Matrix",
    categoryId: "2fT4z",
    description:
        "Visually design graphs on a canvas and export their Hamiltonian with one click as an input for the quantum annealers.",
    size: DownloadSize(size: 8.7, unit: DownloadSizeUnit.megabyte),
    type: FileType.exe,
    link:
        "https://tsp-quantum.netlify.app/docs/Graph%20to%20Matrix%20-%20TSPQ.exe",
  ),
];
