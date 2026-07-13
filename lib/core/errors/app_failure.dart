sealed class AppFailure implements Exception {
  const AppFailure(this.safeMessage, {required this.code, this.cause});

  final String safeMessage;
  final String code;
  final Object? cause;
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure(
    super.safeMessage, {
    required super.code,
    super.cause,
  });
}

final class DomainFailure extends AppFailure {
  const DomainFailure(super.safeMessage, {required super.code, super.cause});
}

final class RepositoryFailure extends AppFailure {
  const RepositoryFailure(
    super.safeMessage, {
    required super.code,
    super.cause,
  });
}

final class DuplicateFailure extends RepositoryFailure {
  const DuplicateFailure()
    : super('That name is already in use.', code: 'duplicate');
}

final class VersionConflictFailure extends RepositoryFailure {
  const VersionConflictFailure()
    : super(
        'This item changed elsewhere. Reload and try again.',
        code: 'version_conflict',
      );
}

final class NotFoundFailure extends RepositoryFailure {
  const NotFoundFailure()
    : super('The requested item no longer exists.', code: 'not_found');
}

final class StorageFailure extends AppFailure {
  const StorageFailure({super.cause})
    : super(
        'Local data could not be accessed. Please try again.',
        code: 'storage_unavailable',
      );
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure({super.cause})
    : super('Something went wrong. Please try again.', code: 'unexpected');
}

final class InvalidAmountFailure extends ValidationFailure {
  const InvalidAmountFailure()
    : super('Enter an amount greater than zero.', code: 'invalid_amount');
}

final class MissingAccountFailure extends RepositoryFailure {
  const MissingAccountFailure()
    : super('Choose an account to continue.', code: 'missing_account');
}

final class ArchivedAccountFailure extends RepositoryFailure {
  const ArchivedAccountFailure()
    : super(
        'This account is archived. Choose another.',
        code: 'archived_account',
      );
}

final class MissingCategoryFailure extends RepositoryFailure {
  const MissingCategoryFailure()
    : super('Choose a category to continue.', code: 'missing_category');
}

final class CategoryKindMismatchFailure extends RepositoryFailure {
  const CategoryKindMismatchFailure()
    : super(
        'That category does not match this transaction type.',
        code: 'category_kind_mismatch',
      );
}

final class CurrencyAccountMismatchFailure extends RepositoryFailure {
  const CurrencyAccountMismatchFailure()
    : super(
        'This account uses a different currency.',
        code: 'currency_account_mismatch',
      );
}
