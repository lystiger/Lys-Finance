import '../../../../core/domain/app_result.dart';
import '../entities/category.dart';

abstract interface class CategoryRepository {
  Stream<List<Category>> watchActive({CategoryType? type, IncClass? incClass});
  Future<AppResult<Category>> getById(String id, {bool includeDeleted = false});
  Future<AppResult<Category>> create(Category category);
  Future<AppResult<Category>> update(
    Category category, {
    required int expectedVersion,
  });
  Future<AppResult<void>> softDelete(
    String id, {
    required int expectedVersion,
    required DateTime deletedAt,
  });
  Future<bool> activeNameExists(
    String name,
    CategoryType type, {
    String? excludingId,
  });
}
