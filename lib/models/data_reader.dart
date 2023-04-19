class DataReader {
  final String? data;

  const DataReader({this.data});

  String get content => data ?? "";
  bool get hasData => data != null;
}
