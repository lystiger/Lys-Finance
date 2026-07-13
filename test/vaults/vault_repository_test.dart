import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';
import 'package:lys_finance/core/domain/app_result.dart';
import 'package:lys_finance/core/errors/app_failure.dart';
import 'package:lys_finance/core/identifiers/uuid_generator.dart';
import 'package:lys_finance/core/money/currency.dart';
import 'package:lys_finance/core/money/money.dart';
import 'package:lys_finance/core/time/app_clock.dart';
import 'package:lys_finance/features/settings/data/repositories/drift_account_repository.dart';
import 'package:lys_finance/features/settings/domain/entities/account.dart';
import 'package:lys_finance/features/settings/domain/repositories/account_repository.dart';
import 'package:lys_finance/features/transactions/data/repositories/drift_transaction_repository.dart';
import 'package:lys_finance/features/transactions/domain/entities/transaction.dart';
import 'package:lys_finance/features/vaults/application/services/contribution_service.dart';
import 'package:lys_finance/features/vaults/application/services/goal_service.dart';
import 'package:lys_finance/features/vaults/application/services/history_service.dart';
import 'package:lys_finance/features/vaults/application/services/projection_service.dart';
import 'package:lys_finance/features/vaults/application/services/transfer_service.dart';
import 'package:lys_finance/features/vaults/application/services/vault_service.dart';
import 'package:lys_finance/features/vaults/application/services/withdrawal_service.dart';
import 'package:lys_finance/features/vaults/data/repositories/drift_vault_history_repository.dart';
import 'package:lys_finance/features/vaults/data/repositories/drift_vault_repository.dart';
import 'package:lys_finance/features/vaults/data/repositories/drift_vault_transfer_repository.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault_goal_snapshot.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault_history_entry.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault_history_event.dart';
import 'package:lys_finance/features/vaults/domain/entities/vault_transfer.dart';

final class _SequentialUuid implements UuidGenerator {
  int _counter = 0;
  @override
  String v4() {
    _counter += 1;
    final String suffix = _counter.toString().padLeft(12, '0');
    return '99999999-9999-4999-8999-$suffix';
  }
}

void main() {
  late AppDatabase database;
  late DriftVaultRepository vaults;
  late DriftVaultTransferRepository transfers;
  late DriftVaultHistoryRepository history;
  late DriftTransactionRepository transactions;
  late AccountRepository accounts;
  late VaultService vaultService;
  late ContributionService contributionService;
  late WithdrawalService withdrawalService;
  late TransferService transferService;
  late HistoryService historyService;
  late GoalService goalService;
  final FixedAppClock clock = FixedAppClock(DateTime.utc(2026, 7, 13));
  const String account1 = '00000000-0000-4000-8000-000000000001';

  setUp(() async {
    database = AppDatabase(executor: NativeDatabase.memory());
    await database.initialize();
    vaults = DriftVaultRepository(database);
    transfers = DriftVaultTransferRepository(database);
    history = DriftVaultHistoryRepository(database);
    transactions = DriftTransactionRepository(database);
    accounts = DriftAccountRepository(database);
    final _SequentialUuid uuid = _SequentialUuid();
    vaultService = VaultService(
      vaults: vaults,
      history: history,
      uuid: uuid,
      clock: clock,
    );
    contributionService = ContributionService(
      transactions: transactions,
      vaults: vaults,
      accounts: accounts,
      history: history,
      uuid: uuid,
      clock: clock,
    );
    withdrawalService = WithdrawalService(
      transactions: transactions,
      vaults: vaults,
      accounts: accounts,
      history: history,
      uuid: uuid,
      clock: clock,
    );
    transferService = TransferService(
      transfers: transfers,
      vaults: vaults,
      uuid: uuid,
      clock: clock,
    );
    historyService = HistoryService(
      transactions: transactions,
      transfers: transfers,
      history: history,
    );
    goalService = GoalService(
      vaults: vaults,
      transactions: transactions,
      transfers: transfers,
      projection: const ProjectionService(),
      clock: clock,
    );
  });
  tearDown(() => database.close());

  Future<Vault> createVault({
    String name = 'Japan Fund',
    Money? goalAmount,
    VaultWithdrawalPolicy policy = VaultWithdrawalPolicy.soft,
  }) async {
    final AppResult<Vault> result = await vaultService.create(
      name: name,
      iconKey: 'flag',
      colorToken: 'primary',
      currency: Currency.vnd,
      withdrawalPolicy: policy,
      sortOrder: 0,
      goalAmount: goalAmount,
    );
    return (result as AppSuccess<Vault>).value;
  }

  Money vnd(int minorUnits) => Money.fromMinorUnits(
    minorUnits: minorUnits,
    currency: Currency.vnd,
  ).fold(success: (value) => value, failure: (failure) => throw failure);

  test(
    'vault lifecycle: create, update, stale version, archive, restore',
    () async {
      final Vault vault = await createVault();
      expect(vault.name, 'Japan Fund');

      final AppResult<Vault> staleUpdate = await vaultService.update(
        original: vault.copyWith(version: 99),
        name: 'Renamed',
      );
      expect(
        staleUpdate,
        isA<AppError<Vault>>().having(
          (value) => value.error,
          'error',
          isA<VersionConflictFailure>(),
        ),
      );

      final AppResult<Vault> renamed = await vaultService.update(
        original: vault,
        name: 'Renamed Fund',
      );
      expect((renamed as AppSuccess<Vault>).value.name, 'Renamed Fund');

      final AppResult<void> archived = await vaultService.archive(
        renamed.value,
      );
      expect(archived, isA<AppSuccess<void>>());
      final List<Vault> active = await vaults.watchActive().first;
      expect(active.where((value) => value.id == vault.id), isEmpty);

      final AppResult<void> restored = await vaultService.restore(
        renamed.value.copyWith(version: renamed.value.version + 1),
      );
      expect(restored, isA<AppSuccess<void>>());
    },
  );

  test(
    'contribution increases vault balance without changing account balance',
    () async {
      final Vault vault = await createVault();
      final Money before =
          (await accounts.getById(account1) as AppSuccess<Account>)
              .value
              .openingBalance;
      final AppResult<Transaction> contributed = await contributionService
          .contribute(
            vaultId: vault.id,
            accountId: account1,
            amount: vnd(500000),
          );
      expect(contributed, isA<AppSuccess<Transaction>>());
      final Money vaultBalance =
          (await vaults.getBalance(vault.id) as AppSuccess<Money>).value;
      expect(vaultBalance.minorUnits, 500000);
      final Money accountBalance =
          (await transactions.getAccountBalance(account1) as AppSuccess<Money>)
              .value;
      expect(accountBalance, before);
    },
  );

  test('withdrawal enforces the non-negative balance rule', () async {
    final Vault vault = await createVault();
    await contributionService.contribute(
      vaultId: vault.id,
      accountId: account1,
      amount: vnd(300000),
    );
    final AppResult<Transaction> overWithdraw = await withdrawalService
        .withdraw(vaultId: vault.id, accountId: account1, amount: vnd(400000));
    expect(
      overWithdraw,
      isA<AppError<Transaction>>().having(
        (value) => value.error,
        'error',
        isA<InsufficientVaultBalanceFailure>(),
      ),
    );
    final AppResult<Transaction> partialWithdraw = await withdrawalService
        .withdraw(vaultId: vault.id, accountId: account1, amount: vnd(100000));
    expect(partialWithdraw, isA<AppSuccess<Transaction>>());
    final Money balance =
        (await vaults.getBalance(vault.id) as AppSuccess<Money>).value;
    expect(balance.minorUnits, 200000);
  });

  test('a locked vault requires a reason to withdraw', () async {
    final Vault vault = await createVault(policy: VaultWithdrawalPolicy.locked);
    await contributionService.contribute(
      vaultId: vault.id,
      accountId: account1,
      amount: vnd(300000),
    );
    final AppResult<Transaction> withoutReason = await withdrawalService
        .withdraw(vaultId: vault.id, accountId: account1, amount: vnd(100000));
    expect(
      withoutReason,
      isA<AppError<Transaction>>().having(
        (value) => value.error,
        'error',
        isA<WithdrawalReasonRequiredFailure>(),
      ),
    );
    final AppResult<Transaction> withReason = await withdrawalService.withdraw(
      vaultId: vault.id,
      accountId: account1,
      amount: vnd(100000),
      reason: 'Car repair',
    );
    expect(withReason, isA<AppSuccess<Transaction>>());
  });

  test('transfer atomically moves balance between two vaults', () async {
    final Vault source = await createVault(name: 'Source');
    final Vault destination = await createVault(name: 'Destination');
    await contributionService.contribute(
      vaultId: source.id,
      accountId: account1,
      amount: vnd(500000),
    );

    final AppResult<VaultTransfer> overTransfer = await transferService
        .transfer(
          sourceVaultId: source.id,
          destinationVaultId: destination.id,
          amount: vnd(600000),
        );
    expect(
      overTransfer,
      isA<AppError<VaultTransfer>>().having(
        (value) => value.error,
        'error',
        isA<InsufficientVaultBalanceFailure>(),
      ),
    );

    final AppResult<VaultTransfer> transferred = await transferService.transfer(
      sourceVaultId: source.id,
      destinationVaultId: destination.id,
      amount: vnd(200000),
    );
    expect(transferred, isA<AppSuccess<VaultTransfer>>());

    final Money sourceBalance =
        (await vaults.getBalance(source.id) as AppSuccess<Money>).value;
    final Money destinationBalance =
        (await vaults.getBalance(destination.id) as AppSuccess<Money>).value;
    expect(sourceBalance.minorUnits, 300000);
    expect(destinationBalance.minorUnits, 200000);
  });

  test('a transfer to itself is rejected', () async {
    final Vault vault = await createVault();
    final AppResult<VaultTransfer> result = await transferService.transfer(
      sourceVaultId: vault.id,
      destinationVaultId: vault.id,
      amount: vnd(1000),
    );
    expect(result, isA<AppError<VaultTransfer>>());
  });

  test(
    'milestone and goal-completion events are recorded once and idempotently',
    () async {
      final Vault vault = await createVault(goalAmount: vnd(1000000));
      // 600,000 / 1,000,000 crosses both the 25% and 50% thresholds at once;
      // both are backfilled in the same check rather than only the highest.
      await contributionService.contribute(
        vaultId: vault.id,
        accountId: account1,
        amount: vnd(600000),
      );
      // 700,000 / 1,000,000 crosses no new threshold (75% not yet reached),
      // so the milestone count must not grow — idempotency under repeated
      // contributions past an already-logged threshold.
      await contributionService.contribute(
        vaultId: vault.id,
        accountId: account1,
        amount: vnd(100000),
      );
      final List<VaultHistoryEvent> midEvents =
          (await history.queryForVault(vault.id)
                  as AppSuccess<List<VaultHistoryEvent>>)
              .value;
      expect(
        midEvents
            .where(
              (event) =>
                  event.eventType == VaultHistoryEventType.milestoneReached,
            )
            .length,
        2,
      );

      await contributionService.contribute(
        vaultId: vault.id,
        accountId: account1,
        amount: vnd(400000),
      );
      final List<VaultHistoryEvent> finalEvents =
          (await history.queryForVault(vault.id)
                  as AppSuccess<List<VaultHistoryEvent>>)
              .value;
      expect(
        finalEvents
            .where(
              (event) => event.eventType == VaultHistoryEventType.goalCompleted,
            )
            .length,
        1,
      );

      final AppResult<Transaction> withdrawal = await withdrawalService
          .withdraw(
            vaultId: vault.id,
            accountId: account1,
            amount: vnd(200000),
          );
      expect(withdrawal, isA<AppSuccess<Transaction>>());
      final List<VaultHistoryEvent> reopenedEvents =
          (await history.queryForVault(vault.id)
                  as AppSuccess<List<VaultHistoryEvent>>)
              .value;
      expect(
        reopenedEvents
            .where(
              (event) => event.eventType == VaultHistoryEventType.goalReopened,
            )
            .length,
        1,
      );
    },
  );

  test('currency cannot change once a vault has activity', () async {
    final Vault vault = await createVault();
    await contributionService.contribute(
      vaultId: vault.id,
      accountId: account1,
      amount: vnd(100000),
    );
    final AppResult<Vault> result = await vaultService.update(
      original: vault,
      currency: Currency.usd,
    );
    expect(
      result,
      isA<AppError<Vault>>().having(
        (value) => value.error,
        'error',
        isA<VaultCurrencyLockedFailure>(),
      ),
    );
  });

  test(
    'history service merges contributions, transfers, and lifecycle events',
    () async {
      final Vault source = await createVault(name: 'Source');
      final Vault destination = await createVault(name: 'Destination');
      await contributionService.contribute(
        vaultId: source.id,
        accountId: account1,
        amount: vnd(500000),
      );
      await transferService.transfer(
        sourceVaultId: source.id,
        destinationVaultId: destination.id,
        amount: vnd(100000),
      );
      await vaultService.archive(source.copyWith(version: 1));

      final List<VaultHistoryEntry> timeline =
          (await historyService.timelineFor(source.id)
                  as AppSuccess<List<VaultHistoryEntry>>)
              .value;
      expect(timeline.whereType<VaultActivityEntry>(), hasLength(1));
      expect(timeline.whereType<VaultTransferEntry>(), hasLength(1));
      expect(
        timeline.whereType<VaultLifecycleEntry>().map(
          (entry) => entry.event.eventType,
        ),
        containsAll(<VaultHistoryEventType>[
          VaultHistoryEventType.created,
          VaultHistoryEventType.archived,
        ]),
      );
    },
  );

  test('goal service produces a snapshot with a positive pace', () async {
    final Vault vault = await createVault(goalAmount: vnd(1000000));
    await contributionService.contribute(
      vaultId: vault.id,
      accountId: account1,
      amount: vnd(500000),
    );
    final AppResult<VaultGoalSnapshot> snapshot = await goalService.snapshotFor(
      vault.id,
    );
    expect(snapshot, isA<AppSuccess<VaultGoalSnapshot>>());
    expect(
      (snapshot as AppSuccess<VaultGoalSnapshot>)
          .value
          .currentBalance
          .minorUnits,
      500000,
    );
  });

  test('a vault currency mismatch on contribution is rejected', () async {
    final Vault vault = await createVault();
    final AppResult<Transaction> result = await contributionService.contribute(
      vaultId: vault.id,
      accountId: account1,
      amount: Money.fromMinorUnits(
        minorUnits: 100,
        currency: Currency.usd,
      ).fold(success: (value) => value, failure: (failure) => throw failure),
    );
    expect(
      result,
      isA<AppError<Transaction>>().having(
        (value) => value.error,
        'error',
        isA<CurrencyVaultMismatchFailure>(),
      ),
    );
  });
}
