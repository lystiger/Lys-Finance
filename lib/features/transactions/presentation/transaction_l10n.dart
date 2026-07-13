import '../../../core/localization/l10n/app_localizations.dart';
import '../../settings/domain/entities/account.dart';
import '../../settings/domain/entities/category.dart';

String accountLabel(AppLocalizations l10n, Account account) =>
    switch (account.localizationKey) {
      'account.cashWallet' => l10n.accountCashWallet,
      'account.bankAccount' => l10n.accountBankAccount,
      _ => account.stableLabel,
    };

String categoryLabel(AppLocalizations l10n, Category category) =>
    switch (category.localizationKey) {
      'category.salary' => l10n.categorySalary,
      'category.freelance' => l10n.categoryFreelance,
      'category.businessIncome' => l10n.categoryBusinessIncome,
      'category.gift' => l10n.categoryGift,
      'category.otherIncome' => l10n.categoryOtherIncome,
      'category.food' => l10n.categoryFood,
      'category.transport' => l10n.categoryTransport,
      'category.shopping' => l10n.categoryShopping,
      'category.aiSubscription' => l10n.categoryAiSubscription,
      'category.health' => l10n.categoryHealth,
      'category.education' => l10n.categoryEducation,
      'category.investment' => l10n.categoryInvestment,
      'category.other' => l10n.categoryOther,
      _ => category.stableLabel,
    };

String incLabel(AppLocalizations l10n, IncClass value) => switch (value) {
  IncClass.investment => l10n.investment,
  IncClass.necessity => l10n.necessity,
  IncClass.consumption => l10n.consumption,
};

String transactionError(AppLocalizations l10n, String? code) => switch (code) {
  'invalid_amount' || 'required' => l10n.invalidAmountError,
  'missing_account' => l10n.missingAccountError,
  'archived_account' => l10n.archivedAccountError,
  'missing_category' => l10n.missingCategoryError,
  'category_kind_mismatch' => l10n.categoryMismatchError,
  'currency_account_mismatch' => l10n.currencyMismatchError,
  'version_conflict' => l10n.versionConflictError,
  'storage_unavailable' => l10n.databaseWriteError,
  _ => l10n.databaseWriteError,
};
