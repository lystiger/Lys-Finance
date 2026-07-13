enum CategoryType { income, expense }

enum IncClass { investment, necessity, consumption }

final class Category {
  const Category({
    required this.id,
    required this.type,
    required this.iconKey,
    required this.colorToken,
    required this.sortOrder,
    required this.isSystem,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.name,
    this.localizationKey,
    this.incClass,
    this.deletedAt,
  }) : assert((name == null) != (localizationKey == null)),
       assert(
         (type == CategoryType.expense && incClass != null) ||
             (type == CategoryType.income && incClass == null),
       );

  final String id;
  final String? name;
  final String? localizationKey;
  final CategoryType type;
  final IncClass? incClass;
  final String iconKey;
  final String colorToken;
  final int sortOrder;
  final bool isSystem;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;

  bool get isDeleted => deletedAt != null;
  String get stableLabel => name ?? localizationKey ?? '';

  Category copyWith({
    String? name,
    String? localizationKey,
    CategoryType? type,
    IncClass? incClass,
    bool clearIncClass = false,
    String? iconKey,
    String? colorToken,
    int? sortOrder,
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
    int? version,
  }) {
    return Category(
      id: id,
      name: name ?? this.name,
      localizationKey: localizationKey ?? this.localizationKey,
      type: type ?? this.type,
      incClass: clearIncClass ? null : incClass ?? this.incClass,
      iconKey: iconKey ?? this.iconKey,
      colorToken: colorToken ?? this.colorToken,
      sortOrder: sortOrder ?? this.sortOrder,
      isSystem: isSystem,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: clearDeletedAt ? null : deletedAt ?? this.deletedAt,
      version: version ?? this.version,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Category &&
      id == other.id &&
      name == other.name &&
      localizationKey == other.localizationKey &&
      type == other.type &&
      incClass == other.incClass &&
      iconKey == other.iconKey &&
      colorToken == other.colorToken &&
      sortOrder == other.sortOrder &&
      isSystem == other.isSystem &&
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
}
