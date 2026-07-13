import '../../../../core/money/money.dart';

enum AccountType { cash, bank, eWallet }

final class Account {
  const Account({
    required this.id,
    required this.type,
    required this.openingBalance,
    required this.iconKey,
    required this.colorToken,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.name,
    this.localizationKey,
    this.deletedAt,
  }) : assert((name == null) != (localizationKey == null));

  final String id;
  final String? name;
  final String? localizationKey;
  final AccountType type;
  final Money openingBalance;
  final String iconKey;
  final String colorToken;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;

  String get currencyCode => openingBalance.currency.code;
  bool get isDeleted => deletedAt != null;
  String get stableLabel => name ?? localizationKey ?? '';

  Account copyWith({
    String? name,
    String? localizationKey,
    AccountType? type,
    Money? openingBalance,
    String? iconKey,
    String? colorToken,
    int? sortOrder,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
    int? version,
  }) {
    return Account(
      id: id,
      name: name ?? this.name,
      localizationKey: localizationKey ?? this.localizationKey,
      type: type ?? this.type,
      openingBalance: openingBalance ?? this.openingBalance,
      iconKey: iconKey ?? this.iconKey,
      colorToken: colorToken ?? this.colorToken,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: clearDeletedAt ? null : deletedAt ?? this.deletedAt,
      version: version ?? this.version,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Account &&
      id == other.id &&
      name == other.name &&
      localizationKey == other.localizationKey &&
      type == other.type &&
      openingBalance == other.openingBalance &&
      iconKey == other.iconKey &&
      colorToken == other.colorToken &&
      sortOrder == other.sortOrder &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt &&
      deletedAt == other.deletedAt &&
      version == other.version;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    localizationKey,
    type,
    openingBalance,
    iconKey,
    colorToken,
    sortOrder,
    createdAt,
    updatedAt,
    deletedAt,
    version,
  );
}
