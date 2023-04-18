enum ParseError {
  lectionIdDoesNotExist,
  lessonIdDoesNotExist,
  invalidJsonEntry,
  invalidJsonValue,
  incompleteJsonObject,
}

enum AuthenticationError {
  emailExists,
  weakPassword,
  tooManyAttempts,
  userNotFound,
  wrongPassword,
  userDisabled,
  accessCodeNotFound,
  unknown,
}

enum DownloadError {
  fileDoesNotExist,
  notAuthenticated,
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
        return "Firebase API on sign up returned error code email-already-in-use.";
      case AuthenticationError.weakPassword:
        return "Firebase API on sign up returned error code weak-password.";
      case AuthenticationError.tooManyAttempts:
        return "Firebase API on sign up returned error code TOO_MANY_ATTEMPTS_TRY_LATER.";
      case AuthenticationError.userNotFound:
        return "Firebase API on sign in returned error code user-not-found.";
      case AuthenticationError.wrongPassword:
        return "Firebase API on sign in returned error code wrong-password.";
      case AuthenticationError.userDisabled:
        return "Firebase API on sign in returned error code user-disabled.";
      case AuthenticationError.accessCodeNotFound:
        return "Firebase Realtime Database does not contain the specified access code.";
      case AuthenticationError.unknown:
        return "Firebase API returned an unknown error code.";
    }
  }
}

class DownloadFailedException extends QuantosException {
  final DownloadError responseCode;

  DownloadFailedException(this.responseCode);

  @override
  String get exceptionId => "DownloadFailedException";

  @override
  String get message {
    switch (responseCode) {
      case DownloadError.fileDoesNotExist:
        return "Firebase storage bucket returned error code storage/object-not-found.";
      case DownloadError.notAuthenticated:
        return "Firebase storage bucket returned error code storage/unauthenticated.";
      case DownloadError.unknown:
        return "Firebase storage bucket returned an unknown error code.";
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
