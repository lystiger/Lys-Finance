import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

const int appDatabaseSchemaVersion = 3;
const int foundationSeedVersion = 2;

@DataClassName('AccountRow')
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80).nullable()();
  TextColumn get normalizedName =>
      text().withLength(min: 1, max: 80).nullable()();
  TextColumn get localizationKey => text().nullable()();
  TextColumn get type => text()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get openingBalanceMinor => integer()();
  TextColumn get iconKey => text()();
  TextColumn get colorToken => text()();
  IntColumn get sortOrder =>
      integer().check(const CustomExpression<bool>('sort_order >= 0'))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();
  IntColumn get version =>
      integer().check(const CustomExpression<bool>('version >= 1'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('CategoryRow')
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80).nullable()();
  TextColumn get normalizedName =>
      text().withLength(min: 1, max: 80).nullable()();
  TextColumn get localizationKey => text().nullable()();
  TextColumn get type => text()();
  TextColumn get incClass => text().nullable()();
  TextColumn get iconKey => text()();
  TextColumn get colorToken => text()();
  IntColumn get sortOrder =>
      integer().check(const CustomExpression<bool>('sort_order >= 0'))();
  BoolColumn get isSystem => boolean()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();
  IntColumn get version =>
      integer().check(const CustomExpression<bool>('version >= 1'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('AppSettingRow')
class AppSettingsEntries extends Table {
  TextColumn get id => text()();
  TextColumn get baseCurrencyCode => text().withLength(min: 3, max: 3)();
  TextColumn get locale => text().nullable()();
  TextColumn get themeMode => text()();
  BoolColumn get reducedMotion => boolean()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get version =>
      integer().check(const CustomExpression<bool>('version >= 1'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DataClassName('AppMetadataRow')
class AppMetadataEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{key};
}

@DataClassName('TransactionRow')
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get type => text().check(
    const CustomExpression<bool>(
      "type IN ('expense','income','transfer','contribution','withdrawal')",
    ),
  )();
  TextColumn get accountId =>
      text().references(Accounts, #id, onDelete: KeyAction.restrict)();
  TextColumn get categoryId =>
      text().references(Categories, #id, onDelete: KeyAction.restrict)();
  TextColumn get incClass => text().nullable()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get amountMinor =>
      integer().check(const CustomExpression<bool>('amount_minor > 0'))();
  TextColumn get note => text().withLength(min: 0, max: 2000).nullable()();
  IntColumn get occurredAt => integer()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();
  IntColumn get version =>
      integer().check(const CustomExpression<bool>('version >= 1'))();

  @override
  List<Set<Column<Object>>> get uniqueKeys => const <Set<Column<Object>>>[];

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  @override
  List<String> get customConstraints => <String>[
    "CHECK ((type = 'expense' AND inc_class IN ('investment','necessity','consumption')) OR (type = 'income' AND inc_class IS NULL) OR type IN ('transfer','contribution','withdrawal'))",
  ];
}

@DriftDatabase(
  tables: <Type>[
    Accounts,
    Categories,
    AppSettingsEntries,
    AppMetadataEntries,
    Transactions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor})
    : super(executor ?? driftDatabase(name: 'lys_finance'));

  @override
  int get schemaVersion => appDatabaseSchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
      await _createFoundationIndexes();
      await _createTransactionIndexes();
      await _seedFoundation();
    },
    onUpgrade: _migrate,
    beforeOpen: (OpeningDetails details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await _seedFoundation();
      final List<QueryRow> violations = await customSelect(
        'PRAGMA foreign_key_check',
      ).get();
      if (violations.isNotEmpty) {
        throw StateError('Database migration left foreign-key violations.');
      }
    },
  );

  Future<void> initialize() async {
    await customSelect('SELECT 1').getSingle();
  }

  Future<void> _migrate(Migrator migrator, int from, int to) async {
    if (from > to) {
      throw StateError('Database downgrades are not supported.');
    }
    if (from < 2) {
      await migrator.createTable(accounts);
      await migrator.createTable(categories);
      await migrator.createTable(appSettingsEntries);
      await migrator.createTable(appMetadataEntries);
      await _createFoundationIndexes();
      await _seedFoundation();
    }
    if (from < 3) {
      await migrator.createTable(transactions);
      await _createTransactionIndexes();
      await _seedFoundation();
    }
  }

  Future<void> _createTransactionIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS transactions_account_ledger ON transactions(account_id, deleted_at, occurred_at DESC)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS transactions_category_ledger ON transactions(category_id, deleted_at, occurred_at DESC)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS transactions_type_ledger ON transactions(type, deleted_at, occurred_at DESC)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS transactions_inc_ledger ON transactions(inc_class, deleted_at, occurred_at DESC) WHERE inc_class IS NOT NULL',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS transactions_deleted ON transactions(deleted_at)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS transactions_order ON transactions(deleted_at, occurred_at DESC, created_at DESC, id DESC)',
    );
  }

  Future<void> _createFoundationIndexes() async {
    await customStatement(
      'CREATE UNIQUE INDEX IF NOT EXISTS accounts_active_name '
      'ON accounts(normalized_name) '
      'WHERE deleted_at IS NULL AND normalized_name IS NOT NULL',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS accounts_active_order '
      'ON accounts(deleted_at, sort_order)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS accounts_currency ON accounts(currency_code)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS accounts_localization_key '
      'ON accounts(localization_key)',
    );
    await customStatement(
      'CREATE UNIQUE INDEX IF NOT EXISTS categories_active_name '
      'ON categories(type, normalized_name) '
      'WHERE deleted_at IS NULL AND normalized_name IS NOT NULL',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS categories_active_order '
      'ON categories(type, deleted_at, sort_order)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS categories_inc_class '
      'ON categories(inc_class)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS categories_localization_key '
      'ON categories(localization_key)',
    );
  }

  Future<void> _seedFoundation() async {
    final int timestamp = DateTime.utc(2026).microsecondsSinceEpoch;
    await batch((Batch batch) {
      batch.insert(
        accounts,
        AccountsCompanion.insert(
          id: '00000000-0000-4000-8000-000000000001',
          name: const Value<String?>(null),
          normalizedName: const Value<String?>(null),
          localizationKey: const Value<String?>('account.cashWallet'),
          type: 'cash',
          currencyCode: 'VND',
          openingBalanceMinor: 0,
          iconKey: 'wallet',
          colorToken: 'category1',
          sortOrder: 0,
          createdAt: timestamp,
          updatedAt: timestamp,
          version: 1,
        ),
        mode: InsertMode.insertOrIgnore,
      );
      batch.insert(
        accounts,
        AccountsCompanion.insert(
          id: '00000000-0000-4000-8000-000000000002',
          name: const Value<String?>(null),
          normalizedName: const Value<String?>(null),
          localizationKey: const Value<String?>('account.bankAccount'),
          type: 'bank',
          currencyCode: 'VND',
          openingBalanceMinor: 0,
          iconKey: 'account_balance',
          colorToken: 'category2',
          sortOrder: 1,
          createdAt: timestamp,
          updatedAt: timestamp,
          version: 1,
        ),
        mode: InsertMode.insertOrIgnore,
      );
      for (final _CategorySeed seed in _categorySeeds) {
        batch.insert(
          categories,
          CategoriesCompanion.insert(
            id: seed.id,
            name: const Value<String?>(null),
            normalizedName: const Value<String?>(null),
            localizationKey: Value<String?>(seed.localizationKey),
            type: seed.type,
            incClass: Value<String?>(seed.incClass),
            iconKey: seed.iconKey,
            colorToken: seed.colorToken,
            sortOrder: seed.sortOrder,
            isSystem: true,
            createdAt: timestamp,
            updatedAt: timestamp,
            version: 1,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
      batch.insert(
        appSettingsEntries,
        AppSettingsEntriesCompanion.insert(
          id: 'app',
          baseCurrencyCode: 'VND',
          locale: const Value<String?>(null),
          themeMode: 'system',
          reducedMotion: false,
          createdAt: timestamp,
          updatedAt: timestamp,
          version: 1,
        ),
        mode: InsertMode.insertOrIgnore,
      );
      batch.insert(
        appMetadataEntries,
        AppMetadataEntriesCompanion.insert(
          key: 'seed_version',
          value: foundationSeedVersion.toString(),
          updatedAt: timestamp,
        ),
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}

final class _CategorySeed {
  const _CategorySeed({
    required this.id,
    required this.localizationKey,
    required this.type,
    required this.incClass,
    required this.iconKey,
    required this.colorToken,
    required this.sortOrder,
  });

  final String id;
  final String localizationKey;
  final String type;
  final String? incClass;
  final String iconKey;
  final String colorToken;
  final int sortOrder;
}

const List<_CategorySeed> _categorySeeds = <_CategorySeed>[
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000101',
    localizationKey: 'category.salary',
    type: 'income',
    incClass: null,
    iconKey: 'payments',
    colorToken: 'income',
    sortOrder: 0,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000102',
    localizationKey: 'category.food',
    type: 'expense',
    incClass: 'necessity',
    iconKey: 'restaurant',
    colorToken: 'category1',
    sortOrder: 0,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000103',
    localizationKey: 'category.transport',
    type: 'expense',
    incClass: 'necessity',
    iconKey: 'directions_bus',
    colorToken: 'category2',
    sortOrder: 1,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000104',
    localizationKey: 'category.shopping',
    type: 'expense',
    incClass: 'consumption',
    iconKey: 'shopping_bag',
    colorToken: 'category3',
    sortOrder: 2,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000105',
    localizationKey: 'category.aiSubscription',
    type: 'expense',
    incClass: 'investment',
    iconKey: 'smart_toy',
    colorToken: 'category4',
    sortOrder: 3,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000106',
    localizationKey: 'category.health',
    type: 'expense',
    incClass: 'necessity',
    iconKey: 'health_and_safety',
    colorToken: 'category5',
    sortOrder: 4,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000107',
    localizationKey: 'category.education',
    type: 'expense',
    incClass: 'investment',
    iconKey: 'school',
    colorToken: 'category6',
    sortOrder: 5,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000108',
    localizationKey: 'category.investment',
    type: 'expense',
    incClass: 'investment',
    iconKey: 'trending_up',
    colorToken: 'investment',
    sortOrder: 6,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000109',
    localizationKey: 'category.other',
    type: 'expense',
    incClass: 'consumption',
    iconKey: 'more_horiz',
    colorToken: 'category8',
    sortOrder: 7,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000110',
    localizationKey: 'category.freelance',
    type: 'income',
    incClass: null,
    iconKey: 'work',
    colorToken: 'income',
    sortOrder: 1,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000111',
    localizationKey: 'category.businessIncome',
    type: 'income',
    incClass: null,
    iconKey: 'business',
    colorToken: 'income',
    sortOrder: 2,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000112',
    localizationKey: 'category.gift',
    type: 'income',
    incClass: null,
    iconKey: 'redeem',
    colorToken: 'income',
    sortOrder: 3,
  ),
  _CategorySeed(
    id: '00000000-0000-4000-8000-000000000113',
    localizationKey: 'category.otherIncome',
    type: 'income',
    incClass: null,
    iconKey: 'more_horiz',
    colorToken: 'income',
    sortOrder: 4,
  ),
];
