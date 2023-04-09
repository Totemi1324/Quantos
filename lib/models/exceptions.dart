enum ParseError {
  lectionIdDoesNotExist,
  lessonIdDoesNotExist,
  invalidJsonEntry,
  invalidJsonValue,
  incompleteJsonObject,
}

enum AuthenticationError {
  emailExists,
  tooManyAttempts,
  emailNotFound,
  invalidPassword,
  userDisabled,
  accessCodeNotFound,
  unknown,
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
        return "JSON entry '$wrongContent' is invalid.";
      case ParseError.invalidJsonValue:
        return "JSON value of '$wrongContent' has an invalid type.";
      case ParseError.incompleteJsonObject:
        return "JSON object is missing the mandatory entry '$wrongContent'";
    }
  }
}

class AuthenticationException extends QuantosException {
  final AuthenticationError responseCode;

  AuthenticationException(this.responseCode);

  @override
  String get exceptionId => "AuthenticationException";

  @override
  String get message {
    switch (responseCode) {
      case AuthenticationError.emailExists:
        return "Firebase API on sign up returned error code EMAIL_EXISTS.";
      case AuthenticationError.tooManyAttempts:
        return "Firebase API on sign up returned error code TOO_MANY_ATTEMPTS_TRY_LATER.";
      case AuthenticationError.emailNotFound:
        return "Firebase API on sign in returned error code EMAIL_NOT_FOUND.";
      case AuthenticationError.invalidPassword:
        return "Firebase API on sign in returned error code INVALID_PASSWORD.";
      case AuthenticationError.userDisabled:
        return "Firebase API on sign in returned error code USER_DISABLED.";
      case AuthenticationError.accessCodeNotFound:
        return "Firebase Realtime Database does not contain the specified access code.";
      case AuthenticationError.unknown:
        return "Firebase API returned an unknown error code.";
    }
  }
}

class NoInternetException extends QuantosException {
  @override
  String get exceptionId => "NoInternetException";

  @override
  String get message =>
      "Operation failed because client device has no active internet connection.";
}

class ProcessFailedException extends QuantosException {
  final Exception innerException;

  ProcessFailedException(this.innerException);

  @override
  String get exceptionId => "ProcessFailedException";

  @override
  String get message {
    if (innerException is QuantosException) {
      return "Internal process failed with exception of type ${innerException.toString()}";
    } else {
      return "Process failed with exception of type ${innerException.toString()}";
    }
  }
}
