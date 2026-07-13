import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/validation/validation.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

final class DriftCategoryRepository implements CategoryRepository {
  const DriftCategoryRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<Category>> watchActive({CategoryType? type, IncClass? incClass}) {
    final SimpleSelectStatement<$CategoriesTable, CategoryRow> query =
        _database.select(_database.categories)
          ..where(($CategoriesTable table) => table.deletedAt.isNull())
          ..orderBy(<OrderingTerm Function($CategoriesTable)>[
            ($CategoriesTable table) => OrderingTerm.asc(table.sortOrder),
            ($CategoriesTable table) => OrderingTerm.asc(table.localizationKey),
            ($CategoriesTable table) => OrderingTerm.asc(table.normalizedName),
          ]);
    if (type != null) {
      query.where(($CategoriesTable table) => table.type.equals(type.name));
    }
    if (incClass != null) {
      query.where(
        ($CategoriesTable table) => table.incClass.equals(incClass.name),
      );
    }
    return query.watch().map(
      (List<CategoryRow> rows) =>
          List<Category>.unmodifiable(rows.map(_categoryFromRow)),
    );
  }

  @override
  Future<AppResult<Category>> getById(
    String id, {
    bool includeDeleted = false,
  }) async {
    try {
      final SimpleSelectStatement<$CategoriesTable, CategoryRow> query =
          _database.select(_database.categories)
            ..where(($CategoriesTable table) => table.id.equals(id));
      if (!includeDeleted) {
        query.where(($CategoriesTable table) => table.deletedAt.isNull());
      }
      final CategoryRow? row = await query.getSingleOrNull();
      return row == null
          ? const AppError<Category>(NotFoundFailure())
          : AppSuccess<Category>(_categoryFromRow(row));
    } on Object catch (error) {
      return AppError<Category>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<Category>> create(Category category) async {
    try {
      await _database.into(_database.categories).insert(_companion(category));
      return AppSuccess<Category>(category);
    } on SqliteException catch (error) {
      return error.message.contains('UNIQUE')
          ? const AppError<Category>(DuplicateFailure())
          : AppError<Category>(StorageFailure(cause: error));
    } on Object catch (error) {
      return AppError<Category>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<Category>> update(
    Category category, {
    required int expectedVersion,
  }) async {
    try {
      final Category updated = category.copyWith(version: expectedVersion + 1);
      final int count =
          await (_database.update(_database.categories)..where(
                ($CategoriesTable table) =>
                    table.id.equals(category.id) &
                    table.version.equals(expectedVersion) &
                    table.deletedAt.isNull(),
              ))
              .write(_companion(updated));
      return count == 0
          ? const AppError<Category>(VersionConflictFailure())
          : AppSuccess<Category>(updated);
    } on SqliteException catch (error) {
      return error.message.contains('UNIQUE')
          ? const AppError<Category>(DuplicateFailure())
          : AppError<Category>(StorageFailure(cause: error));
    } on Object catch (error) {
      return AppError<Category>(StorageFailure(cause: error));
    }
  }

  @override
  Future<AppResult<void>> softDelete(
    String id, {
    required int expectedVersion,
    required DateTime deletedAt,
  }) async {
    try {
      final int timestamp = deletedAt.toUtc().microsecondsSinceEpoch;
      final int count =
          await (_database.update(_database.categories)..where(
                ($CategoriesTable table) =>
                    table.id.equals(id) &
                    table.version.equals(expectedVersion) &
                    table.deletedAt.isNull(),
              ))
              .write(
                CategoriesCompanion(
                  deletedAt: Value<int>(timestamp),
                  updatedAt: Value<int>(timestamp),
                  version: Value<int>(expectedVersion + 1),
                ),
              );
      return count == 0
          ? const AppError<void>(VersionConflictFailure())
          : const AppSuccess<void>(null);
    } on Object catch (error) {
      return AppError<void>(StorageFailure(cause: error));
    }
  }

  @override
  Future<bool> activeNameExists(
    String name,
    CategoryType type, {
    String? excludingId,
  }) async {
    final String key = ValidationService.duplicateKey(name);
    final SimpleSelectStatement<$CategoriesTable, CategoryRow> query =
        _database.select(_database.categories)..where(
          ($CategoriesTable table) =>
              table.type.equals(type.name) &
              table.normalizedName.equals(key) &
              table.deletedAt.isNull(),
        );
    if (excludingId != null) {
      query.where(
        ($CategoriesTable table) => table.id.equals(excludingId).not(),
      );
    }
    return await query.getSingleOrNull() != null;
  }

  CategoriesCompanion _companion(Category category) {
    return CategoriesCompanion(
      id: Value<String>(category.id),
      name: Value<String?>(category.name),
      normalizedName: Value<String?>(
        category.name == null
            ? null
            : ValidationService.duplicateKey(category.name!),
      ),
      localizationKey: Value<String?>(category.localizationKey),
      type: Value<String>(category.type.name),
      incClass: Value<String?>(category.incClass?.name),
      iconKey: Value<String>(category.iconKey),
      colorToken: Value<String>(category.colorToken),
      sortOrder: Value<int>(category.sortOrder),
      isSystem: Value<bool>(category.isSystem),
      createdAt: Value<int>(category.createdAt.toUtc().microsecondsSinceEpoch),
      updatedAt: Value<int>(category.updatedAt.toUtc().microsecondsSinceEpoch),
      deletedAt: Value<int?>(
        category.deletedAt?.toUtc().microsecondsSinceEpoch,
      ),
      version: Value<int>(category.version),
    );
  }

  Category _categoryFromRow(CategoryRow row) {
    return Category(
      id: row.id,
      name: row.name,
      localizationKey: row.localizationKey,
      type: CategoryType.values.byName(row.type),
      incClass: row.incClass == null
          ? null
          : IncClass.values.byName(row.incClass!),
      iconKey: row.iconKey,
      colorToken: row.colorToken,
      sortOrder: row.sortOrder,
      isSystem: row.isSystem,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(
        row.createdAt,
        isUtc: true,
      ),
      updatedAt: DateTime.fromMicrosecondsSinceEpoch(
        row.updatedAt,
        isUtc: true,
      ),
      deletedAt: row.deletedAt == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(row.deletedAt!, isUtc: true),
      version: row.version,
    );
  }
}
