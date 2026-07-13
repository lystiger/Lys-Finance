import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  test(
    'schema v2 creates only foundation tables and idempotent seeds',
    () async {
      final AppDatabase database = AppDatabase(
        executor: NativeDatabase.memory(),
      );
      addTearDown(database.close);

      await database.initialize();
      expect(database.schemaVersion, 2);
      expect(database.allTables.map((table) => table.actualTableName), <String>[
        'accounts',
        'categories',
        'app_settings_entries',
        'app_metadata_entries',
      ]);
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.categories).get(), hasLength(9));
      expect(
        (await database.select(database.accounts).get()).every(
          (row) => row.name == null && row.localizationKey != null,
        ),
        isTrue,
      );
      await database.initialize();
      expect(await database.select(database.accounts).get(), hasLength(2));
    },
  );

  test(
    'migrates a real schema-v1 file and remains idempotent after reopen',
    () async {
      final Directory directory = await Directory.systemTemp.createTemp(
        'lys_migration_',
      );
      final File file = File(
        '${directory.path}${Platform.pathSeparator}app.sqlite',
      );
      addTearDown(() => directory.delete(recursive: true));
      final sqlite.Database v1 = sqlite.sqlite3.open(file.path);
      v1.userVersion = 1;
      v1.close();

      AppDatabase database = AppDatabase(executor: NativeDatabase(file));
      await database.initialize();
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.categories).get(), hasLength(9));
      await database.close();

      database = AppDatabase(executor: NativeDatabase(file));
      await database.initialize();
      expect(await database.select(database.accounts).get(), hasLength(2));
      expect(await database.select(database.categories).get(), hasLength(9));
      await database.close();
    },
  );
}
