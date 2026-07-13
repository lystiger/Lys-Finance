import '../../../../core/domain/app_result.dart';
import '../../../../core/money/money.dart';
import '../entities/transaction.dart';
import '../entities/transaction_filter.dart';

abstract interface class TransactionRepository {
  Future<AppResult<Transaction>> create(Transaction transaction);
  Future<AppResult<Transaction?>> getById(
    String id, {
    bool includeDeleted = false,
  });
  Stream<Transaction?> watchById(String id, {bool includeDeleted = false});
  Future<AppResult<Transaction>> update(
    Transaction transaction, {
    required int expectedVersion,
  });
  Future<AppResult<void>> softDelete(
    String id, {
    required int expectedVersion,
    required DateTime deletedAt,
  });
  Future<AppResult<void>> restore(
    String id, {
    required int expectedVersion,
    required DateTime restoredAt,
  });
  Stream<LedgerPage> watchLedger(
    TransactionFilter filter, {
    TransactionCursor? cursor,
    int limit = 50,
  });
  Future<AppResult<LedgerPage>> queryLedger(
    TransactionFilter filter, {
    TransactionCursor? cursor,
    int limit = 50,
  });
  Future<AppResult<int>> count(TransactionFilter filter);
  Future<AppResult<Money>> getAccountBalance(String accountId);
  Stream<Money> watchAccountBalance(String accountId);
}
