import 'package:characters/characters.dart';

import '../../../../core/domain/app_result.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/money/currency.dart';
import '../../../../core/money/money.dart';

enum VaultWithdrawalPolicy { locked, soft, deadlineLinked }

enum VaultAutoContributionKind { fixed, percentOfIncome }

final class Vault {
  const Vault._({
    required this.id,
    required this.iconKey,
    required this.colorToken,
    required this.currency,
    required this.priority,
    required this.sortOrder,
    required this.withdrawalPolicy,
    required this.isSystem,
    required this.autoContributionEnabled,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.name,
    this.localizationKey,
    this.description,
    this.goalAmount,
    this.targetDate,
    this.autoContributionKind,
    this.autoContributionValue,
    this.deletedAt,
  });

  final String id;
  final String? name;
  final String? localizationKey;
  final String? description;
  final String iconKey;
  final String colorToken;
  final Currency currency;
  final Money? goalAmount;
  final DateTime? targetDate;
  final int priority;
  final int sortOrder;
  final VaultWithdrawalPolicy withdrawalPolicy;
  final bool isSystem;
  final bool autoContributionEnabled;
  final VaultAutoContributionKind? autoContributionKind;
  final int? autoContributionValue;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;

  bool get isArchived => deletedAt != null;
  String get stableLabel => name ?? localizationKey ?? '';

  static AppResult<Vault> create({
    required String id,
    required String iconKey,
    required String colorToken,
    required Currency currency,
    required VaultWithdrawalPolicy withdrawalPolicy,
    required int priority,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int version,
    String? name,
    String? localizationKey,
    String? description,
    Money? goalAmount,
    DateTime? targetDate,
    bool isSystem = false,
    bool autoContributionEnabled = false,
    VaultAutoContributionKind? autoContributionKind,
    int? autoContributionValue,
    DateTime? deletedAt,
  }) {
    if (!RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
    ).hasMatch(id)) {
      return const AppError<Vault>(
        ValidationFailure('Invalid vault identity.', code: 'invalid_id'),
      );
    }
    if ((name == null) == (localizationKey == null)) {
      return const AppError<Vault>(
        ValidationFailure(
          'A vault needs exactly one label source.',
          code: 'invalid_label',
        ),
      );
    }
    final String? normalizedName = _normalizeName(name);
    if (name != null &&
        (normalizedName == null || normalizedName.characters.length > 80)) {
      return const AppError<Vault>(
        ValidationFailure('Enter a valid vault name.', code: 'invalid_name'),
      );
    }
    final String? normalizedDescription = _normalizeText(description);
    if (normalizedDescription != null &&
        normalizedDescription.characters.length > 500) {
      return const AppError<Vault>(
        ValidationFailure('The description is too long.', code: 'too_long'),
      );
    }
    if (goalAmount != null) {
      if (goalAmount.minorUnits <= 0) {
        return const AppError<Vault>(InvalidGoalAmountFailure());
      }
      if (goalAmount.currency != currency) {
        return const AppError<Vault>(CurrencyVaultMismatchFailure());
      }
    }
    if (priority < 0 || sortOrder < 0) {
      return const AppError<Vault>(
        ValidationFailure(
          'Priority and sort order cannot be negative.',
          code: 'out_of_range',
        ),
      );
    }
    final bool autoContributionValid = autoContributionEnabled
        ? (autoContributionKind != null &&
              autoContributionValue != null &&
              autoContributionValue > 0)
        : (autoContributionKind == null && autoContributionValue == null);
    if (!autoContributionValid) {
      return const AppError<Vault>(
        ValidationFailure(
          'Invalid auto-contribution configuration.',
          code: 'invalid_auto_contribution',
        ),
      );
    }
    final DateTime created = createdAt.toUtc();
    final DateTime updated = updatedAt.toUtc();
    if (updated.isBefore(created) || version < 1) {
      return const AppError<Vault>(
        ValidationFailure('Invalid audit state.', code: 'invalid_audit_state'),
      );
    }
    return AppSuccess<Vault>(
      Vault._(
        id: id,
        name: normalizedName,
        localizationKey: localizationKey,
        description: normalizedDescription,
        iconKey: iconKey,
        colorToken: colorToken,
        currency: currency,
        goalAmount: goalAmount,
        targetDate: targetDate?.toUtc(),
        priority: priority,
        sortOrder: sortOrder,
        withdrawalPolicy: withdrawalPolicy,
        isSystem: isSystem,
        autoContributionEnabled: autoContributionEnabled,
        autoContributionKind: autoContributionKind,
        autoContributionValue: autoContributionValue,
        createdAt: created,
        updatedAt: updated,
        deletedAt: deletedAt?.toUtc(),
        version: version,
      ),
    );
  }

  Vault copyWith({
    String? name,
    bool clearName = false,
    String? localizationKey,
    String? description,
    bool clearDescription = false,
    String? iconKey,
    String? colorToken,
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
    DateTime? updatedAt,
    DateTime? deletedAt,
    bool clearDeletedAt = false,
    int? version,
  }) => Vault._(
    id: id,
    name: clearName ? null : name ?? this.name,
    localizationKey: localizationKey ?? this.localizationKey,
    description: clearDescription ? null : description ?? this.description,
    iconKey: iconKey ?? this.iconKey,
    colorToken: colorToken ?? this.colorToken,
    currency: currency,
    goalAmount: clearGoalAmount ? null : goalAmount ?? this.goalAmount,
    targetDate: clearTargetDate ? null : targetDate ?? this.targetDate,
    priority: priority ?? this.priority,
    sortOrder: sortOrder ?? this.sortOrder,
    withdrawalPolicy: withdrawalPolicy ?? this.withdrawalPolicy,
    isSystem: isSystem,
    autoContributionEnabled:
        autoContributionEnabled ?? this.autoContributionEnabled,
    autoContributionKind: clearAutoContributionKind
        ? null
        : autoContributionKind ?? this.autoContributionKind,
    autoContributionValue: clearAutoContributionValue
        ? null
        : autoContributionValue ?? this.autoContributionValue,
    createdAt: createdAt,
    updatedAt: (updatedAt ?? this.updatedAt).toUtc(),
    deletedAt: clearDeletedAt ? null : deletedAt ?? this.deletedAt,
    version: version ?? this.version,
  );

  @override
  bool operator ==(Object other) =>
      other is Vault &&
      id == other.id &&
      name == other.name &&
      localizationKey == other.localizationKey &&
      description == other.description &&
      iconKey == other.iconKey &&
      colorToken == other.colorToken &&
      currency == other.currency &&
      goalAmount == other.goalAmount &&
      targetDate == other.targetDate &&
      priority == other.priority &&
      sortOrder == other.sortOrder &&
      withdrawalPolicy == other.withdrawalPolicy &&
      isSystem == other.isSystem &&
      autoContributionEnabled == other.autoContributionEnabled &&
      autoContributionKind == other.autoContributionKind &&
      autoContributionValue == other.autoContributionValue &&
      createdAt == other.createdAt &&
      updatedAt == other.updatedAt &&
      deletedAt == other.deletedAt &&
      version == other.version;

  @override
  int get hashCode => Object.hashAll(<Object?>[
    id,
    name,
    localizationKey,
    description,
    iconKey,
    colorToken,
    currency,
    goalAmount,
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
  ]);
}

String? _normalizeName(String? value) {
  if (value == null) return null;
  final String normalized = value.trim().replaceAll(RegExp(r'\s+'), ' ');
  return normalized.isEmpty ? null : normalized;
}

String? _normalizeText(String? value) {
  final String normalized = value?.trim() ?? '';
  return normalized.isEmpty ? null : normalized;
}
