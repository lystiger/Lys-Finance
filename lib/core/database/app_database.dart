import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

const int appDatabaseSchemaVersion = 4;
const int foundationSeedVersion = 3;

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

@DataClassName('VaultRow')
class Vaults extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80).nullable()();
  TextColumn get localizationKey => text().nullable()();
  TextColumn get description =>
      text().withLength(min: 0, max: 500).nullable()();
  TextColumn get iconKey => text()();
  TextColumn get colorToken => text()();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get goalAmountMinor => integer().nullable().check(
    const CustomExpression<bool>(
      'goal_amount_minor IS NULL OR goal_amount_minor > 0',
    ),
  )();
  IntColumn get targetDate => integer().nullable()();
  IntColumn get priority => integer()
      .withDefault(const Constant<int>(0))
      .check(const CustomExpression<bool>('priority >= 0'))();
  IntColumn get sortOrder =>
      integer().check(const CustomExpression<bool>('sort_order >= 0'))();
  TextColumn get withdrawalPolicy => text().check(
    const CustomExpression<bool>(
      "withdrawal_policy IN ('locked','soft','deadlineLinked')",
    ),
  )();
  BoolColumn get isSystem =>
      boolean().withDefault(const Constant<bool>(false))();
  BoolColumn get autoContributionEnabled =>
      boolean().withDefault(const Constant<bool>(false))();
  TextColumn get autoContributionKind => text().nullable().check(
    const CustomExpression<bool>(
      "auto_contribution_kind IS NULL OR auto_contribution_kind IN ('fixed','percentOfIncome')",
    ),
  )();
  IntColumn get autoContributionValue => integer().nullable().check(
    const CustomExpression<bool>(
      'auto_contribution_value IS NULL OR auto_contribution_value > 0',
    ),
  )();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();
  IntColumn get version =>
      integer().check(const CustomExpression<bool>('version >= 1'))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  @override
  List<String> get customConstraints => <String>[
    'CHECK ((auto_contribution_enabled = 0) OR '
        '(auto_contribution_kind IS NOT NULL AND auto_contribution_value IS NOT NULL))',
  ];
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
  TextColumn get categoryId => text().nullable().references(
    Categories,
    #id,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get vaultId =>
      text().nullable().references(Vaults, #id, onDelete: KeyAction.restrict)();
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
    "CHECK ((type IN ('expense','income') AND category_id IS NOT NULL AND vault_id IS NULL) OR "
        "(type IN ('contribution','withdrawal') AND vault_id IS NOT NULL AND category_id IS NULL) OR "
        "(type = 'transfer' AND category_id IS NULL AND vault_id IS NULL))",
  ];
}

@DataClassName('VaultTransferRow')
class VaultTransfers extends Table {
  TextColumn get id => text()();
  @ReferenceName('outgoingTransfers')
  TextColumn get sourceVaultId =>
      text().references(Vaults, #id, onDelete: KeyAction.restrict)();
  @ReferenceName('incomingTransfers')
  TextColumn get destinationVaultId =>
      text().references(Vaults, #id, onDelete: KeyAction.restrict)();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();
  IntColumn get amountMinor =>
      integer().check(const CustomExpression<bool>('amount_minor > 0'))();
  TextColumn get note => text().withLength(min: 0, max: 500).nullable()();
  IntColumn get occurredAt => integer()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  @override
  List<String> get customConstraints => <String>[
    'CHECK (source_vault_id <> destination_vault_id)',
  ];
}

@DataClassName('VaultHistoryRow')
class VaultHistory extends Table {
  TextColumn get id => text()();
  TextColumn get vaultId =>
      text().references(Vaults, #id, onDelete: KeyAction.restrict)();
  TextColumn get eventType => text().check(
    const CustomExpression<bool>(
      "event_type IN ('created','edited','archived','restored',"
      "'milestoneReached','goalCompleted','goalReopened')",
    ),
  )();
  TextColumn get payload => text().withLength(min: 0, max: 500).nullable()();
  IntColumn get occurredAt => integer()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

@DriftDatabase(
  tables: <Type>[
    Accounts,
    Categories,
    AppSettingsEntries,
    AppMetadataEntries,
    Vaults,
    Transactions,
    VaultTransfers,
    VaultHistory,
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
      await _createVaultIndexes();
      await _seedFoundation();
      await _seedVaults();
    },
    onUpgrade: _migrate,
    beforeOpen: (OpeningDetails details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await _seedFoundation();
      await _seedVaults();
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
    if (from < 4) {
      if (from >= 3) {
        // The transactions table already exists from a prior session with the
        // narrower schema (category_id NOT NULL, no vault_id). SQLite cannot
        // alter a column's nullability in place, so the table is recreated
        // under the current (widened) Dart definition and existing rows are
        // copied across unchanged, with vault_id defaulting to NULL.
        await customStatement(
          'ALTER TABLE transactions RENAME TO transactions_v3',
        );
        await migrator.createTable(transactions);
        await customStatement(
          'INSERT INTO transactions (id, type, account_id, category_id, '
          'vault_id, inc_class, currency_code, amount_minor, note, '
          'occurred_at, created_at, updated_at, deleted_at, version) '
          'SELECT id, type, account_id, category_id, NULL, inc_class, '
          'currency_code, amount_minor, note, occurred_at, created_at, '
          'updated_at, deleted_at, version FROM transactions_v3',
        );
        await customStatement('DROP TABLE transactions_v3');
        await _createTransactionIndexes();
      }
      await migrator.createTable(vaults);
      await migrator.createTable(vaultTransfers);
      await migrator.createTable(vaultHistory);
      await _createVaultIndexes();
      await _seedVaults();
    }
  }

  Future<void> _createVaultIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS vaults_active_order ON vaults(deleted_at, sort_order)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS vaults_active_priority ON vaults(deleted_at, priority)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS transactions_vault_ledger ON transactions(vault_id, deleted_at, occurred_at DESC)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS vault_transfers_source ON vault_transfers(source_vault_id, occurred_at DESC)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS vault_transfers_destination ON vault_transfers(destination_vault_id, occurred_at DESC)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS vault_history_vault ON vault_history(vault_id, occurred_at DESC)',
    );
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

  Future<void> _seedVaults() async {
    final int timestamp = DateTime.utc(2026).microsecondsSinceEpoch;
    await batch((Batch batch) {
      for (final _VaultSeed seed in _vaultSeeds) {
        batch.insert(
          vaults,
          VaultsCompanion.insert(
            id: seed.id,
            name: const Value<String?>(null),
            localizationKey: Value<String?>(seed.localizationKey),
            iconKey: seed.iconKey,
            colorToken: seed.colorToken,
            currencyCode: 'VND',
            priority: Value<int>(seed.priority),
            sortOrder: seed.sortOrder,
            withdrawalPolicy: seed.withdrawalPolicy,
            isSystem: const Value<bool>(true),
            createdAt: timestamp,
            updatedAt: timestamp,
            version: 1,
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
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

final class _VaultSeed {
  const _VaultSeed({
    required this.id,
    required this.localizationKey,
    required this.iconKey,
    required this.colorToken,
    required this.withdrawalPolicy,
    required this.priority,
    required this.sortOrder,
  });

  final String id;
  final String localizationKey;
  final String iconKey;
  final String colorToken;
  final String withdrawalPolicy;
  final int priority;
  final int sortOrder;
}

const List<_VaultSeed> _vaultSeeds = <_VaultSeed>[
  _VaultSeed(
    id: '00000000-0000-4000-8000-000000000201',
    localizationKey: 'vault.emergencyFund',
    iconKey: 'shield',
    colorToken: 'necessity',
    withdrawalPolicy: 'locked',
    priority: 7,
    sortOrder: 0,
  ),
  _VaultSeed(
    id: '00000000-0000-4000-8000-000000000202',
    localizationKey: 'vault.japanMasters',
    iconKey: 'school',
    colorToken: 'investment',
    withdrawalPolicy: 'soft',
    priority: 6,
    sortOrder: 1,
  ),
  _VaultSeed(
    id: '00000000-0000-4000-8000-000000000203',
    localizationKey: 'vault.aiInfrastructure',
    iconKey: 'dns',
    colorToken: 'investment',
    withdrawalPolicy: 'soft',
    priority: 5,
    sortOrder: 2,
  ),
  _VaultSeed(
    id: '00000000-0000-4000-8000-000000000204',
    localizationKey: 'vault.elysia',
    iconKey: 'auto_awesome',
    colorToken: 'investment',
    withdrawalPolicy: 'soft',
    priority: 4,
    sortOrder: 3,
  ),
  _VaultSeed(
    id: '00000000-0000-4000-8000-000000000205',
    localizationKey: 'vault.gpuUpgrade',
    iconKey: 'memory',
    colorToken: 'investment',
    withdrawalPolicy: 'soft',
    priority: 3,
    sortOrder: 4,
  ),
  _VaultSeed(
    id: '00000000-0000-4000-8000-000000000206',
    localizationKey: 'vault.investment',
    iconKey: 'trending_up',
    colorToken: 'investment',
    withdrawalPolicy: 'soft',
    priority: 2,
    sortOrder: 5,
  ),
  _VaultSeed(
    id: '00000000-0000-4000-8000-000000000207',
    localizationKey: 'vault.freedomFund',
    iconKey: 'flight_takeoff',
    colorToken: 'primary',
    withdrawalPolicy: 'deadlineLinked',
    priority: 1,
    sortOrder: 6,
  ),
  _VaultSeed(
    id: '00000000-0000-4000-8000-000000000208',
    localizationKey: 'vault.vacation',
    iconKey: 'beach_access',
    colorToken: 'consumption',
    withdrawalPolicy: 'soft',
    priority: 0,
    sortOrder: 7,
  ),
];
