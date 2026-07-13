import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  test(
    'schema v4 creates foundation, transaction, and vault tables with idempotent seeds',
    () async {
      final AppDatabase database = AppDatabase(
        executor: NativeDatabase.memory(),
      );
      addTearDown(database.close);

      await database.initialize();
      expect(database.schemaVersion, 4);
      expect(database.allTables.map((table) => table.actualTableName), <String>[
        'accounts',
        'categories',
        'app_settings_entries',
        'app_metadata_entries',
        'vaults',
        'transactions',
        'vault_transfers',
        'vault_history',
      ]);
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.categories).get(), hasLength(13));
      expect(await database.select(database.vaults).get(), hasLength(8));
      expect(
        (await database.select(database.vaults).get()).every(
          (row) =>
              row.name == null &&
              row.localizationKey != null &&
              row.isSystem &&
              row.deletedAt == null,
        ),
        isTrue,
      );
      await database.initialize();
      expect(await database.select(database.vaults).get(), hasLength(8));
      expect(await database.select(database.transactions).get(), isEmpty);
    },
  );

  test(
    'rejects a transaction row that pairs the wrong type with category/vault',
    () async {
      final AppDatabase database = AppDatabase(
        executor: NativeDatabase.memory(),
      );
      addTearDown(database.close);
      await database.initialize();
      const String account = '00000000-0000-4000-8000-000000000001';
      const String category = '00000000-0000-4000-8000-000000000101';
      const String vault = '00000000-0000-4000-8000-000000000201';
      final int now = DateTime.utc(2026, 7, 13).microsecondsSinceEpoch;

      // A contribution with a category_id (instead of vault_id) must be
      // rejected by the widened check constraint.
      await expectLater(
        database
            .into(database.transactions)
            .insert(
              TransactionsCompanion.insert(
                id: 'bbbbbbbb-0000-4000-8000-000000000001',
                type: 'contribution',
                accountId: account,
                categoryId: const Value<String?>(category),
                currencyCode: 'VND',
                amountMinor: 1000,
                occurredAt: now,
                createdAt: now,
                updatedAt: now,
                version: 1,
              ),
            ),
        throwsA(anything),
      );

      // An expense with a vault_id (instead of category_id) must also be
      // rejected.
      await expectLater(
        database
            .into(database.transactions)
            .insert(
              TransactionsCompanion.insert(
                id: 'bbbbbbbb-0000-4000-8000-000000000002',
                type: 'expense',
                accountId: account,
                vaultId: const Value<String?>(vault),
                incClass: const Value<String?>('necessity'),
                currencyCode: 'VND',
                amountMinor: 1000,
                occurredAt: now,
                createdAt: now,
                updatedAt: now,
                version: 1,
              ),
            ),
        throwsA(anything),
      );

      // A well-formed contribution succeeds.
      await database
          .into(database.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: 'bbbbbbbb-0000-4000-8000-000000000003',
              type: 'contribution',
              accountId: account,
              vaultId: const Value<String?>(vault),
              currencyCode: 'VND',
              amountMinor: 1000,
              occurredAt: now,
              createdAt: now,
              updatedAt: now,
              version: 1,
            ),
          );
      expect(await database.select(database.transactions).get(), hasLength(1));
    },
  );

  test(
    'migrates a real schema-v2 file without changing existing foundation rows',
    () async {
      final Directory directory = await Directory.systemTemp.createTemp(
        'lys_migration_',
      );
      final File file = File(
        '${directory.path}${Platform.pathSeparator}app.sqlite',
      );
      addTearDown(() => directory.delete(recursive: true));
      AppDatabase database = AppDatabase(executor: NativeDatabase(file));
      await database.initialize();
      await database.close();

      final sqlite.Database v2 = sqlite.sqlite3.open(file.path);
      final List<Object?> accountBefore = v2
          .select('SELECT * FROM accounts ORDER BY id')
          .map((row) => row.values)
          .expand((values) => values)
          .toList();
      v2.execute('DROP TABLE vault_history');
      v2.execute('DROP TABLE vault_transfers');
      v2.execute('DROP TABLE transactions');
      v2.execute('DROP TABLE vaults');
      v2.execute(
        "DELETE FROM categories WHERE id >= '00000000-0000-4000-8000-000000000110'",
      );
      v2.execute(
        "UPDATE app_metadata_entries SET value = '1' WHERE key = 'seed_version'",
      );
      v2.userVersion = 2;
      v2.close();

      database = AppDatabase(executor: NativeDatabase(file));
      await database.initialize();
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.categories).get(), hasLength(13));
      expect(await database.select(database.transactions).get(), isEmpty);
      expect(await database.select(database.vaults).get(), hasLength(8));
      await database.close();

      final sqlite.Database migrated = sqlite.sqlite3.open(file.path);
      final List<Object?> accountAfter = migrated
          .select('SELECT * FROM accounts ORDER BY id')
          .map((row) => row.values)
          .expand((values) => values)
          .toList();
      expect(accountAfter, accountBefore);
      expect(migrated.userVersion, 4);
      migrated.close();

      database = AppDatabase(executor: NativeDatabase(file));
      await database.initialize();
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.categories).get(), hasLength(13));
      await database.close();
    },
  );

  test('migrates a real schema-v3 file, widening transactions and adding vault '
      'tables without losing existing transaction rows', () async {
    final Directory directory = await Directory.systemTemp.createTemp(
      'lys_migration_v3_',
    );
    final File file = File(
      '${directory.path}${Platform.pathSeparator}app.sqlite',
    );
    addTearDown(() => directory.delete(recursive: true));

    AppDatabase database = AppDatabase(executor: NativeDatabase(file));
    await database.initialize();
    final int now = DateTime.utc(2026, 7, 13).microsecondsSinceEpoch;
    await database
        .into(database.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'cccccccc-0000-4000-8000-000000000001',
            type: 'income',
            accountId: '00000000-0000-4000-8000-000000000001',
            categoryId: const Value<String?>(
              '00000000-0000-4000-8000-000000000101',
            ),
            currencyCode: 'VND',
            amountMinor: 500000,
            occurredAt: now,
            createdAt: now,
            updatedAt: now,
            version: 1,
          ),
        );
    await database.close();

    // Reshape the file into a genuine schema-v3 layout: no vault tables,
    // and a transactions table with the narrower v3 constraints (no
    // vault_id, category_id NOT NULL) — the exact shape a real Sprint 02
    // install would have on disk before this migration ever runs.
    final sqlite.Database v3 = sqlite.sqlite3.open(file.path);
    final List<Map<String, Object?>> existingRows = v3
        .select('SELECT * FROM transactions')
        .map((row) => row.map((key, value) => MapEntry(key, value)))
        .toList();
    v3.execute('DROP TABLE vault_history');
    v3.execute('DROP TABLE vault_transfers');
    v3.execute('DROP TABLE transactions');
    v3.execute('DROP TABLE vaults');
    v3.execute('''
        CREATE TABLE transactions (
          id TEXT NOT NULL PRIMARY KEY,
          type TEXT NOT NULL CHECK (type IN ('expense','income','transfer','contribution','withdrawal')),
          account_id TEXT NOT NULL REFERENCES accounts(id),
          category_id TEXT NOT NULL REFERENCES categories(id),
          inc_class TEXT,
          currency_code TEXT NOT NULL,
          amount_minor INTEGER NOT NULL CHECK (amount_minor > 0),
          note TEXT,
          occurred_at INTEGER NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          deleted_at INTEGER,
          version INTEGER NOT NULL CHECK (version >= 1)
        )
      ''');
    for (final Map<String, Object?> row in existingRows) {
      v3.execute(
        'INSERT INTO transactions (id, type, account_id, category_id, '
        'inc_class, currency_code, amount_minor, note, occurred_at, '
        'created_at, updated_at, deleted_at, version) '
        'VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)',
        <Object?>[
          row['id'],
          row['type'],
          row['account_id'],
          row['category_id'],
          row['inc_class'],
          row['currency_code'],
          row['amount_minor'],
          row['note'],
          row['occurred_at'],
          row['created_at'],
          row['updated_at'],
          row['deleted_at'],
          row['version'],
        ],
      );
    }
    v3.execute(
      "UPDATE app_metadata_entries SET value = '2' WHERE key = 'seed_version'",
    );
    v3.userVersion = 3;
    v3.close();

    database = AppDatabase(executor: NativeDatabase(file));
    await database.initialize();
    expect(database.schemaVersion, 4);
    final List<TransactionRow> transactionRows = await database
        .select(database.transactions)
        .get();
    expect(transactionRows, hasLength(1));
    expect(transactionRows.single.id, 'cccccccc-0000-4000-8000-000000000001');
    expect(
      transactionRows.single.categoryId,
      '00000000-0000-4000-8000-000000000101',
    );
    expect(transactionRows.single.vaultId, isNull);
    expect(transactionRows.single.amountMinor, 500000);
    expect(await database.select(database.vaults).get(), hasLength(8));
    await database.close();

    // Reopening is idempotent.
    database = AppDatabase(executor: NativeDatabase(file));
    await database.initialize();
    expect(await database.select(database.transactions).get(), hasLength(1));
    expect(await database.select(database.vaults).get(), hasLength(8));
    await database.close();
  });
}
