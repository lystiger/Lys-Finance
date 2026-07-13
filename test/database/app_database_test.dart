import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_finance/core/database/app_database.dart';

void main() {
  test('database initializes at the foundation schema version', () async {
    final AppDatabase database = AppDatabase(executor: NativeDatabase.memory());
    addTearDown(database.close);

    await database.initialize();

    expect(database.schemaVersion, appDatabaseSchemaVersion);
    expect(database.allTables, isEmpty);
  });
}
