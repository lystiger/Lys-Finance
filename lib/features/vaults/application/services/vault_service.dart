import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/identifiers/uuid_generator.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';
import '../../../../core/time/app_clock.dart';
import '../../domain/entities/vault.dart';
import '../../domain/entities/vault_history_event.dart';
import '../../domain/repositories/vault_history_repository.dart';
import '../../domain/repositories/vault_repository.dart';

final class VaultService {
  const VaultService({
    required this.vaults,
    required this.history,
    required this.uuid,
    required this.clock,
  });

  static const Set<String> iconKeys = <String>{
    'shield',
    'school',
    'dns',
    'auto_awesome',
    'memory',
    'trending_up',
    'flight_takeoff',
    'beach_access',
    'savings',
    'flag',
    'star',
    'home_work',
    'directions_car',
    'favorite',
    'celebration',
    'more_horiz',
  };

  static const Set<String> colorTokens = <String>{
    'primary',
    'investment',
    'necessity',
    'consumption',
    'income',
    'category1',
    'category2',
    'category3',
    'category4',
    'category5',
    'category6',
    'category7',
    'category8',
  };

  final VaultRepository vaults;
  final VaultHistoryRepository history;
  final UuidGenerator uuid;
  final AppClock clock;

  Future<AppResult<Vault>> create({
    required String name,
    required String iconKey,
    required String colorToken,
    required Currency currency,
    required VaultWithdrawalPolicy withdrawalPolicy,
    required int sortOrder,
    String? description,
    Money? goalAmount,
    DateTime? targetDate,
    int priority = 0,
    bool autoContributionEnabled = false,
    VaultAutoContributionKind? autoContributionKind,
    int? autoContributionValue,
  }) async {
    final AppFailure? catalogFailure = _validateCatalog(iconKey, colorToken);
    if (catalogFailure != null) return AppError<Vault>(catalogFailure);
    final DateTime now = clock.now().toUtc();
    final AppResult<Vault> vault = Vault.create(
      id: uuid.v4(),
      name: name,
      iconKey: iconKey,
      colorToken: colorToken,
      currency: currency,
      goalAmount: goalAmount,
      targetDate: targetDate,
      priority: priority,
      sortOrder: sortOrder,
      withdrawalPolicy: withdrawalPolicy,
      description: description,
      autoContributionEnabled: autoContributionEnabled,
      autoContributionKind: autoContributionKind,
      autoContributionValue: autoContributionValue,
      createdAt: now,
      updatedAt: now,
      version: 1,
    );
    if (vault case AppError<Vault>()) return vault;
    final Vault created = (vault as AppSuccess<Vault>).value;
    final AppResult<Vault> result = await vaults.create(created);
    if (result case AppSuccess<Vault>()) {
      await history.append(
        VaultHistoryEvent(
          id: uuid.v4(),
          vaultId: created.id,
          eventType: VaultHistoryEventType.created,
          occurredAt: now,
          createdAt: now,
        ),
      );
    }
    return result;
  }

  Future<AppResult<Vault>> update({
    required Vault original,
    String? name,
    String? description,
    bool clearDescription = false,
    String? iconKey,
    String? colorToken,
    Currency? currency,
    Money? goalAmount,
    bool clearGoalAmount = false,
    DateTime? targetDate,
    bool clearTargetDate = false,
    int? priority,
    int? sortOrder,
    VaultWithdrawalPolicy? withdrawalPolicy,
    bool? autoContributionEnabled,
    VaultAutoContributionKind? autoContributionKind,
    bool clearAutoContributionKind = false,
    int? autoContributionValue,
    bool clearAutoContributionValue = false,
  }) async {
    if (original.isArchived) {
      return const AppError<Vault>(ArchivedVaultFailure());
    }
    final String effectiveIconKey = iconKey ?? original.iconKey;
    final String effectiveColorToken = colorToken ?? original.colorToken;
    final AppFailure? catalogFailure = _validateCatalog(
      effectiveIconKey,
      effectiveColorToken,
    );
    if (catalogFailure != null) return AppError<Vault>(catalogFailure);
    if (currency != null && currency != original.currency) {
      if (await vaults.hasActivity(original.id)) {
        return const AppError<Vault>(VaultCurrencyLockedFailure());
      }
    }
    final DateTime now = clock.now().toUtc();
    // A vault's label is exactly one of name or localizationKey (never
    // both). Setting a custom name on a system vault therefore permanently
    // gives up its localizationKey — the rename sticks across a locale
    // switch precisely because there is no localization key left to
    // re-resolve from, not because both fields coexist.
    final bool renaming = name != null && name != original.name;
    final AppResult<Vault> rebuilt = Vault.create(
      id: original.id,
      name: renaming ? name : original.name,
      localizationKey: renaming ? null : original.localizationKey,
      description: clearDescription
          ? null
          : description ?? original.description,
      iconKey: effectiveIconKey,
      colorToken: effectiveColorToken,
      currency: currency ?? original.currency,
      goalAmount: clearGoalAmount ? null : goalAmount ?? original.goalAmount,
      targetDate: clearTargetDate ? null : targetDate ?? original.targetDate,
      priority: priority ?? original.priority,
      sortOrder: sortOrder ?? original.sortOrder,
      withdrawalPolicy: withdrawalPolicy ?? original.withdrawalPolicy,
      isSystem: original.isSystem,
      autoContributionEnabled:
          autoContributionEnabled ?? original.autoContributionEnabled,
      autoContributionKind: clearAutoContributionKind
          ? null
          : autoContributionKind ?? original.autoContributionKind,
      autoContributionValue: clearAutoContributionValue
          ? null
          : autoContributionValue ?? original.autoContributionValue,
      createdAt: original.createdAt,
      updatedAt: now,
      version: original.version,
    );
    if (rebuilt case AppError<Vault>()) return rebuilt;
    final Vault changed = (rebuilt as AppSuccess<Vault>).value;
    final AppResult<Vault> result = await vaults.update(
      changed,
      expectedVersion: original.version,
    );
    if (result case AppSuccess<Vault>()) {
      await history.append(
        VaultHistoryEvent(
          id: uuid.v4(),
          vaultId: original.id,
          eventType: VaultHistoryEventType.edited,
          occurredAt: now,
          createdAt: now,
        ),
      );
    }
    return result;
  }

  Future<AppResult<void>> archive(Vault vault) async {
    final DateTime now = clock.now().toUtc();
    final AppResult<void> result = await vaults.archive(
      vault.id,
      expectedVersion: vault.version,
      archivedAt: now,
    );
    if (result case AppSuccess<void>()) {
      await history.append(
        VaultHistoryEvent(
          id: uuid.v4(),
          vaultId: vault.id,
          eventType: VaultHistoryEventType.archived,
          occurredAt: now,
          createdAt: now,
        ),
      );
    }
    return result;
  }

  Future<AppResult<void>> restore(Vault vault) async {
    final DateTime now = clock.now().toUtc();
    final AppResult<void> result = await vaults.restore(
      vault.id,
      expectedVersion: vault.version,
      restoredAt: now,
    );
    if (result case AppSuccess<void>()) {
      await history.append(
        VaultHistoryEvent(
          id: uuid.v4(),
          vaultId: vault.id,
          eventType: VaultHistoryEventType.restored,
          occurredAt: now,
          createdAt: now,
        ),
      );
    }
    return result;
  }

  AppFailure? _validateCatalog(String iconKey, String colorToken) {
    if (!iconKeys.contains(iconKey) || !colorTokens.contains(colorToken)) {
      return const ValidationFailure(
        'Choose a valid icon and color.',
        code: 'invalid_key',
      );
    }
    return null;
  }
}
