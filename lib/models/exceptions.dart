enum ParseError {
  lectionIdDoesNotExist,
  lessonIdDoesNotExist,
  invalidJsonEntry,
  invalidJsonValue,
  incompleteJsonObject,
}

abstract class QuantosException implements Exception {
  String get exceptionId;
  String get message;

  @override
  String toString() {
    return "$exceptionId: $message";
  }
}

class ParseErrorException extends QuantosException {
  final ParseError operation;
  final String wrongContent;

  ParseErrorException(this.operation, {required this.wrongContent});

  @override
  String get exceptionId => "InvalidOutlineOperationException";

  @override
  String get message {
    switch (operation) {
      case ParseError.lectionIdDoesNotExist:
        return "Lection with ID '$wrongContent' does not exist in the app's content data.";
      case ParseError.lessonIdDoesNotExist:
        return "Lesson with ID '$wrongContent' does not exist in the app's content data.";
      case ParseError.invalidJsonEntry:
        return "JSON entry $wrongContent is invalid.";
      case ParseError.invalidJsonValue:
        return "JSON value of $wrongContent has an invalid type.";
      case ParseError.incompleteJsonObject:
        return "JSON object is missing the mandatory entry $wrongContent";
    }
  }
}
