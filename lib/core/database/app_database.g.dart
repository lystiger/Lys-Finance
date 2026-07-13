// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localizationKeyMeta = const VerificationMeta(
    'localizationKey',
  );
  @override
  late final GeneratedColumn<String> localizationKey = GeneratedColumn<String>(
    'localization_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingBalanceMinorMeta =
      const VerificationMeta('openingBalanceMinor');
  @override
  late final GeneratedColumn<int> openingBalanceMinor = GeneratedColumn<int>(
    'opening_balance_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorTokenMeta = const VerificationMeta(
    'colorToken',
  );
  @override
  late final GeneratedColumn<String> colorToken = GeneratedColumn<String>(
    'color_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('sort_order >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('version >= 1'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    normalizedName,
    localizationKey,
    type,
    currencyCode,
    openingBalanceMinor,
    iconKey,
    colorToken,
    sortOrder,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    }
    if (data.containsKey('localization_key')) {
      context.handle(
        _localizationKeyMeta,
        localizationKey.isAcceptableOrUnknown(
          data['localization_key']!,
          _localizationKeyMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('opening_balance_minor')) {
      context.handle(
        _openingBalanceMinorMeta,
        openingBalanceMinor.isAcceptableOrUnknown(
          data['opening_balance_minor']!,
          _openingBalanceMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingBalanceMinorMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_iconKeyMeta);
    }
    if (data.containsKey('color_token')) {
      context.handle(
        _colorTokenMeta,
        colorToken.isAcceptableOrUnknown(data['color_token']!, _colorTokenMeta),
      );
    } else if (isInserting) {
      context.missing(_colorTokenMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      ),
      localizationKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}localization_key'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      openingBalanceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_balance_minor'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      colorToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_token'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class AccountRow extends DataClass implements Insertable<AccountRow> {
  final String id;
  final String? name;
  final String? normalizedName;
  final String? localizationKey;
  final String type;
  final String currencyCode;
  final int openingBalanceMinor;
  final String iconKey;
  final String colorToken;
  final int sortOrder;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  final int version;
  const AccountRow({
    required this.id,
    this.name,
    this.normalizedName,
    this.localizationKey,
    required this.type,
    required this.currencyCode,
    required this.openingBalanceMinor,
    required this.iconKey,
    required this.colorToken,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || normalizedName != null) {
      map['normalized_name'] = Variable<String>(normalizedName);
    }
    if (!nullToAbsent || localizationKey != null) {
      map['localization_key'] = Variable<String>(localizationKey);
    }
    map['type'] = Variable<String>(type);
    map['currency_code'] = Variable<String>(currencyCode);
    map['opening_balance_minor'] = Variable<int>(openingBalanceMinor);
    map['icon_key'] = Variable<String>(iconKey);
    map['color_token'] = Variable<String>(colorToken);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      normalizedName: normalizedName == null && nullToAbsent
          ? const Value.absent()
          : Value(normalizedName),
      localizationKey: localizationKey == null && nullToAbsent
          ? const Value.absent()
          : Value(localizationKey),
      type: Value(type),
      currencyCode: Value(currencyCode),
      openingBalanceMinor: Value(openingBalanceMinor),
      iconKey: Value(iconKey),
      colorToken: Value(colorToken),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
    );
  }

  factory AccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      normalizedName: serializer.fromJson<String?>(json['normalizedName']),
      localizationKey: serializer.fromJson<String?>(json['localizationKey']),
      type: serializer.fromJson<String>(json['type']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      openingBalanceMinor: serializer.fromJson<int>(
        json['openingBalanceMinor'],
      ),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      colorToken: serializer.fromJson<String>(json['colorToken']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'normalizedName': serializer.toJson<String?>(normalizedName),
      'localizationKey': serializer.toJson<String?>(localizationKey),
      'type': serializer.toJson<String>(type),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'openingBalanceMinor': serializer.toJson<int>(openingBalanceMinor),
      'iconKey': serializer.toJson<String>(iconKey),
      'colorToken': serializer.toJson<String>(colorToken),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'version': serializer.toJson<int>(version),
    };
  }

  AccountRow copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> normalizedName = const Value.absent(),
    Value<String?> localizationKey = const Value.absent(),
    String? type,
    String? currencyCode,
    int? openingBalanceMinor,
    String? iconKey,
    String? colorToken,
    int? sortOrder,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    int? version,
  }) => AccountRow(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    normalizedName: normalizedName.present
        ? normalizedName.value
        : this.normalizedName,
    localizationKey: localizationKey.present
        ? localizationKey.value
        : this.localizationKey,
    type: type ?? this.type,
    currencyCode: currencyCode ?? this.currencyCode,
    openingBalanceMinor: openingBalanceMinor ?? this.openingBalanceMinor,
    iconKey: iconKey ?? this.iconKey,
    colorToken: colorToken ?? this.colorToken,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
  );
  AccountRow copyWithCompanion(AccountsCompanion data) {
    return AccountRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      localizationKey: data.localizationKey.present
          ? data.localizationKey.value
          : this.localizationKey,
      type: data.type.present ? data.type.value : this.type,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      openingBalanceMinor: data.openingBalanceMinor.present
          ? data.openingBalanceMinor.value
          : this.openingBalanceMinor,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      colorToken: data.colorToken.present
          ? data.colorToken.value
          : this.colorToken,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('localizationKey: $localizationKey, ')
          ..write('type: $type, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('openingBalanceMinor: $openingBalanceMinor, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorToken: $colorToken, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    normalizedName,
    localizationKey,
    type,
    currencyCode,
    openingBalanceMinor,
    iconKey,
    colorToken,
    sortOrder,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.localizationKey == this.localizationKey &&
          other.type == this.type &&
          other.currencyCode == this.currencyCode &&
          other.openingBalanceMinor == this.openingBalanceMinor &&
          other.iconKey == this.iconKey &&
          other.colorToken == this.colorToken &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version);
}

class AccountsCompanion extends UpdateCompanion<AccountRow> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> normalizedName;
  final Value<String?> localizationKey;
  final Value<String> type;
  final Value<String> currencyCode;
  final Value<int> openingBalanceMinor;
  final Value<String> iconKey;
  final Value<String> colorToken;
  final Value<int> sortOrder;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> version;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.localizationKey = const Value.absent(),
    this.type = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.openingBalanceMinor = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.colorToken = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.localizationKey = const Value.absent(),
    required String type,
    required String currencyCode,
    required int openingBalanceMinor,
    required String iconKey,
    required String colorToken,
    required int sortOrder,
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    required int version,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       currencyCode = Value(currencyCode),
       openingBalanceMinor = Value(openingBalanceMinor),
       iconKey = Value(iconKey),
       colorToken = Value(colorToken),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       version = Value(version);
  static Insertable<AccountRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? localizationKey,
    Expression<String>? type,
    Expression<String>? currencyCode,
    Expression<int>? openingBalanceMinor,
    Expression<String>? iconKey,
    Expression<String>? colorToken,
    Expression<int>? sortOrder,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (localizationKey != null) 'localization_key': localizationKey,
      if (type != null) 'type': type,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (openingBalanceMinor != null)
        'opening_balance_minor': openingBalanceMinor,
      if (iconKey != null) 'icon_key': iconKey,
      if (colorToken != null) 'color_token': colorToken,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? normalizedName,
    Value<String?>? localizationKey,
    Value<String>? type,
    Value<String>? currencyCode,
    Value<int>? openingBalanceMinor,
    Value<String>? iconKey,
    Value<String>? colorToken,
    Value<int>? sortOrder,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      localizationKey: localizationKey ?? this.localizationKey,
      type: type ?? this.type,
      currencyCode: currencyCode ?? this.currencyCode,
      openingBalanceMinor: openingBalanceMinor ?? this.openingBalanceMinor,
      iconKey: iconKey ?? this.iconKey,
      colorToken: colorToken ?? this.colorToken,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (localizationKey.present) {
      map['localization_key'] = Variable<String>(localizationKey.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (openingBalanceMinor.present) {
      map['opening_balance_minor'] = Variable<int>(openingBalanceMinor.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (colorToken.present) {
      map['color_token'] = Variable<String>(colorToken.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('localizationKey: $localizationKey, ')
          ..write('type: $type, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('openingBalanceMinor: $openingBalanceMinor, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorToken: $colorToken, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localizationKeyMeta = const VerificationMeta(
    'localizationKey',
  );
  @override
  late final GeneratedColumn<String> localizationKey = GeneratedColumn<String>(
    'localization_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _incClassMeta = const VerificationMeta(
    'incClass',
  );
  @override
  late final GeneratedColumn<String> incClass = GeneratedColumn<String>(
    'inc_class',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorTokenMeta = const VerificationMeta(
    'colorToken',
  );
  @override
  late final GeneratedColumn<String> colorToken = GeneratedColumn<String>(
    'color_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('sort_order >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('version >= 1'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    normalizedName,
    localizationKey,
    type,
    incClass,
    iconKey,
    colorToken,
    sortOrder,
    isSystem,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    }
    if (data.containsKey('localization_key')) {
      context.handle(
        _localizationKeyMeta,
        localizationKey.isAcceptableOrUnknown(
          data['localization_key']!,
          _localizationKeyMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('inc_class')) {
      context.handle(
        _incClassMeta,
        incClass.isAcceptableOrUnknown(data['inc_class']!, _incClassMeta),
      );
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_iconKeyMeta);
    }
    if (data.containsKey('color_token')) {
      context.handle(
        _colorTokenMeta,
        colorToken.isAcceptableOrUnknown(data['color_token']!, _colorTokenMeta),
      );
    } else if (isInserting) {
      context.missing(_colorTokenMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    } else if (isInserting) {
      context.missing(_isSystemMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      ),
      localizationKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}localization_key'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      incClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inc_class'],
      ),
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      colorToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_token'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final String id;
  final String? name;
  final String? normalizedName;
  final String? localizationKey;
  final String type;
  final String? incClass;
  final String iconKey;
  final String colorToken;
  final int sortOrder;
  final bool isSystem;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  final int version;
  const CategoryRow({
    required this.id,
    this.name,
    this.normalizedName,
    this.localizationKey,
    required this.type,
    this.incClass,
    required this.iconKey,
    required this.colorToken,
    required this.sortOrder,
    required this.isSystem,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || normalizedName != null) {
      map['normalized_name'] = Variable<String>(normalizedName);
    }
    if (!nullToAbsent || localizationKey != null) {
      map['localization_key'] = Variable<String>(localizationKey);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || incClass != null) {
      map['inc_class'] = Variable<String>(incClass);
    }
    map['icon_key'] = Variable<String>(iconKey);
    map['color_token'] = Variable<String>(colorToken);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_system'] = Variable<bool>(isSystem);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      normalizedName: normalizedName == null && nullToAbsent
          ? const Value.absent()
          : Value(normalizedName),
      localizationKey: localizationKey == null && nullToAbsent
          ? const Value.absent()
          : Value(localizationKey),
      type: Value(type),
      incClass: incClass == null && nullToAbsent
          ? const Value.absent()
          : Value(incClass),
      iconKey: Value(iconKey),
      colorToken: Value(colorToken),
      sortOrder: Value(sortOrder),
      isSystem: Value(isSystem),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
    );
  }

  factory CategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      normalizedName: serializer.fromJson<String?>(json['normalizedName']),
      localizationKey: serializer.fromJson<String?>(json['localizationKey']),
      type: serializer.fromJson<String>(json['type']),
      incClass: serializer.fromJson<String?>(json['incClass']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      colorToken: serializer.fromJson<String>(json['colorToken']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'normalizedName': serializer.toJson<String?>(normalizedName),
      'localizationKey': serializer.toJson<String?>(localizationKey),
      'type': serializer.toJson<String>(type),
      'incClass': serializer.toJson<String?>(incClass),
      'iconKey': serializer.toJson<String>(iconKey),
      'colorToken': serializer.toJson<String>(colorToken),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isSystem': serializer.toJson<bool>(isSystem),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'version': serializer.toJson<int>(version),
    };
  }

  CategoryRow copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> normalizedName = const Value.absent(),
    Value<String?> localizationKey = const Value.absent(),
    String? type,
    Value<String?> incClass = const Value.absent(),
    String? iconKey,
    String? colorToken,
    int? sortOrder,
    bool? isSystem,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    int? version,
  }) => CategoryRow(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    normalizedName: normalizedName.present
        ? normalizedName.value
        : this.normalizedName,
    localizationKey: localizationKey.present
        ? localizationKey.value
        : this.localizationKey,
    type: type ?? this.type,
    incClass: incClass.present ? incClass.value : this.incClass,
    iconKey: iconKey ?? this.iconKey,
    colorToken: colorToken ?? this.colorToken,
    sortOrder: sortOrder ?? this.sortOrder,
    isSystem: isSystem ?? this.isSystem,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
  );
  CategoryRow copyWithCompanion(CategoriesCompanion data) {
    return CategoryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      localizationKey: data.localizationKey.present
          ? data.localizationKey.value
          : this.localizationKey,
      type: data.type.present ? data.type.value : this.type,
      incClass: data.incClass.present ? data.incClass.value : this.incClass,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      colorToken: data.colorToken.present
          ? data.colorToken.value
          : this.colorToken,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('localizationKey: $localizationKey, ')
          ..write('type: $type, ')
          ..write('incClass: $incClass, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorToken: $colorToken, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSystem: $isSystem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    normalizedName,
    localizationKey,
    type,
    incClass,
    iconKey,
    colorToken,
    sortOrder,
    isSystem,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.localizationKey == this.localizationKey &&
          other.type == this.type &&
          other.incClass == this.incClass &&
          other.iconKey == this.iconKey &&
          other.colorToken == this.colorToken &&
          other.sortOrder == this.sortOrder &&
          other.isSystem == this.isSystem &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version);
}

class CategoriesCompanion extends UpdateCompanion<CategoryRow> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> normalizedName;
  final Value<String?> localizationKey;
  final Value<String> type;
  final Value<String?> incClass;
  final Value<String> iconKey;
  final Value<String> colorToken;
  final Value<int> sortOrder;
  final Value<bool> isSystem;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> version;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.localizationKey = const Value.absent(),
    this.type = const Value.absent(),
    this.incClass = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.colorToken = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.localizationKey = const Value.absent(),
    required String type,
    this.incClass = const Value.absent(),
    required String iconKey,
    required String colorToken,
    required int sortOrder,
    required bool isSystem,
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    required int version,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       iconKey = Value(iconKey),
       colorToken = Value(colorToken),
       sortOrder = Value(sortOrder),
       isSystem = Value(isSystem),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       version = Value(version);
  static Insertable<CategoryRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? localizationKey,
    Expression<String>? type,
    Expression<String>? incClass,
    Expression<String>? iconKey,
    Expression<String>? colorToken,
    Expression<int>? sortOrder,
    Expression<bool>? isSystem,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (localizationKey != null) 'localization_key': localizationKey,
      if (type != null) 'type': type,
      if (incClass != null) 'inc_class': incClass,
      if (iconKey != null) 'icon_key': iconKey,
      if (colorToken != null) 'color_token': colorToken,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isSystem != null) 'is_system': isSystem,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? normalizedName,
    Value<String?>? localizationKey,
    Value<String>? type,
    Value<String?>? incClass,
    Value<String>? iconKey,
    Value<String>? colorToken,
    Value<int>? sortOrder,
    Value<bool>? isSystem,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      localizationKey: localizationKey ?? this.localizationKey,
      type: type ?? this.type,
      incClass: incClass ?? this.incClass,
      iconKey: iconKey ?? this.iconKey,
      colorToken: colorToken ?? this.colorToken,
      sortOrder: sortOrder ?? this.sortOrder,
      isSystem: isSystem ?? this.isSystem,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (localizationKey.present) {
      map['localization_key'] = Variable<String>(localizationKey.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (incClass.present) {
      map['inc_class'] = Variable<String>(incClass.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (colorToken.present) {
      map['color_token'] = Variable<String>(colorToken.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('localizationKey: $localizationKey, ')
          ..write('type: $type, ')
          ..write('incClass: $incClass, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorToken: $colorToken, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSystem: $isSystem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsEntriesTable extends AppSettingsEntries
    with TableInfo<$AppSettingsEntriesTable, AppSettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyCodeMeta = const VerificationMeta(
    'baseCurrencyCode',
  );
  @override
  late final GeneratedColumn<String> baseCurrencyCode = GeneratedColumn<String>(
    'base_currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reducedMotionMeta = const VerificationMeta(
    'reducedMotion',
  );
  @override
  late final GeneratedColumn<bool> reducedMotion = GeneratedColumn<bool>(
    'reduced_motion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reduced_motion" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('version >= 1'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    baseCurrencyCode,
    locale,
    themeMode,
    reducedMotion,
    createdAt,
    updatedAt,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('base_currency_code')) {
      context.handle(
        _baseCurrencyCodeMeta,
        baseCurrencyCode.isAcceptableOrUnknown(
          data['base_currency_code']!,
          _baseCurrencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseCurrencyCodeMeta);
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    } else if (isInserting) {
      context.missing(_themeModeMeta);
    }
    if (data.containsKey('reduced_motion')) {
      context.handle(
        _reducedMotionMeta,
        reducedMotion.isAcceptableOrUnknown(
          data['reduced_motion']!,
          _reducedMotionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reducedMotionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      baseCurrencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency_code'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      ),
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      reducedMotion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reduced_motion'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $AppSettingsEntriesTable createAlias(String alias) {
    return $AppSettingsEntriesTable(attachedDatabase, alias);
  }
}

class AppSettingRow extends DataClass implements Insertable<AppSettingRow> {
  final String id;
  final String baseCurrencyCode;
  final String? locale;
  final String themeMode;
  final bool reducedMotion;
  final int createdAt;
  final int updatedAt;
  final int version;
  const AppSettingRow({
    required this.id,
    required this.baseCurrencyCode,
    this.locale,
    required this.themeMode,
    required this.reducedMotion,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['base_currency_code'] = Variable<String>(baseCurrencyCode);
    if (!nullToAbsent || locale != null) {
      map['locale'] = Variable<String>(locale);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    map['reduced_motion'] = Variable<bool>(reducedMotion);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['version'] = Variable<int>(version);
    return map;
  }

  AppSettingsEntriesCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsEntriesCompanion(
      id: Value(id),
      baseCurrencyCode: Value(baseCurrencyCode),
      locale: locale == null && nullToAbsent
          ? const Value.absent()
          : Value(locale),
      themeMode: Value(themeMode),
      reducedMotion: Value(reducedMotion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
    );
  }

  factory AppSettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingRow(
      id: serializer.fromJson<String>(json['id']),
      baseCurrencyCode: serializer.fromJson<String>(json['baseCurrencyCode']),
      locale: serializer.fromJson<String?>(json['locale']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      reducedMotion: serializer.fromJson<bool>(json['reducedMotion']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'baseCurrencyCode': serializer.toJson<String>(baseCurrencyCode),
      'locale': serializer.toJson<String?>(locale),
      'themeMode': serializer.toJson<String>(themeMode),
      'reducedMotion': serializer.toJson<bool>(reducedMotion),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'version': serializer.toJson<int>(version),
    };
  }

  AppSettingRow copyWith({
    String? id,
    String? baseCurrencyCode,
    Value<String?> locale = const Value.absent(),
    String? themeMode,
    bool? reducedMotion,
    int? createdAt,
    int? updatedAt,
    int? version,
  }) => AppSettingRow(
    id: id ?? this.id,
    baseCurrencyCode: baseCurrencyCode ?? this.baseCurrencyCode,
    locale: locale.present ? locale.value : this.locale,
    themeMode: themeMode ?? this.themeMode,
    reducedMotion: reducedMotion ?? this.reducedMotion,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    version: version ?? this.version,
  );
  AppSettingRow copyWithCompanion(AppSettingsEntriesCompanion data) {
    return AppSettingRow(
      id: data.id.present ? data.id.value : this.id,
      baseCurrencyCode: data.baseCurrencyCode.present
          ? data.baseCurrencyCode.value
          : this.baseCurrencyCode,
      locale: data.locale.present ? data.locale.value : this.locale,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      reducedMotion: data.reducedMotion.present
          ? data.reducedMotion.value
          : this.reducedMotion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingRow(')
          ..write('id: $id, ')
          ..write('baseCurrencyCode: $baseCurrencyCode, ')
          ..write('locale: $locale, ')
          ..write('themeMode: $themeMode, ')
          ..write('reducedMotion: $reducedMotion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    baseCurrencyCode,
    locale,
    themeMode,
    reducedMotion,
    createdAt,
    updatedAt,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingRow &&
          other.id == this.id &&
          other.baseCurrencyCode == this.baseCurrencyCode &&
          other.locale == this.locale &&
          other.themeMode == this.themeMode &&
          other.reducedMotion == this.reducedMotion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version);
}

class AppSettingsEntriesCompanion extends UpdateCompanion<AppSettingRow> {
  final Value<String> id;
  final Value<String> baseCurrencyCode;
  final Value<String?> locale;
  final Value<String> themeMode;
  final Value<bool> reducedMotion;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> version;
  final Value<int> rowid;
  const AppSettingsEntriesCompanion({
    this.id = const Value.absent(),
    this.baseCurrencyCode = const Value.absent(),
    this.locale = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.reducedMotion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsEntriesCompanion.insert({
    required String id,
    required String baseCurrencyCode,
    this.locale = const Value.absent(),
    required String themeMode,
    required bool reducedMotion,
    required int createdAt,
    required int updatedAt,
    required int version,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       baseCurrencyCode = Value(baseCurrencyCode),
       themeMode = Value(themeMode),
       reducedMotion = Value(reducedMotion),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       version = Value(version);
  static Insertable<AppSettingRow> custom({
    Expression<String>? id,
    Expression<String>? baseCurrencyCode,
    Expression<String>? locale,
    Expression<String>? themeMode,
    Expression<bool>? reducedMotion,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseCurrencyCode != null) 'base_currency_code': baseCurrencyCode,
      if (locale != null) 'locale': locale,
      if (themeMode != null) 'theme_mode': themeMode,
      if (reducedMotion != null) 'reduced_motion': reducedMotion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? baseCurrencyCode,
    Value<String?>? locale,
    Value<String>? themeMode,
    Value<bool>? reducedMotion,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return AppSettingsEntriesCompanion(
      id: id ?? this.id,
      baseCurrencyCode: baseCurrencyCode ?? this.baseCurrencyCode,
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (baseCurrencyCode.present) {
      map['base_currency_code'] = Variable<String>(baseCurrencyCode.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (reducedMotion.present) {
      map['reduced_motion'] = Variable<bool>(reducedMotion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsEntriesCompanion(')
          ..write('id: $id, ')
          ..write('baseCurrencyCode: $baseCurrencyCode, ')
          ..write('locale: $locale, ')
          ..write('themeMode: $themeMode, ')
          ..write('reducedMotion: $reducedMotion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetadataEntriesTable extends AppMetadataEntries
    with TableInfo<$AppMetadataEntriesTable, AppMetadataRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetadataEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_metadata_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetadataRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetadataRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetadataRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppMetadataEntriesTable createAlias(String alias) {
    return $AppMetadataEntriesTable(attachedDatabase, alias);
  }
}

class AppMetadataRow extends DataClass implements Insertable<AppMetadataRow> {
  final String key;
  final String value;
  final int updatedAt;
  const AppMetadataRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  AppMetadataEntriesCompanion toCompanion(bool nullToAbsent) {
    return AppMetadataEntriesCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppMetadataRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetadataRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  AppMetadataRow copyWith({String? key, String? value, int? updatedAt}) =>
      AppMetadataRow(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppMetadataRow copyWithCompanion(AppMetadataEntriesCompanion data) {
    return AppMetadataRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetadataRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetadataRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppMetadataEntriesCompanion extends UpdateCompanion<AppMetadataRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const AppMetadataEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetadataEntriesCompanion.insert({
    required String key,
    required String value,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<AppMetadataRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetadataEntriesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppMetadataEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetadataEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VaultsTable extends Vaults with TableInfo<$VaultsTable, VaultRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localizationKeyMeta = const VerificationMeta(
    'localizationKey',
  );
  @override
  late final GeneratedColumn<String> localizationKey = GeneratedColumn<String>(
    'localization_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorTokenMeta = const VerificationMeta(
    'colorToken',
  );
  @override
  late final GeneratedColumn<String> colorToken = GeneratedColumn<String>(
    'color_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalAmountMinorMeta = const VerificationMeta(
    'goalAmountMinor',
  );
  @override
  late final GeneratedColumn<int> goalAmountMinor = GeneratedColumn<int>(
    'goal_amount_minor',
    aliasedName,
    true,
    check: () => const CustomExpression<bool>(
      'goal_amount_minor IS NULL OR goal_amount_minor > 0',
    ),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<int> targetDate = GeneratedColumn<int>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('priority >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('sort_order >= 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _withdrawalPolicyMeta = const VerificationMeta(
    'withdrawalPolicy',
  );
  @override
  late final GeneratedColumn<String> withdrawalPolicy = GeneratedColumn<String>(
    'withdrawal_policy',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      "withdrawal_policy IN ('locked','soft','deadlineLinked')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant<bool>(false),
  );
  static const VerificationMeta _autoContributionEnabledMeta =
      const VerificationMeta('autoContributionEnabled');
  @override
  late final GeneratedColumn<bool> autoContributionEnabled =
      GeneratedColumn<bool>(
        'auto_contribution_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("auto_contribution_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant<bool>(false),
      );
  static const VerificationMeta _autoContributionKindMeta =
      const VerificationMeta('autoContributionKind');
  @override
  late final GeneratedColumn<String>
  autoContributionKind = GeneratedColumn<String>(
    'auto_contribution_kind',
    aliasedName,
    true,
    check: () => const CustomExpression<bool>(
      "auto_contribution_kind IS NULL OR auto_contribution_kind IN ('fixed','percentOfIncome')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autoContributionValueMeta =
      const VerificationMeta('autoContributionValue');
  @override
  late final GeneratedColumn<int> autoContributionValue = GeneratedColumn<int>(
    'auto_contribution_value',
    aliasedName,
    true,
    check: () => const CustomExpression<bool>(
      'auto_contribution_value IS NULL OR auto_contribution_value > 0',
    ),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('version >= 1'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    localizationKey,
    description,
    iconKey,
    colorToken,
    currencyCode,
    goalAmountMinor,
    targetDate,
    priority,
    sortOrder,
    withdrawalPolicy,
    isSystem,
    autoContributionEnabled,
    autoContributionKind,
    autoContributionValue,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vaults';
  @override
  VerificationContext validateIntegrity(
    Insertable<VaultRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('localization_key')) {
      context.handle(
        _localizationKeyMeta,
        localizationKey.isAcceptableOrUnknown(
          data['localization_key']!,
          _localizationKeyMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_iconKeyMeta);
    }
    if (data.containsKey('color_token')) {
      context.handle(
        _colorTokenMeta,
        colorToken.isAcceptableOrUnknown(data['color_token']!, _colorTokenMeta),
      );
    } else if (isInserting) {
      context.missing(_colorTokenMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('goal_amount_minor')) {
      context.handle(
        _goalAmountMinorMeta,
        goalAmountMinor.isAcceptableOrUnknown(
          data['goal_amount_minor']!,
          _goalAmountMinorMeta,
        ),
      );
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('withdrawal_policy')) {
      context.handle(
        _withdrawalPolicyMeta,
        withdrawalPolicy.isAcceptableOrUnknown(
          data['withdrawal_policy']!,
          _withdrawalPolicyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_withdrawalPolicyMeta);
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('auto_contribution_enabled')) {
      context.handle(
        _autoContributionEnabledMeta,
        autoContributionEnabled.isAcceptableOrUnknown(
          data['auto_contribution_enabled']!,
          _autoContributionEnabledMeta,
        ),
      );
    }
    if (data.containsKey('auto_contribution_kind')) {
      context.handle(
        _autoContributionKindMeta,
        autoContributionKind.isAcceptableOrUnknown(
          data['auto_contribution_kind']!,
          _autoContributionKindMeta,
        ),
      );
    }
    if (data.containsKey('auto_contribution_value')) {
      context.handle(
        _autoContributionValueMeta,
        autoContributionValue.isAcceptableOrUnknown(
          data['auto_contribution_value']!,
          _autoContributionValueMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaultRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      localizationKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}localization_key'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      colorToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_token'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      goalAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_amount_minor'],
      ),
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_date'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      withdrawalPolicy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}withdrawal_policy'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      autoContributionEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_contribution_enabled'],
      )!,
      autoContributionKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auto_contribution_kind'],
      ),
      autoContributionValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_contribution_value'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $VaultsTable createAlias(String alias) {
    return $VaultsTable(attachedDatabase, alias);
  }
}

class VaultRow extends DataClass implements Insertable<VaultRow> {
  final String id;
  final String? name;
  final String? localizationKey;
  final String? description;
  final String iconKey;
  final String colorToken;
  final String currencyCode;
  final int? goalAmountMinor;
  final int? targetDate;
  final int priority;
  final int sortOrder;
  final String withdrawalPolicy;
  final bool isSystem;
  final bool autoContributionEnabled;
  final String? autoContributionKind;
  final int? autoContributionValue;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  final int version;
  const VaultRow({
    required this.id,
    this.name,
    this.localizationKey,
    this.description,
    required this.iconKey,
    required this.colorToken,
    required this.currencyCode,
    this.goalAmountMinor,
    this.targetDate,
    required this.priority,
    required this.sortOrder,
    required this.withdrawalPolicy,
    required this.isSystem,
    required this.autoContributionEnabled,
    this.autoContributionKind,
    this.autoContributionValue,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || localizationKey != null) {
      map['localization_key'] = Variable<String>(localizationKey);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['icon_key'] = Variable<String>(iconKey);
    map['color_token'] = Variable<String>(colorToken);
    map['currency_code'] = Variable<String>(currencyCode);
    if (!nullToAbsent || goalAmountMinor != null) {
      map['goal_amount_minor'] = Variable<int>(goalAmountMinor);
    }
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<int>(targetDate);
    }
    map['priority'] = Variable<int>(priority);
    map['sort_order'] = Variable<int>(sortOrder);
    map['withdrawal_policy'] = Variable<String>(withdrawalPolicy);
    map['is_system'] = Variable<bool>(isSystem);
    map['auto_contribution_enabled'] = Variable<bool>(autoContributionEnabled);
    if (!nullToAbsent || autoContributionKind != null) {
      map['auto_contribution_kind'] = Variable<String>(autoContributionKind);
    }
    if (!nullToAbsent || autoContributionValue != null) {
      map['auto_contribution_value'] = Variable<int>(autoContributionValue);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    return map;
  }

  VaultsCompanion toCompanion(bool nullToAbsent) {
    return VaultsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      localizationKey: localizationKey == null && nullToAbsent
          ? const Value.absent()
          : Value(localizationKey),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      iconKey: Value(iconKey),
      colorToken: Value(colorToken),
      currencyCode: Value(currencyCode),
      goalAmountMinor: goalAmountMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(goalAmountMinor),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      priority: Value(priority),
      sortOrder: Value(sortOrder),
      withdrawalPolicy: Value(withdrawalPolicy),
      isSystem: Value(isSystem),
      autoContributionEnabled: Value(autoContributionEnabled),
      autoContributionKind: autoContributionKind == null && nullToAbsent
          ? const Value.absent()
          : Value(autoContributionKind),
      autoContributionValue: autoContributionValue == null && nullToAbsent
          ? const Value.absent()
          : Value(autoContributionValue),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
    );
  }

  factory VaultRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      localizationKey: serializer.fromJson<String?>(json['localizationKey']),
      description: serializer.fromJson<String?>(json['description']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      colorToken: serializer.fromJson<String>(json['colorToken']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      goalAmountMinor: serializer.fromJson<int?>(json['goalAmountMinor']),
      targetDate: serializer.fromJson<int?>(json['targetDate']),
      priority: serializer.fromJson<int>(json['priority']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      withdrawalPolicy: serializer.fromJson<String>(json['withdrawalPolicy']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      autoContributionEnabled: serializer.fromJson<bool>(
        json['autoContributionEnabled'],
      ),
      autoContributionKind: serializer.fromJson<String?>(
        json['autoContributionKind'],
      ),
      autoContributionValue: serializer.fromJson<int?>(
        json['autoContributionValue'],
      ),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'localizationKey': serializer.toJson<String?>(localizationKey),
      'description': serializer.toJson<String?>(description),
      'iconKey': serializer.toJson<String>(iconKey),
      'colorToken': serializer.toJson<String>(colorToken),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'goalAmountMinor': serializer.toJson<int?>(goalAmountMinor),
      'targetDate': serializer.toJson<int?>(targetDate),
      'priority': serializer.toJson<int>(priority),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'withdrawalPolicy': serializer.toJson<String>(withdrawalPolicy),
      'isSystem': serializer.toJson<bool>(isSystem),
      'autoContributionEnabled': serializer.toJson<bool>(
        autoContributionEnabled,
      ),
      'autoContributionKind': serializer.toJson<String?>(autoContributionKind),
      'autoContributionValue': serializer.toJson<int?>(autoContributionValue),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'version': serializer.toJson<int>(version),
    };
  }

  VaultRow copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> localizationKey = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? iconKey,
    String? colorToken,
    String? currencyCode,
    Value<int?> goalAmountMinor = const Value.absent(),
    Value<int?> targetDate = const Value.absent(),
    int? priority,
    int? sortOrder,
    String? withdrawalPolicy,
    bool? isSystem,
    bool? autoContributionEnabled,
    Value<String?> autoContributionKind = const Value.absent(),
    Value<int?> autoContributionValue = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    int? version,
  }) => VaultRow(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    localizationKey: localizationKey.present
        ? localizationKey.value
        : this.localizationKey,
    description: description.present ? description.value : this.description,
    iconKey: iconKey ?? this.iconKey,
    colorToken: colorToken ?? this.colorToken,
    currencyCode: currencyCode ?? this.currencyCode,
    goalAmountMinor: goalAmountMinor.present
        ? goalAmountMinor.value
        : this.goalAmountMinor,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    priority: priority ?? this.priority,
    sortOrder: sortOrder ?? this.sortOrder,
    withdrawalPolicy: withdrawalPolicy ?? this.withdrawalPolicy,
    isSystem: isSystem ?? this.isSystem,
    autoContributionEnabled:
        autoContributionEnabled ?? this.autoContributionEnabled,
    autoContributionKind: autoContributionKind.present
        ? autoContributionKind.value
        : this.autoContributionKind,
    autoContributionValue: autoContributionValue.present
        ? autoContributionValue.value
        : this.autoContributionValue,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
  );
  VaultRow copyWithCompanion(VaultsCompanion data) {
    return VaultRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      localizationKey: data.localizationKey.present
          ? data.localizationKey.value
          : this.localizationKey,
      description: data.description.present
          ? data.description.value
          : this.description,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      colorToken: data.colorToken.present
          ? data.colorToken.value
          : this.colorToken,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      goalAmountMinor: data.goalAmountMinor.present
          ? data.goalAmountMinor.value
          : this.goalAmountMinor,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      priority: data.priority.present ? data.priority.value : this.priority,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      withdrawalPolicy: data.withdrawalPolicy.present
          ? data.withdrawalPolicy.value
          : this.withdrawalPolicy,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      autoContributionEnabled: data.autoContributionEnabled.present
          ? data.autoContributionEnabled.value
          : this.autoContributionEnabled,
      autoContributionKind: data.autoContributionKind.present
          ? data.autoContributionKind.value
          : this.autoContributionKind,
      autoContributionValue: data.autoContributionValue.present
          ? data.autoContributionValue.value
          : this.autoContributionValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('localizationKey: $localizationKey, ')
          ..write('description: $description, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorToken: $colorToken, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('goalAmountMinor: $goalAmountMinor, ')
          ..write('targetDate: $targetDate, ')
          ..write('priority: $priority, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('withdrawalPolicy: $withdrawalPolicy, ')
          ..write('isSystem: $isSystem, ')
          ..write('autoContributionEnabled: $autoContributionEnabled, ')
          ..write('autoContributionKind: $autoContributionKind, ')
          ..write('autoContributionValue: $autoContributionValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    localizationKey,
    description,
    iconKey,
    colorToken,
    currencyCode,
    goalAmountMinor,
    targetDate,
    priority,
    sortOrder,
    withdrawalPolicy,
    isSystem,
    autoContributionEnabled,
    autoContributionKind,
    autoContributionValue,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.localizationKey == this.localizationKey &&
          other.description == this.description &&
          other.iconKey == this.iconKey &&
          other.colorToken == this.colorToken &&
          other.currencyCode == this.currencyCode &&
          other.goalAmountMinor == this.goalAmountMinor &&
          other.targetDate == this.targetDate &&
          other.priority == this.priority &&
          other.sortOrder == this.sortOrder &&
          other.withdrawalPolicy == this.withdrawalPolicy &&
          other.isSystem == this.isSystem &&
          other.autoContributionEnabled == this.autoContributionEnabled &&
          other.autoContributionKind == this.autoContributionKind &&
          other.autoContributionValue == this.autoContributionValue &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version);
}

class VaultsCompanion extends UpdateCompanion<VaultRow> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> localizationKey;
  final Value<String?> description;
  final Value<String> iconKey;
  final Value<String> colorToken;
  final Value<String> currencyCode;
  final Value<int?> goalAmountMinor;
  final Value<int?> targetDate;
  final Value<int> priority;
  final Value<int> sortOrder;
  final Value<String> withdrawalPolicy;
  final Value<bool> isSystem;
  final Value<bool> autoContributionEnabled;
  final Value<String?> autoContributionKind;
  final Value<int?> autoContributionValue;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> version;
  final Value<int> rowid;
  const VaultsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.localizationKey = const Value.absent(),
    this.description = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.colorToken = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.goalAmountMinor = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.withdrawalPolicy = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.autoContributionEnabled = const Value.absent(),
    this.autoContributionKind = const Value.absent(),
    this.autoContributionValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VaultsCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.localizationKey = const Value.absent(),
    this.description = const Value.absent(),
    required String iconKey,
    required String colorToken,
    required String currencyCode,
    this.goalAmountMinor = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.priority = const Value.absent(),
    required int sortOrder,
    required String withdrawalPolicy,
    this.isSystem = const Value.absent(),
    this.autoContributionEnabled = const Value.absent(),
    this.autoContributionKind = const Value.absent(),
    this.autoContributionValue = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    required int version,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       iconKey = Value(iconKey),
       colorToken = Value(colorToken),
       currencyCode = Value(currencyCode),
       sortOrder = Value(sortOrder),
       withdrawalPolicy = Value(withdrawalPolicy),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       version = Value(version);
  static Insertable<VaultRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? localizationKey,
    Expression<String>? description,
    Expression<String>? iconKey,
    Expression<String>? colorToken,
    Expression<String>? currencyCode,
    Expression<int>? goalAmountMinor,
    Expression<int>? targetDate,
    Expression<int>? priority,
    Expression<int>? sortOrder,
    Expression<String>? withdrawalPolicy,
    Expression<bool>? isSystem,
    Expression<bool>? autoContributionEnabled,
    Expression<String>? autoContributionKind,
    Expression<int>? autoContributionValue,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (localizationKey != null) 'localization_key': localizationKey,
      if (description != null) 'description': description,
      if (iconKey != null) 'icon_key': iconKey,
      if (colorToken != null) 'color_token': colorToken,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (goalAmountMinor != null) 'goal_amount_minor': goalAmountMinor,
      if (targetDate != null) 'target_date': targetDate,
      if (priority != null) 'priority': priority,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (withdrawalPolicy != null) 'withdrawal_policy': withdrawalPolicy,
      if (isSystem != null) 'is_system': isSystem,
      if (autoContributionEnabled != null)
        'auto_contribution_enabled': autoContributionEnabled,
      if (autoContributionKind != null)
        'auto_contribution_kind': autoContributionKind,
      if (autoContributionValue != null)
        'auto_contribution_value': autoContributionValue,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VaultsCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? localizationKey,
    Value<String?>? description,
    Value<String>? iconKey,
    Value<String>? colorToken,
    Value<String>? currencyCode,
    Value<int?>? goalAmountMinor,
    Value<int?>? targetDate,
    Value<int>? priority,
    Value<int>? sortOrder,
    Value<String>? withdrawalPolicy,
    Value<bool>? isSystem,
    Value<bool>? autoContributionEnabled,
    Value<String?>? autoContributionKind,
    Value<int?>? autoContributionValue,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return VaultsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      localizationKey: localizationKey ?? this.localizationKey,
      description: description ?? this.description,
      iconKey: iconKey ?? this.iconKey,
      colorToken: colorToken ?? this.colorToken,
      currencyCode: currencyCode ?? this.currencyCode,
      goalAmountMinor: goalAmountMinor ?? this.goalAmountMinor,
      targetDate: targetDate ?? this.targetDate,
      priority: priority ?? this.priority,
      sortOrder: sortOrder ?? this.sortOrder,
      withdrawalPolicy: withdrawalPolicy ?? this.withdrawalPolicy,
      isSystem: isSystem ?? this.isSystem,
      autoContributionEnabled:
          autoContributionEnabled ?? this.autoContributionEnabled,
      autoContributionKind: autoContributionKind ?? this.autoContributionKind,
      autoContributionValue:
          autoContributionValue ?? this.autoContributionValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (localizationKey.present) {
      map['localization_key'] = Variable<String>(localizationKey.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (colorToken.present) {
      map['color_token'] = Variable<String>(colorToken.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (goalAmountMinor.present) {
      map['goal_amount_minor'] = Variable<int>(goalAmountMinor.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<int>(targetDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (withdrawalPolicy.present) {
      map['withdrawal_policy'] = Variable<String>(withdrawalPolicy.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (autoContributionEnabled.present) {
      map['auto_contribution_enabled'] = Variable<bool>(
        autoContributionEnabled.value,
      );
    }
    if (autoContributionKind.present) {
      map['auto_contribution_kind'] = Variable<String>(
        autoContributionKind.value,
      );
    }
    if (autoContributionValue.present) {
      map['auto_contribution_value'] = Variable<int>(
        autoContributionValue.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('localizationKey: $localizationKey, ')
          ..write('description: $description, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorToken: $colorToken, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('goalAmountMinor: $goalAmountMinor, ')
          ..write('targetDate: $targetDate, ')
          ..write('priority: $priority, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('withdrawalPolicy: $withdrawalPolicy, ')
          ..write('isSystem: $isSystem, ')
          ..write('autoContributionEnabled: $autoContributionEnabled, ')
          ..write('autoContributionKind: $autoContributionKind, ')
          ..write('autoContributionValue: $autoContributionValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      "type IN ('expense','income','transfer','contribution','withdrawal')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _vaultIdMeta = const VerificationMeta(
    'vaultId',
  );
  @override
  late final GeneratedColumn<String> vaultId = GeneratedColumn<String>(
    'vault_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vaults (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _incClassMeta = const VerificationMeta(
    'incClass',
  );
  @override
  late final GeneratedColumn<String> incClass = GeneratedColumn<String>(
    'inc_class',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('amount_minor > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 2000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<int> occurredAt = GeneratedColumn<int>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('version >= 1'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    accountId,
    categoryId,
    vaultId,
    incClass,
    currencyCode,
    amountMinor,
    note,
    occurredAt,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('vault_id')) {
      context.handle(
        _vaultIdMeta,
        vaultId.isAcceptableOrUnknown(data['vault_id']!, _vaultIdMeta),
      );
    }
    if (data.containsKey('inc_class')) {
      context.handle(
        _incClassMeta,
        incClass.isAcceptableOrUnknown(data['inc_class']!, _incClassMeta),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      vaultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vault_id'],
      ),
      incClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inc_class'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurred_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionRow extends DataClass implements Insertable<TransactionRow> {
  final String id;
  final String type;
  final String accountId;
  final String? categoryId;
  final String? vaultId;
  final String? incClass;
  final String currencyCode;
  final int amountMinor;
  final String? note;
  final int occurredAt;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  final int version;
  const TransactionRow({
    required this.id,
    required this.type,
    required this.accountId,
    this.categoryId,
    this.vaultId,
    this.incClass,
    required this.currencyCode,
    required this.amountMinor,
    this.note,
    required this.occurredAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['account_id'] = Variable<String>(accountId);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || vaultId != null) {
      map['vault_id'] = Variable<String>(vaultId);
    }
    if (!nullToAbsent || incClass != null) {
      map['inc_class'] = Variable<String>(incClass);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['amount_minor'] = Variable<int>(amountMinor);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['occurred_at'] = Variable<int>(occurredAt);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      type: Value(type),
      accountId: Value(accountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      vaultId: vaultId == null && nullToAbsent
          ? const Value.absent()
          : Value(vaultId),
      incClass: incClass == null && nullToAbsent
          ? const Value.absent()
          : Value(incClass),
      currencyCode: Value(currencyCode),
      amountMinor: Value(amountMinor),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      occurredAt: Value(occurredAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
    );
  }

  factory TransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionRow(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      accountId: serializer.fromJson<String>(json['accountId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      vaultId: serializer.fromJson<String?>(json['vaultId']),
      incClass: serializer.fromJson<String?>(json['incClass']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      note: serializer.fromJson<String?>(json['note']),
      occurredAt: serializer.fromJson<int>(json['occurredAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'accountId': serializer.toJson<String>(accountId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'vaultId': serializer.toJson<String?>(vaultId),
      'incClass': serializer.toJson<String?>(incClass),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'note': serializer.toJson<String?>(note),
      'occurredAt': serializer.toJson<int>(occurredAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'version': serializer.toJson<int>(version),
    };
  }

  TransactionRow copyWith({
    String? id,
    String? type,
    String? accountId,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> vaultId = const Value.absent(),
    Value<String?> incClass = const Value.absent(),
    String? currencyCode,
    int? amountMinor,
    Value<String?> note = const Value.absent(),
    int? occurredAt,
    int? createdAt,
    int? updatedAt,
    Value<int?> deletedAt = const Value.absent(),
    int? version,
  }) => TransactionRow(
    id: id ?? this.id,
    type: type ?? this.type,
    accountId: accountId ?? this.accountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    vaultId: vaultId.present ? vaultId.value : this.vaultId,
    incClass: incClass.present ? incClass.value : this.incClass,
    currencyCode: currencyCode ?? this.currencyCode,
    amountMinor: amountMinor ?? this.amountMinor,
    note: note.present ? note.value : this.note,
    occurredAt: occurredAt ?? this.occurredAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
  );
  TransactionRow copyWithCompanion(TransactionsCompanion data) {
    return TransactionRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      vaultId: data.vaultId.present ? data.vaultId.value : this.vaultId,
      incClass: data.incClass.present ? data.incClass.value : this.incClass,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      note: data.note.present ? data.note.value : this.note,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('vaultId: $vaultId, ')
          ..write('incClass: $incClass, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('note: $note, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    accountId,
    categoryId,
    vaultId,
    incClass,
    currencyCode,
    amountMinor,
    note,
    occurredAt,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.vaultId == this.vaultId &&
          other.incClass == this.incClass &&
          other.currencyCode == this.currencyCode &&
          other.amountMinor == this.amountMinor &&
          other.note == this.note &&
          other.occurredAt == this.occurredAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version);
}

class TransactionsCompanion extends UpdateCompanion<TransactionRow> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> accountId;
  final Value<String?> categoryId;
  final Value<String?> vaultId;
  final Value<String?> incClass;
  final Value<String> currencyCode;
  final Value<int> amountMinor;
  final Value<String?> note;
  final Value<int> occurredAt;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> version;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.vaultId = const Value.absent(),
    this.incClass = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.note = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String type,
    required String accountId,
    this.categoryId = const Value.absent(),
    this.vaultId = const Value.absent(),
    this.incClass = const Value.absent(),
    required String currencyCode,
    required int amountMinor,
    this.note = const Value.absent(),
    required int occurredAt,
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    required int version,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       accountId = Value(accountId),
       currencyCode = Value(currencyCode),
       amountMinor = Value(amountMinor),
       occurredAt = Value(occurredAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       version = Value(version);
  static Insertable<TransactionRow> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<String>? vaultId,
    Expression<String>? incClass,
    Expression<String>? currencyCode,
    Expression<int>? amountMinor,
    Expression<String>? note,
    Expression<int>? occurredAt,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (vaultId != null) 'vault_id': vaultId,
      if (incClass != null) 'inc_class': incClass,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (note != null) 'note': note,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? accountId,
    Value<String?>? categoryId,
    Value<String?>? vaultId,
    Value<String?>? incClass,
    Value<String>? currencyCode,
    Value<int>? amountMinor,
    Value<String?>? note,
    Value<int>? occurredAt,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int?>? deletedAt,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      vaultId: vaultId ?? this.vaultId,
      incClass: incClass ?? this.incClass,
      currencyCode: currencyCode ?? this.currencyCode,
      amountMinor: amountMinor ?? this.amountMinor,
      note: note ?? this.note,
      occurredAt: occurredAt ?? this.occurredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (vaultId.present) {
      map['vault_id'] = Variable<String>(vaultId.value);
    }
    if (incClass.present) {
      map['inc_class'] = Variable<String>(incClass.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<int>(occurredAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('vaultId: $vaultId, ')
          ..write('incClass: $incClass, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('note: $note, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VaultTransfersTable extends VaultTransfers
    with TableInfo<$VaultTransfersTable, VaultTransferRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultTransfersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceVaultIdMeta = const VerificationMeta(
    'sourceVaultId',
  );
  @override
  late final GeneratedColumn<String> sourceVaultId = GeneratedColumn<String>(
    'source_vault_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vaults (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _destinationVaultIdMeta =
      const VerificationMeta('destinationVaultId');
  @override
  late final GeneratedColumn<String> destinationVaultId =
      GeneratedColumn<String>(
        'destination_vault_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES vaults (id) ON DELETE RESTRICT',
        ),
      );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('amount_minor > 0'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<int> occurredAt = GeneratedColumn<int>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceVaultId,
    destinationVaultId,
    currencyCode,
    amountMinor,
    note,
    occurredAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vault_transfers';
  @override
  VerificationContext validateIntegrity(
    Insertable<VaultTransferRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_vault_id')) {
      context.handle(
        _sourceVaultIdMeta,
        sourceVaultId.isAcceptableOrUnknown(
          data['source_vault_id']!,
          _sourceVaultIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceVaultIdMeta);
    }
    if (data.containsKey('destination_vault_id')) {
      context.handle(
        _destinationVaultIdMeta,
        destinationVaultId.isAcceptableOrUnknown(
          data['destination_vault_id']!,
          _destinationVaultIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationVaultIdMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaultTransferRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultTransferRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceVaultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_vault_id'],
      )!,
      destinationVaultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_vault_id'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurred_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VaultTransfersTable createAlias(String alias) {
    return $VaultTransfersTable(attachedDatabase, alias);
  }
}

class VaultTransferRow extends DataClass
    implements Insertable<VaultTransferRow> {
  final String id;
  final String sourceVaultId;
  final String destinationVaultId;
  final String currencyCode;
  final int amountMinor;
  final String? note;
  final int occurredAt;
  final int createdAt;
  const VaultTransferRow({
    required this.id,
    required this.sourceVaultId,
    required this.destinationVaultId,
    required this.currencyCode,
    required this.amountMinor,
    this.note,
    required this.occurredAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_vault_id'] = Variable<String>(sourceVaultId);
    map['destination_vault_id'] = Variable<String>(destinationVaultId);
    map['currency_code'] = Variable<String>(currencyCode);
    map['amount_minor'] = Variable<int>(amountMinor);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['occurred_at'] = Variable<int>(occurredAt);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  VaultTransfersCompanion toCompanion(bool nullToAbsent) {
    return VaultTransfersCompanion(
      id: Value(id),
      sourceVaultId: Value(sourceVaultId),
      destinationVaultId: Value(destinationVaultId),
      currencyCode: Value(currencyCode),
      amountMinor: Value(amountMinor),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      occurredAt: Value(occurredAt),
      createdAt: Value(createdAt),
    );
  }

  factory VaultTransferRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultTransferRow(
      id: serializer.fromJson<String>(json['id']),
      sourceVaultId: serializer.fromJson<String>(json['sourceVaultId']),
      destinationVaultId: serializer.fromJson<String>(
        json['destinationVaultId'],
      ),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      note: serializer.fromJson<String?>(json['note']),
      occurredAt: serializer.fromJson<int>(json['occurredAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceVaultId': serializer.toJson<String>(sourceVaultId),
      'destinationVaultId': serializer.toJson<String>(destinationVaultId),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'note': serializer.toJson<String?>(note),
      'occurredAt': serializer.toJson<int>(occurredAt),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  VaultTransferRow copyWith({
    String? id,
    String? sourceVaultId,
    String? destinationVaultId,
    String? currencyCode,
    int? amountMinor,
    Value<String?> note = const Value.absent(),
    int? occurredAt,
    int? createdAt,
  }) => VaultTransferRow(
    id: id ?? this.id,
    sourceVaultId: sourceVaultId ?? this.sourceVaultId,
    destinationVaultId: destinationVaultId ?? this.destinationVaultId,
    currencyCode: currencyCode ?? this.currencyCode,
    amountMinor: amountMinor ?? this.amountMinor,
    note: note.present ? note.value : this.note,
    occurredAt: occurredAt ?? this.occurredAt,
    createdAt: createdAt ?? this.createdAt,
  );
  VaultTransferRow copyWithCompanion(VaultTransfersCompanion data) {
    return VaultTransferRow(
      id: data.id.present ? data.id.value : this.id,
      sourceVaultId: data.sourceVaultId.present
          ? data.sourceVaultId.value
          : this.sourceVaultId,
      destinationVaultId: data.destinationVaultId.present
          ? data.destinationVaultId.value
          : this.destinationVaultId,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      note: data.note.present ? data.note.value : this.note,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultTransferRow(')
          ..write('id: $id, ')
          ..write('sourceVaultId: $sourceVaultId, ')
          ..write('destinationVaultId: $destinationVaultId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('note: $note, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceVaultId,
    destinationVaultId,
    currencyCode,
    amountMinor,
    note,
    occurredAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultTransferRow &&
          other.id == this.id &&
          other.sourceVaultId == this.sourceVaultId &&
          other.destinationVaultId == this.destinationVaultId &&
          other.currencyCode == this.currencyCode &&
          other.amountMinor == this.amountMinor &&
          other.note == this.note &&
          other.occurredAt == this.occurredAt &&
          other.createdAt == this.createdAt);
}

class VaultTransfersCompanion extends UpdateCompanion<VaultTransferRow> {
  final Value<String> id;
  final Value<String> sourceVaultId;
  final Value<String> destinationVaultId;
  final Value<String> currencyCode;
  final Value<int> amountMinor;
  final Value<String?> note;
  final Value<int> occurredAt;
  final Value<int> createdAt;
  final Value<int> rowid;
  const VaultTransfersCompanion({
    this.id = const Value.absent(),
    this.sourceVaultId = const Value.absent(),
    this.destinationVaultId = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.note = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VaultTransfersCompanion.insert({
    required String id,
    required String sourceVaultId,
    required String destinationVaultId,
    required String currencyCode,
    required int amountMinor,
    this.note = const Value.absent(),
    required int occurredAt,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceVaultId = Value(sourceVaultId),
       destinationVaultId = Value(destinationVaultId),
       currencyCode = Value(currencyCode),
       amountMinor = Value(amountMinor),
       occurredAt = Value(occurredAt),
       createdAt = Value(createdAt);
  static Insertable<VaultTransferRow> custom({
    Expression<String>? id,
    Expression<String>? sourceVaultId,
    Expression<String>? destinationVaultId,
    Expression<String>? currencyCode,
    Expression<int>? amountMinor,
    Expression<String>? note,
    Expression<int>? occurredAt,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceVaultId != null) 'source_vault_id': sourceVaultId,
      if (destinationVaultId != null)
        'destination_vault_id': destinationVaultId,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (note != null) 'note': note,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VaultTransfersCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceVaultId,
    Value<String>? destinationVaultId,
    Value<String>? currencyCode,
    Value<int>? amountMinor,
    Value<String?>? note,
    Value<int>? occurredAt,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return VaultTransfersCompanion(
      id: id ?? this.id,
      sourceVaultId: sourceVaultId ?? this.sourceVaultId,
      destinationVaultId: destinationVaultId ?? this.destinationVaultId,
      currencyCode: currencyCode ?? this.currencyCode,
      amountMinor: amountMinor ?? this.amountMinor,
      note: note ?? this.note,
      occurredAt: occurredAt ?? this.occurredAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceVaultId.present) {
      map['source_vault_id'] = Variable<String>(sourceVaultId.value);
    }
    if (destinationVaultId.present) {
      map['destination_vault_id'] = Variable<String>(destinationVaultId.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<int>(occurredAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultTransfersCompanion(')
          ..write('id: $id, ')
          ..write('sourceVaultId: $sourceVaultId, ')
          ..write('destinationVaultId: $destinationVaultId, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('note: $note, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VaultHistoryTable extends VaultHistory
    with TableInfo<$VaultHistoryTable, VaultHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vaultIdMeta = const VerificationMeta(
    'vaultId',
  );
  @override
  late final GeneratedColumn<String> vaultId = GeneratedColumn<String>(
    'vault_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vaults (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>(
      "event_type IN ('created','edited','archived','restored',"
      "'milestoneReached','goalCompleted','goalReopened')",
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<int> occurredAt = GeneratedColumn<int>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vaultId,
    eventType,
    payload,
    occurredAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vault_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<VaultHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vault_id')) {
      context.handle(
        _vaultIdMeta,
        vaultId.isAcceptableOrUnknown(data['vault_id']!, _vaultIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vaultIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaultHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vaultId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vault_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurred_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VaultHistoryTable createAlias(String alias) {
    return $VaultHistoryTable(attachedDatabase, alias);
  }
}

class VaultHistoryRow extends DataClass implements Insertable<VaultHistoryRow> {
  final String id;
  final String vaultId;
  final String eventType;
  final String? payload;
  final int occurredAt;
  final int createdAt;
  const VaultHistoryRow({
    required this.id,
    required this.vaultId,
    required this.eventType,
    this.payload,
    required this.occurredAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vault_id'] = Variable<String>(vaultId);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    map['occurred_at'] = Variable<int>(occurredAt);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  VaultHistoryCompanion toCompanion(bool nullToAbsent) {
    return VaultHistoryCompanion(
      id: Value(id),
      vaultId: Value(vaultId),
      eventType: Value(eventType),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      occurredAt: Value(occurredAt),
      createdAt: Value(createdAt),
    );
  }

  factory VaultHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultHistoryRow(
      id: serializer.fromJson<String>(json['id']),
      vaultId: serializer.fromJson<String>(json['vaultId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      payload: serializer.fromJson<String?>(json['payload']),
      occurredAt: serializer.fromJson<int>(json['occurredAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vaultId': serializer.toJson<String>(vaultId),
      'eventType': serializer.toJson<String>(eventType),
      'payload': serializer.toJson<String?>(payload),
      'occurredAt': serializer.toJson<int>(occurredAt),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  VaultHistoryRow copyWith({
    String? id,
    String? vaultId,
    String? eventType,
    Value<String?> payload = const Value.absent(),
    int? occurredAt,
    int? createdAt,
  }) => VaultHistoryRow(
    id: id ?? this.id,
    vaultId: vaultId ?? this.vaultId,
    eventType: eventType ?? this.eventType,
    payload: payload.present ? payload.value : this.payload,
    occurredAt: occurredAt ?? this.occurredAt,
    createdAt: createdAt ?? this.createdAt,
  );
  VaultHistoryRow copyWithCompanion(VaultHistoryCompanion data) {
    return VaultHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      vaultId: data.vaultId.present ? data.vaultId.value : this.vaultId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      payload: data.payload.present ? data.payload.value : this.payload,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultHistoryRow(')
          ..write('id: $id, ')
          ..write('vaultId: $vaultId, ')
          ..write('eventType: $eventType, ')
          ..write('payload: $payload, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, vaultId, eventType, payload, occurredAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultHistoryRow &&
          other.id == this.id &&
          other.vaultId == this.vaultId &&
          other.eventType == this.eventType &&
          other.payload == this.payload &&
          other.occurredAt == this.occurredAt &&
          other.createdAt == this.createdAt);
}

class VaultHistoryCompanion extends UpdateCompanion<VaultHistoryRow> {
  final Value<String> id;
  final Value<String> vaultId;
  final Value<String> eventType;
  final Value<String?> payload;
  final Value<int> occurredAt;
  final Value<int> createdAt;
  final Value<int> rowid;
  const VaultHistoryCompanion({
    this.id = const Value.absent(),
    this.vaultId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.payload = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VaultHistoryCompanion.insert({
    required String id,
    required String vaultId,
    required String eventType,
    this.payload = const Value.absent(),
    required int occurredAt,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vaultId = Value(vaultId),
       eventType = Value(eventType),
       occurredAt = Value(occurredAt),
       createdAt = Value(createdAt);
  static Insertable<VaultHistoryRow> custom({
    Expression<String>? id,
    Expression<String>? vaultId,
    Expression<String>? eventType,
    Expression<String>? payload,
    Expression<int>? occurredAt,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vaultId != null) 'vault_id': vaultId,
      if (eventType != null) 'event_type': eventType,
      if (payload != null) 'payload': payload,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VaultHistoryCompanion copyWith({
    Value<String>? id,
    Value<String>? vaultId,
    Value<String>? eventType,
    Value<String?>? payload,
    Value<int>? occurredAt,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return VaultHistoryCompanion(
      id: id ?? this.id,
      vaultId: vaultId ?? this.vaultId,
      eventType: eventType ?? this.eventType,
      payload: payload ?? this.payload,
      occurredAt: occurredAt ?? this.occurredAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vaultId.present) {
      map['vault_id'] = Variable<String>(vaultId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<int>(occurredAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultHistoryCompanion(')
          ..write('id: $id, ')
          ..write('vaultId: $vaultId, ')
          ..write('eventType: $eventType, ')
          ..write('payload: $payload, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $AppSettingsEntriesTable appSettingsEntries =
      $AppSettingsEntriesTable(this);
  late final $AppMetadataEntriesTable appMetadataEntries =
      $AppMetadataEntriesTable(this);
  late final $VaultsTable vaults = $VaultsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $VaultTransfersTable vaultTransfers = $VaultTransfersTable(this);
  late final $VaultHistoryTable vaultHistory = $VaultHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    categories,
    appSettingsEntries,
    appMetadataEntries,
    vaults,
    transactions,
    vaultTransfers,
    vaultHistory,
  ];
}

typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      required String id,
      Value<String?> name,
      Value<String?> normalizedName,
      Value<String?> localizationKey,
      required String type,
      required String currencyCode,
      required int openingBalanceMinor,
      required String iconKey,
      required String colorToken,
      required int sortOrder,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      required int version,
      Value<int> rowid,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String?> normalizedName,
      Value<String?> localizationKey,
      Value<String> type,
      Value<String> currencyCode,
      Value<int> openingBalanceMinor,
      Value<String> iconKey,
      Value<String> colorToken,
      Value<int> sortOrder,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> version,
      Value<int> rowid,
    });

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, AccountRow> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<TransactionRow>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'accounts__id__transactions__account_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get openingBalanceMinor => $composableBuilder(
    column: $table.openingBalanceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          AccountRow,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (AccountRow, $$AccountsTableReferences),
          AccountRow,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> normalizedName = const Value.absent(),
                Value<String?> localizationKey = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> openingBalanceMinor = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<String> colorToken = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                name: name,
                normalizedName: normalizedName,
                localizationKey: localizationKey,
                type: type,
                currencyCode: currencyCode,
                openingBalanceMinor: openingBalanceMinor,
                iconKey: iconKey,
                colorToken: colorToken,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> normalizedName = const Value.absent(),
                Value<String?> localizationKey = const Value.absent(),
                required String type,
                required String currencyCode,
                required int openingBalanceMinor,
                required String iconKey,
                required String colorToken,
                required int sortOrder,
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                name: name,
                normalizedName: normalizedName,
                localizationKey: localizationKey,
                type: type,
                currencyCode: currencyCode,
                openingBalanceMinor: openingBalanceMinor,
                iconKey: iconKey,
                colorToken: colorToken,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      AccountRow,
                      $AccountsTable,
                      TransactionRow
                    >(
                      currentTable: table,
                      referencedTable: $$AccountsTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$AccountsTableReferences(
                        db,
                        table,
                        p0,
                      ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.accountId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      AccountRow,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (AccountRow, $$AccountsTableReferences),
      AccountRow,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      Value<String?> name,
      Value<String?> normalizedName,
      Value<String?> localizationKey,
      required String type,
      Value<String?> incClass,
      required String iconKey,
      required String colorToken,
      required int sortOrder,
      required bool isSystem,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      required int version,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String?> normalizedName,
      Value<String?> localizationKey,
      Value<String> type,
      Value<String?> incClass,
      Value<String> iconKey,
      Value<String> colorToken,
      Value<int> sortOrder,
      Value<bool> isSystem,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> version,
      Value<int> rowid,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, CategoryRow> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<TransactionRow>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'categories__id__transactions__category_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incClass => $composableBuilder(
    column: $table.incClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incClass => $composableBuilder(
    column: $table.incClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get incClass =>
      $composableBuilder(column: $table.incClass, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryRow,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (CategoryRow, $$CategoriesTableReferences),
          CategoryRow,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> normalizedName = const Value.absent(),
                Value<String?> localizationKey = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> incClass = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<String> colorToken = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                normalizedName: normalizedName,
                localizationKey: localizationKey,
                type: type,
                incClass: incClass,
                iconKey: iconKey,
                colorToken: colorToken,
                sortOrder: sortOrder,
                isSystem: isSystem,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> normalizedName = const Value.absent(),
                Value<String?> localizationKey = const Value.absent(),
                required String type,
                Value<String?> incClass = const Value.absent(),
                required String iconKey,
                required String colorToken,
                required int sortOrder,
                required bool isSystem,
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                normalizedName: normalizedName,
                localizationKey: localizationKey,
                type: type,
                incClass: incClass,
                iconKey: iconKey,
                colorToken: colorToken,
                sortOrder: sortOrder,
                isSystem: isSystem,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      CategoryRow,
                      $CategoriesTable,
                      TransactionRow
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryRow,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (CategoryRow, $$CategoriesTableReferences),
      CategoryRow,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$AppSettingsEntriesTableCreateCompanionBuilder =
    AppSettingsEntriesCompanion Function({
      required String id,
      required String baseCurrencyCode,
      Value<String?> locale,
      required String themeMode,
      required bool reducedMotion,
      required int createdAt,
      required int updatedAt,
      required int version,
      Value<int> rowid,
    });
typedef $$AppSettingsEntriesTableUpdateCompanionBuilder =
    AppSettingsEntriesCompanion Function({
      Value<String> id,
      Value<String> baseCurrencyCode,
      Value<String?> locale,
      Value<String> themeMode,
      Value<bool> reducedMotion,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> version,
      Value<int> rowid,
    });

class $$AppSettingsEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsEntriesTable> {
  $$AppSettingsEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrencyCode => $composableBuilder(
    column: $table.baseCurrencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsEntriesTable> {
  $$AppSettingsEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrencyCode => $composableBuilder(
    column: $table.baseCurrencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsEntriesTable> {
  $$AppSettingsEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get baseCurrencyCode => $composableBuilder(
    column: $table.baseCurrencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$AppSettingsEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsEntriesTable,
          AppSettingRow,
          $$AppSettingsEntriesTableFilterComposer,
          $$AppSettingsEntriesTableOrderingComposer,
          $$AppSettingsEntriesTableAnnotationComposer,
          $$AppSettingsEntriesTableCreateCompanionBuilder,
          $$AppSettingsEntriesTableUpdateCompanionBuilder,
          (
            AppSettingRow,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsEntriesTable,
              AppSettingRow
            >,
          ),
          AppSettingRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsEntriesTableTableManager(
    _$AppDatabase db,
    $AppSettingsEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> baseCurrencyCode = const Value.absent(),
                Value<String?> locale = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> reducedMotion = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsEntriesCompanion(
                id: id,
                baseCurrencyCode: baseCurrencyCode,
                locale: locale,
                themeMode: themeMode,
                reducedMotion: reducedMotion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String baseCurrencyCode,
                Value<String?> locale = const Value.absent(),
                required String themeMode,
                required bool reducedMotion,
                required int createdAt,
                required int updatedAt,
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsEntriesCompanion.insert(
                id: id,
                baseCurrencyCode: baseCurrencyCode,
                locale: locale,
                themeMode: themeMode,
                reducedMotion: reducedMotion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsEntriesTable,
      AppSettingRow,
      $$AppSettingsEntriesTableFilterComposer,
      $$AppSettingsEntriesTableOrderingComposer,
      $$AppSettingsEntriesTableAnnotationComposer,
      $$AppSettingsEntriesTableCreateCompanionBuilder,
      $$AppSettingsEntriesTableUpdateCompanionBuilder,
      (
        AppSettingRow,
        BaseReferences<_$AppDatabase, $AppSettingsEntriesTable, AppSettingRow>,
      ),
      AppSettingRow,
      PrefetchHooks Function()
    >;
typedef $$AppMetadataEntriesTableCreateCompanionBuilder =
    AppMetadataEntriesCompanion Function({
      required String key,
      required String value,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$AppMetadataEntriesTableUpdateCompanionBuilder =
    AppMetadataEntriesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$AppMetadataEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetadataEntriesTable> {
  $$AppMetadataEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetadataEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetadataEntriesTable> {
  $$AppMetadataEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetadataEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetadataEntriesTable> {
  $$AppMetadataEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppMetadataEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetadataEntriesTable,
          AppMetadataRow,
          $$AppMetadataEntriesTableFilterComposer,
          $$AppMetadataEntriesTableOrderingComposer,
          $$AppMetadataEntriesTableAnnotationComposer,
          $$AppMetadataEntriesTableCreateCompanionBuilder,
          $$AppMetadataEntriesTableUpdateCompanionBuilder,
          (
            AppMetadataRow,
            BaseReferences<
              _$AppDatabase,
              $AppMetadataEntriesTable,
              AppMetadataRow
            >,
          ),
          AppMetadataRow,
          PrefetchHooks Function()
        > {
  $$AppMetadataEntriesTableTableManager(
    _$AppDatabase db,
    $AppMetadataEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetadataEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetadataEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetadataEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetadataEntriesCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppMetadataEntriesCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetadataEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetadataEntriesTable,
      AppMetadataRow,
      $$AppMetadataEntriesTableFilterComposer,
      $$AppMetadataEntriesTableOrderingComposer,
      $$AppMetadataEntriesTableAnnotationComposer,
      $$AppMetadataEntriesTableCreateCompanionBuilder,
      $$AppMetadataEntriesTableUpdateCompanionBuilder,
      (
        AppMetadataRow,
        BaseReferences<_$AppDatabase, $AppMetadataEntriesTable, AppMetadataRow>,
      ),
      AppMetadataRow,
      PrefetchHooks Function()
    >;
typedef $$VaultsTableCreateCompanionBuilder =
    VaultsCompanion Function({
      required String id,
      Value<String?> name,
      Value<String?> localizationKey,
      Value<String?> description,
      required String iconKey,
      required String colorToken,
      required String currencyCode,
      Value<int?> goalAmountMinor,
      Value<int?> targetDate,
      Value<int> priority,
      required int sortOrder,
      required String withdrawalPolicy,
      Value<bool> isSystem,
      Value<bool> autoContributionEnabled,
      Value<String?> autoContributionKind,
      Value<int?> autoContributionValue,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      required int version,
      Value<int> rowid,
    });
typedef $$VaultsTableUpdateCompanionBuilder =
    VaultsCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String?> localizationKey,
      Value<String?> description,
      Value<String> iconKey,
      Value<String> colorToken,
      Value<String> currencyCode,
      Value<int?> goalAmountMinor,
      Value<int?> targetDate,
      Value<int> priority,
      Value<int> sortOrder,
      Value<String> withdrawalPolicy,
      Value<bool> isSystem,
      Value<bool> autoContributionEnabled,
      Value<String?> autoContributionKind,
      Value<int?> autoContributionValue,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> version,
      Value<int> rowid,
    });

final class $$VaultsTableReferences
    extends BaseReferences<_$AppDatabase, $VaultsTable, VaultRow> {
  $$VaultsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<TransactionRow>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'vaults__id__transactions__vault_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.vaultId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VaultTransfersTable, List<VaultTransferRow>>
  _outgoingTransfersTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vaultTransfers,
    aliasName: 'vaults__id__vault_transfers__source_vault_id',
  );

  $$VaultTransfersTableProcessedTableManager get outgoingTransfers {
    final manager = $$VaultTransfersTableTableManager(
      $_db,
      $_db.vaultTransfers,
    ).filter((f) => f.sourceVaultId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_outgoingTransfersTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VaultTransfersTable, List<VaultTransferRow>>
  _incomingTransfersTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vaultTransfers,
    aliasName: 'vaults__id__vault_transfers__destination_vault_id',
  );

  $$VaultTransfersTableProcessedTableManager get incomingTransfers {
    final manager = $$VaultTransfersTableTableManager($_db, $_db.vaultTransfers)
        .filter(
          (f) => f.destinationVaultId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_incomingTransfersTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VaultHistoryTable, List<VaultHistoryRow>>
  _vaultHistoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vaultHistory,
    aliasName: 'vaults__id__vault_history__vault_id',
  );

  $$VaultHistoryTableProcessedTableManager get vaultHistoryRefs {
    final manager = $$VaultHistoryTableTableManager(
      $_db,
      $_db.vaultHistory,
    ).filter((f) => f.vaultId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vaultHistoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VaultsTableFilterComposer
    extends Composer<_$AppDatabase, $VaultsTable> {
  $$VaultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalAmountMinor => $composableBuilder(
    column: $table.goalAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get withdrawalPolicy => $composableBuilder(
    column: $table.withdrawalPolicy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoContributionEnabled => $composableBuilder(
    column: $table.autoContributionEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get autoContributionKind => $composableBuilder(
    column: $table.autoContributionKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoContributionValue => $composableBuilder(
    column: $table.autoContributionValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.vaultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> outgoingTransfers(
    Expression<bool> Function($$VaultTransfersTableFilterComposer f) f,
  ) {
    final $$VaultTransfersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vaultTransfers,
      getReferencedColumn: (t) => t.sourceVaultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultTransfersTableFilterComposer(
            $db: $db,
            $table: $db.vaultTransfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> incomingTransfers(
    Expression<bool> Function($$VaultTransfersTableFilterComposer f) f,
  ) {
    final $$VaultTransfersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vaultTransfers,
      getReferencedColumn: (t) => t.destinationVaultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultTransfersTableFilterComposer(
            $db: $db,
            $table: $db.vaultTransfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vaultHistoryRefs(
    Expression<bool> Function($$VaultHistoryTableFilterComposer f) f,
  ) {
    final $$VaultHistoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vaultHistory,
      getReferencedColumn: (t) => t.vaultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultHistoryTableFilterComposer(
            $db: $db,
            $table: $db.vaultHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VaultsTableOrderingComposer
    extends Composer<_$AppDatabase, $VaultsTable> {
  $$VaultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalAmountMinor => $composableBuilder(
    column: $table.goalAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get withdrawalPolicy => $composableBuilder(
    column: $table.withdrawalPolicy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoContributionEnabled => $composableBuilder(
    column: $table.autoContributionEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get autoContributionKind => $composableBuilder(
    column: $table.autoContributionKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoContributionValue => $composableBuilder(
    column: $table.autoContributionValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VaultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaultsTable> {
  $$VaultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get localizationKey => $composableBuilder(
    column: $table.localizationKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get colorToken => $composableBuilder(
    column: $table.colorToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goalAmountMinor => $composableBuilder(
    column: $table.goalAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get withdrawalPolicy => $composableBuilder(
    column: $table.withdrawalPolicy,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<bool> get autoContributionEnabled => $composableBuilder(
    column: $table.autoContributionEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get autoContributionKind => $composableBuilder(
    column: $table.autoContributionKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoContributionValue => $composableBuilder(
    column: $table.autoContributionValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.vaultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> outgoingTransfers<T extends Object>(
    Expression<T> Function($$VaultTransfersTableAnnotationComposer a) f,
  ) {
    final $$VaultTransfersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vaultTransfers,
      getReferencedColumn: (t) => t.sourceVaultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultTransfersTableAnnotationComposer(
            $db: $db,
            $table: $db.vaultTransfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> incomingTransfers<T extends Object>(
    Expression<T> Function($$VaultTransfersTableAnnotationComposer a) f,
  ) {
    final $$VaultTransfersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vaultTransfers,
      getReferencedColumn: (t) => t.destinationVaultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultTransfersTableAnnotationComposer(
            $db: $db,
            $table: $db.vaultTransfers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vaultHistoryRefs<T extends Object>(
    Expression<T> Function($$VaultHistoryTableAnnotationComposer a) f,
  ) {
    final $$VaultHistoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vaultHistory,
      getReferencedColumn: (t) => t.vaultId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultHistoryTableAnnotationComposer(
            $db: $db,
            $table: $db.vaultHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VaultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VaultsTable,
          VaultRow,
          $$VaultsTableFilterComposer,
          $$VaultsTableOrderingComposer,
          $$VaultsTableAnnotationComposer,
          $$VaultsTableCreateCompanionBuilder,
          $$VaultsTableUpdateCompanionBuilder,
          (VaultRow, $$VaultsTableReferences),
          VaultRow,
          PrefetchHooks Function({
            bool transactionsRefs,
            bool outgoingTransfers,
            bool incomingTransfers,
            bool vaultHistoryRefs,
          })
        > {
  $$VaultsTableTableManager(_$AppDatabase db, $VaultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> localizationKey = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<String> colorToken = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int?> goalAmountMinor = const Value.absent(),
                Value<int?> targetDate = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> withdrawalPolicy = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<bool> autoContributionEnabled = const Value.absent(),
                Value<String?> autoContributionKind = const Value.absent(),
                Value<int?> autoContributionValue = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VaultsCompanion(
                id: id,
                name: name,
                localizationKey: localizationKey,
                description: description,
                iconKey: iconKey,
                colorToken: colorToken,
                currencyCode: currencyCode,
                goalAmountMinor: goalAmountMinor,
                targetDate: targetDate,
                priority: priority,
                sortOrder: sortOrder,
                withdrawalPolicy: withdrawalPolicy,
                isSystem: isSystem,
                autoContributionEnabled: autoContributionEnabled,
                autoContributionKind: autoContributionKind,
                autoContributionValue: autoContributionValue,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> localizationKey = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String iconKey,
                required String colorToken,
                required String currencyCode,
                Value<int?> goalAmountMinor = const Value.absent(),
                Value<int?> targetDate = const Value.absent(),
                Value<int> priority = const Value.absent(),
                required int sortOrder,
                required String withdrawalPolicy,
                Value<bool> isSystem = const Value.absent(),
                Value<bool> autoContributionEnabled = const Value.absent(),
                Value<String?> autoContributionKind = const Value.absent(),
                Value<int?> autoContributionValue = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => VaultsCompanion.insert(
                id: id,
                name: name,
                localizationKey: localizationKey,
                description: description,
                iconKey: iconKey,
                colorToken: colorToken,
                currencyCode: currencyCode,
                goalAmountMinor: goalAmountMinor,
                targetDate: targetDate,
                priority: priority,
                sortOrder: sortOrder,
                withdrawalPolicy: withdrawalPolicy,
                isSystem: isSystem,
                autoContributionEnabled: autoContributionEnabled,
                autoContributionKind: autoContributionKind,
                autoContributionValue: autoContributionValue,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VaultsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                transactionsRefs = false,
                outgoingTransfers = false,
                incomingTransfers = false,
                vaultHistoryRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsRefs) db.transactions,
                    if (outgoingTransfers) db.vaultTransfers,
                    if (incomingTransfers) db.vaultTransfers,
                    if (vaultHistoryRefs) db.vaultHistory,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsRefs)
                        await $_getPrefetchedData<
                          VaultRow,
                          $VaultsTable,
                          TransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$VaultsTableReferences
                              ._transactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VaultsTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vaultId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (outgoingTransfers)
                        await $_getPrefetchedData<
                          VaultRow,
                          $VaultsTable,
                          VaultTransferRow
                        >(
                          currentTable: table,
                          referencedTable: $$VaultsTableReferences
                              ._outgoingTransfersTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VaultsTableReferences(
                                db,
                                table,
                                p0,
                              ).outgoingTransfers,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceVaultId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (incomingTransfers)
                        await $_getPrefetchedData<
                          VaultRow,
                          $VaultsTable,
                          VaultTransferRow
                        >(
                          currentTable: table,
                          referencedTable: $$VaultsTableReferences
                              ._incomingTransfersTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VaultsTableReferences(
                                db,
                                table,
                                p0,
                              ).incomingTransfers,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.destinationVaultId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vaultHistoryRefs)
                        await $_getPrefetchedData<
                          VaultRow,
                          $VaultsTable,
                          VaultHistoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$VaultsTableReferences
                              ._vaultHistoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VaultsTableReferences(
                                db,
                                table,
                                p0,
                              ).vaultHistoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vaultId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VaultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VaultsTable,
      VaultRow,
      $$VaultsTableFilterComposer,
      $$VaultsTableOrderingComposer,
      $$VaultsTableAnnotationComposer,
      $$VaultsTableCreateCompanionBuilder,
      $$VaultsTableUpdateCompanionBuilder,
      (VaultRow, $$VaultsTableReferences),
      VaultRow,
      PrefetchHooks Function({
        bool transactionsRefs,
        bool outgoingTransfers,
        bool incomingTransfers,
        bool vaultHistoryRefs,
      })
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required String type,
      required String accountId,
      Value<String?> categoryId,
      Value<String?> vaultId,
      Value<String?> incClass,
      required String currencyCode,
      required int amountMinor,
      Value<String?> note,
      required int occurredAt,
      required int createdAt,
      required int updatedAt,
      Value<int?> deletedAt,
      required int version,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> accountId,
      Value<String?> categoryId,
      Value<String?> vaultId,
      Value<String?> incClass,
      Value<String> currencyCode,
      Value<int> amountMinor,
      Value<String?> note,
      Value<int> occurredAt,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int?> deletedAt,
      Value<int> version,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, TransactionRow> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('transactions__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('transactions__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VaultsTable _vaultIdTable(_$AppDatabase db) =>
      db.vaults.createAlias('transactions__vault_id__vaults__id');

  $$VaultsTableProcessedTableManager? get vaultId {
    final $_column = $_itemColumn<String>('vault_id');
    if ($_column == null) return null;
    final manager = $$VaultsTableTableManager(
      $_db,
      $_db.vaults,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vaultIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incClass => $composableBuilder(
    column: $table.incClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VaultsTableFilterComposer get vaultId {
    final $$VaultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableFilterComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incClass => $composableBuilder(
    column: $table.incClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VaultsTableOrderingComposer get vaultId {
    final $$VaultsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableOrderingComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get incClass =>
      $composableBuilder(column: $table.incClass, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VaultsTableAnnotationComposer get vaultId {
    final $$VaultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableAnnotationComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          TransactionRow,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (TransactionRow, $$TransactionsTableReferences),
          TransactionRow,
          PrefetchHooks Function({
            bool accountId,
            bool categoryId,
            bool vaultId,
          })
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> vaultId = const Value.absent(),
                Value<String?> incClass = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> occurredAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                type: type,
                accountId: accountId,
                categoryId: categoryId,
                vaultId: vaultId,
                incClass: incClass,
                currencyCode: currencyCode,
                amountMinor: amountMinor,
                note: note,
                occurredAt: occurredAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String accountId,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> vaultId = const Value.absent(),
                Value<String?> incClass = const Value.absent(),
                required String currencyCode,
                required int amountMinor,
                Value<String?> note = const Value.absent(),
                required int occurredAt,
                required int createdAt,
                required int updatedAt,
                Value<int?> deletedAt = const Value.absent(),
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                type: type,
                accountId: accountId,
                categoryId: categoryId,
                vaultId: vaultId,
                incClass: incClass,
                currencyCode: currencyCode,
                amountMinor: amountMinor,
                note: note,
                occurredAt: occurredAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({accountId = false, categoryId = false, vaultId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (vaultId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.vaultId,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._vaultIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._vaultIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      TransactionRow,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (TransactionRow, $$TransactionsTableReferences),
      TransactionRow,
      PrefetchHooks Function({bool accountId, bool categoryId, bool vaultId})
    >;
typedef $$VaultTransfersTableCreateCompanionBuilder =
    VaultTransfersCompanion Function({
      required String id,
      required String sourceVaultId,
      required String destinationVaultId,
      required String currencyCode,
      required int amountMinor,
      Value<String?> note,
      required int occurredAt,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$VaultTransfersTableUpdateCompanionBuilder =
    VaultTransfersCompanion Function({
      Value<String> id,
      Value<String> sourceVaultId,
      Value<String> destinationVaultId,
      Value<String> currencyCode,
      Value<int> amountMinor,
      Value<String?> note,
      Value<int> occurredAt,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$VaultTransfersTableReferences
    extends
        BaseReferences<_$AppDatabase, $VaultTransfersTable, VaultTransferRow> {
  $$VaultTransfersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VaultsTable _sourceVaultIdTable(_$AppDatabase db) =>
      db.vaults.createAlias('vault_transfers__source_vault_id__vaults__id');

  $$VaultsTableProcessedTableManager get sourceVaultId {
    final $_column = $_itemColumn<String>('source_vault_id')!;

    final manager = $$VaultsTableTableManager(
      $_db,
      $_db.vaults,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceVaultIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VaultsTable _destinationVaultIdTable(_$AppDatabase db) => db.vaults
      .createAlias('vault_transfers__destination_vault_id__vaults__id');

  $$VaultsTableProcessedTableManager get destinationVaultId {
    final $_column = $_itemColumn<String>('destination_vault_id')!;

    final manager = $$VaultsTableTableManager(
      $_db,
      $_db.vaults,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_destinationVaultIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VaultTransfersTableFilterComposer
    extends Composer<_$AppDatabase, $VaultTransfersTable> {
  $$VaultTransfersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VaultsTableFilterComposer get sourceVaultId {
    final $$VaultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceVaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableFilterComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VaultsTableFilterComposer get destinationVaultId {
    final $$VaultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationVaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableFilterComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultTransfersTableOrderingComposer
    extends Composer<_$AppDatabase, $VaultTransfersTable> {
  $$VaultTransfersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VaultsTableOrderingComposer get sourceVaultId {
    final $$VaultsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceVaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableOrderingComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VaultsTableOrderingComposer get destinationVaultId {
    final $$VaultsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationVaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableOrderingComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultTransfersTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaultTransfersTable> {
  $$VaultTransfersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VaultsTableAnnotationComposer get sourceVaultId {
    final $$VaultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceVaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableAnnotationComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VaultsTableAnnotationComposer get destinationVaultId {
    final $$VaultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.destinationVaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableAnnotationComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultTransfersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VaultTransfersTable,
          VaultTransferRow,
          $$VaultTransfersTableFilterComposer,
          $$VaultTransfersTableOrderingComposer,
          $$VaultTransfersTableAnnotationComposer,
          $$VaultTransfersTableCreateCompanionBuilder,
          $$VaultTransfersTableUpdateCompanionBuilder,
          (VaultTransferRow, $$VaultTransfersTableReferences),
          VaultTransferRow,
          PrefetchHooks Function({bool sourceVaultId, bool destinationVaultId})
        > {
  $$VaultTransfersTableTableManager(
    _$AppDatabase db,
    $VaultTransfersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultTransfersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultTransfersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultTransfersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceVaultId = const Value.absent(),
                Value<String> destinationVaultId = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> occurredAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VaultTransfersCompanion(
                id: id,
                sourceVaultId: sourceVaultId,
                destinationVaultId: destinationVaultId,
                currencyCode: currencyCode,
                amountMinor: amountMinor,
                note: note,
                occurredAt: occurredAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceVaultId,
                required String destinationVaultId,
                required String currencyCode,
                required int amountMinor,
                Value<String?> note = const Value.absent(),
                required int occurredAt,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => VaultTransfersCompanion.insert(
                id: id,
                sourceVaultId: sourceVaultId,
                destinationVaultId: destinationVaultId,
                currencyCode: currencyCode,
                amountMinor: amountMinor,
                note: note,
                occurredAt: occurredAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VaultTransfersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sourceVaultId = false, destinationVaultId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sourceVaultId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceVaultId,
                                    referencedTable:
                                        $$VaultTransfersTableReferences
                                            ._sourceVaultIdTable(db),
                                    referencedColumn:
                                        $$VaultTransfersTableReferences
                                            ._sourceVaultIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (destinationVaultId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.destinationVaultId,
                                    referencedTable:
                                        $$VaultTransfersTableReferences
                                            ._destinationVaultIdTable(db),
                                    referencedColumn:
                                        $$VaultTransfersTableReferences
                                            ._destinationVaultIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$VaultTransfersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VaultTransfersTable,
      VaultTransferRow,
      $$VaultTransfersTableFilterComposer,
      $$VaultTransfersTableOrderingComposer,
      $$VaultTransfersTableAnnotationComposer,
      $$VaultTransfersTableCreateCompanionBuilder,
      $$VaultTransfersTableUpdateCompanionBuilder,
      (VaultTransferRow, $$VaultTransfersTableReferences),
      VaultTransferRow,
      PrefetchHooks Function({bool sourceVaultId, bool destinationVaultId})
    >;
typedef $$VaultHistoryTableCreateCompanionBuilder =
    VaultHistoryCompanion Function({
      required String id,
      required String vaultId,
      required String eventType,
      Value<String?> payload,
      required int occurredAt,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$VaultHistoryTableUpdateCompanionBuilder =
    VaultHistoryCompanion Function({
      Value<String> id,
      Value<String> vaultId,
      Value<String> eventType,
      Value<String?> payload,
      Value<int> occurredAt,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$VaultHistoryTableReferences
    extends BaseReferences<_$AppDatabase, $VaultHistoryTable, VaultHistoryRow> {
  $$VaultHistoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VaultsTable _vaultIdTable(_$AppDatabase db) =>
      db.vaults.createAlias('vault_history__vault_id__vaults__id');

  $$VaultsTableProcessedTableManager get vaultId {
    final $_column = $_itemColumn<String>('vault_id')!;

    final manager = $$VaultsTableTableManager(
      $_db,
      $_db.vaults,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vaultIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VaultHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $VaultHistoryTable> {
  $$VaultHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VaultsTableFilterComposer get vaultId {
    final $$VaultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableFilterComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $VaultHistoryTable> {
  $$VaultHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VaultsTableOrderingComposer get vaultId {
    final $$VaultsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableOrderingComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaultHistoryTable> {
  $$VaultHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VaultsTableAnnotationComposer get vaultId {
    final $$VaultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vaultId,
      referencedTable: $db.vaults,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultsTableAnnotationComposer(
            $db: $db,
            $table: $db.vaults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VaultHistoryTable,
          VaultHistoryRow,
          $$VaultHistoryTableFilterComposer,
          $$VaultHistoryTableOrderingComposer,
          $$VaultHistoryTableAnnotationComposer,
          $$VaultHistoryTableCreateCompanionBuilder,
          $$VaultHistoryTableUpdateCompanionBuilder,
          (VaultHistoryRow, $$VaultHistoryTableReferences),
          VaultHistoryRow,
          PrefetchHooks Function({bool vaultId})
        > {
  $$VaultHistoryTableTableManager(_$AppDatabase db, $VaultHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vaultId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<int> occurredAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VaultHistoryCompanion(
                id: id,
                vaultId: vaultId,
                eventType: eventType,
                payload: payload,
                occurredAt: occurredAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vaultId,
                required String eventType,
                Value<String?> payload = const Value.absent(),
                required int occurredAt,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => VaultHistoryCompanion.insert(
                id: id,
                vaultId: vaultId,
                eventType: eventType,
                payload: payload,
                occurredAt: occurredAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VaultHistoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vaultId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vaultId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vaultId,
                                referencedTable: $$VaultHistoryTableReferences
                                    ._vaultIdTable(db),
                                referencedColumn: $$VaultHistoryTableReferences
                                    ._vaultIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VaultHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VaultHistoryTable,
      VaultHistoryRow,
      $$VaultHistoryTableFilterComposer,
      $$VaultHistoryTableOrderingComposer,
      $$VaultHistoryTableAnnotationComposer,
      $$VaultHistoryTableCreateCompanionBuilder,
      $$VaultHistoryTableUpdateCompanionBuilder,
      (VaultHistoryRow, $$VaultHistoryTableReferences),
      VaultHistoryRow,
      PrefetchHooks Function({bool vaultId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$AppSettingsEntriesTableTableManager get appSettingsEntries =>
      $$AppSettingsEntriesTableTableManager(_db, _db.appSettingsEntries);
  $$AppMetadataEntriesTableTableManager get appMetadataEntries =>
      $$AppMetadataEntriesTableTableManager(_db, _db.appMetadataEntries);
  $$VaultsTableTableManager get vaults =>
      $$VaultsTableTableManager(_db, _db.vaults);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$VaultTransfersTableTableManager get vaultTransfers =>
      $$VaultTransfersTableTableManager(_db, _db.vaultTransfers);
  $$VaultHistoryTableTableManager get vaultHistory =>
      $$VaultHistoryTableTableManager(_db, _db.vaultHistory);
}
