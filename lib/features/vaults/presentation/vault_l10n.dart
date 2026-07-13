import '../../../core/localization/l10n/app_localizations.dart';
import '../domain/entities/vault.dart';
import '../domain/entities/vault_goal_snapshot.dart';
import '../domain/entities/vault_history_entry.dart';
import '../domain/entities/vault_history_event.dart';

String vaultLabel(AppLocalizations l10n, Vault vault) =>
    switch (vault.localizationKey) {
      'vault.emergencyFund' => l10n.vaultEmergencyFund,
      'vault.japanMasters' => l10n.vaultJapanMasters,
      'vault.aiInfrastructure' => l10n.vaultAiInfrastructure,
      'vault.elysia' => l10n.vaultElysia,
      'vault.gpuUpgrade' => l10n.vaultGpuUpgrade,
      'vault.investment' => l10n.vaultInvestment,
      'vault.freedomFund' => l10n.vaultFreedomFund,
      'vault.vacation' => l10n.vaultVacation,
      _ => vault.stableLabel,
    };

String withdrawalPolicyLabel(
  AppLocalizations l10n,
  VaultWithdrawalPolicy value,
) => switch (value) {
  VaultWithdrawalPolicy.locked => l10n.withdrawalPolicyLocked,
  VaultWithdrawalPolicy.soft => l10n.withdrawalPolicySoft,
  VaultWithdrawalPolicy.deadlineLinked => l10n.withdrawalPolicyDeadlineLinked,
};

String goalHealthLabel(AppLocalizations l10n, GoalHealth value) =>
    switch (value) {
      GoalHealth.completed => l10n.goalCompletedLabel,
      GoalHealth.noTarget => l10n.goalNoTarget,
      GoalHealth.noData => l10n.goalNoData,
      GoalHealth.onTrack => l10n.goalOnTrack,
      GoalHealth.behind => l10n.goalBehind,
      GoalHealth.atRisk => l10n.goalAtRisk,
    };

String vaultHistoryEventLabel(
  AppLocalizations l10n,
  VaultHistoryEventType type, {
  String? payload,
}) => switch (type) {
  VaultHistoryEventType.created => l10n.historyCreated,
  VaultHistoryEventType.edited => l10n.historyEdited,
  VaultHistoryEventType.archived => l10n.historyArchived,
  VaultHistoryEventType.restored => l10n.historyRestored,
  VaultHistoryEventType.milestoneReached => l10n.historyMilestone(
    payload ?? '',
  ),
  VaultHistoryEventType.goalCompleted => l10n.historyGoalCompleted,
  VaultHistoryEventType.goalReopened => l10n.historyGoalReopened,
};

String vaultTransferDirectionLabel(
  AppLocalizations l10n,
  VaultTransferDirection direction,
) => switch (direction) {
  VaultTransferDirection.incoming => l10n.historyTransferIn,
  VaultTransferDirection.outgoing => l10n.historyTransferOut,
};

String vaultError(AppLocalizations l10n, String? code) => switch (code) {
  'invalid_amount' || 'required' => l10n.invalidAmountError,
  'invalid_goal_amount' => l10n.invalidGoalAmountError,
  'missing_vault' => l10n.missingVaultError,
  'archived_vault' => l10n.archivedVaultError,
  'missing_account' => l10n.missingAccountError,
  'archived_account' => l10n.archivedAccountError,
  'currency_account_mismatch' => l10n.currencyMismatchError,
  'currency_vault_mismatch' => l10n.currencyVaultMismatchError,
  'vault_currency_mismatch' => l10n.vaultCurrencyMismatchError,
  'same_vault_transfer' => l10n.sameVaultTransferError,
  'insufficient_vault_balance' => l10n.insufficientVaultBalanceError,
  'withdrawal_reason_required' => l10n.withdrawalReasonRequiredError,
  'vault_currency_locked' => l10n.vaultCurrencyLockedError,
  'version_conflict' => l10n.versionConflictError,
  'storage_unavailable' => l10n.databaseWriteError,
  _ => l10n.databaseWriteError,
};
