import '../models/download.dart';

List<Download> downloads = const [
  Download(
    "TSP Benchmarking Results",
    description:
        "All relevant experimental and benchmarking data, concatenated into a single document.",
    categoryId: "VpJ",
    size: DownloadSize(size: 2.5, unit: DownloadSizeUnit.megabyte),
    type: FileType.pdf,
    links: {
      "EN": "https://tsp-quantum.netlify.app/docs/Resultsbook.pdf",
      "DE": "https://tsp-quantum.netlify.app/docs/Resultsbook.pdf",
    },
    availableOn: {Platform.mobile, Platform.desktop},
  ),
  Download(
    "Standard Problems and Their QUBO Form",
    description:
        "The QUBO bible — contains every single known problem and its QUBO implementation.",
    categoryId: "VpJ",
    size: DownloadSize(size: 3.4, unit: DownloadSizeUnit.megabyte),
    type: FileType.pdf,
    links: {
      "EN": "",
    },
    availableOn: {Platform.mobile, Platform.desktop},
  ),
  Download(
    "Experimental Results",
    description:
        "This file contains the raw data of the measurements made to evaluate the performance of this course's algorithms.",
    categoryId: "U7s",
    size: DownloadSize(size: 44.3, unit: DownloadSizeUnit.kilobyte),
    type: FileType.json,
    links: {
      "EN": "https://tsp-quantum.netlify.app/docs/data.json",
    },
    availableOn: {Platform.mobile, Platform.desktop},
  ),
  Download(
    "Tutorial notebook for TSPs",
    description:
        "An interactive Python notebook for those who are interested in the code for TSPs and the DWave API.",
    categoryId: "ft1",
    size: DownloadSize(size: 1.2, unit: DownloadSizeUnit.megabyte),
    type: FileType.ipynb,
    links: {
      "EN": "https://tsp-quantum.netlify.app/docs/Solving%20the%20Traveling%20Salesman%20Problem%20with%20quantum%20annealers.ipynb",
    },
    availableOn: {Platform.desktop},
  ),
  Download(
    "Graph to Matrix",
        description:
        "Visually design graphs on a canvas and export their Hamiltonian with one click as an input for the quantum annealers.",
    categoryId: "2fT",
    size: DownloadSize(size: 8.7, unit: DownloadSizeUnit.megabyte),
    type: FileType.exe,
    links: {
      "EN": "https://tsp-quantum.netlify.app/docs/Graph%20to%20Matrix%20-%20TSPQ.exe",
    },
    availableOn: {Platform.mobile, Platform.desktop},
  ),
];
