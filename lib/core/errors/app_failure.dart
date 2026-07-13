sealed class AppFailure implements Exception {
  const AppFailure(this.safeMessage, {this.cause});

  final String safeMessage;
  final Object? cause;
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(super.safeMessage, {super.cause});
}

final class StorageFailure extends AppFailure {
  const StorageFailure({super.cause})
    : super('Local data could not be accessed. Please try again.');
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure({super.cause})
    : super('Something went wrong. Please try again.');
}
