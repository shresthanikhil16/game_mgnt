class Failure {
  final String message;
  final int? statusCode;
  Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({
    required super.message,
  });
}

class ApiFailure extends Failure {
  @override
  final int statusCode;

  ApiFailure({
    required this.statusCode,
    required super.message,
  });
}
