import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  test(
    'schema v3 creates only foundation and transaction tables with idempotent seeds',
    () async {
      final AppDatabase database = AppDatabase(
        executor: NativeDatabase.memory(),
      );
      addTearDown(database.close);

      await database.initialize();
      expect(database.schemaVersion, 3);
      expect(database.allTables.map((table) => table.actualTableName), <String>[
        'accounts',
        'categories',
        'app_settings_entries',
        'app_metadata_entries',
        'transactions',
      ]);
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.categories).get(), hasLength(13));
      expect(
        (await database.select(database.accounts).get()).every(
          (row) => row.name == null && row.localizationKey != null,
        ),
        isTrue,
      );
      await database.initialize();
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.transactions).get(), isEmpty);
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
      v2.execute('DROP TABLE transactions');
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
      await database.close();

      final sqlite.Database migrated = sqlite.sqlite3.open(file.path);
      final List<Object?> accountAfter = migrated
          .select('SELECT * FROM accounts ORDER BY id')
          .map((row) => row.values)
          .expand((values) => values)
          .toList();
      expect(accountAfter, accountBefore);
      expect(migrated.userVersion, 3);
      migrated.close();

      database = AppDatabase(executor: NativeDatabase(file));
      await database.initialize();
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.categories).get(), hasLength(13));
      await database.close();
    },
  );
}
