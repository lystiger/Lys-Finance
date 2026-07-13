// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Lys Finance';

  @override
  String get home => 'Home';

  @override
  String get vaults => 'Vaults';

  @override
  String get insights => 'Insights';

  @override
  String get assistant => 'Assistant';

  @override
  String get settings => 'Settings';

  @override
  String get quickAdd => 'Quick Add';

  @override
  String get comingLater => 'This feature belongs to a later sprint.';

  @override
  String get foundationReady => 'The foundation is ready.';

  @override
  String get close => 'Close';

  @override
  String get accounts => 'Accounts';

  @override
  String get categories => 'Categories';

  @override
  String get currencies => 'Currencies';

  @override
  String get appearance => 'Appearance';

  @override
  String get notifications => 'Notifications';

  @override
  String get backupExport => 'Backup & export';

  @override
  String get foundationEntryDescription =>
      'Foundation settings for a future sprint.';

  @override
  String get foundationRouteTitle => 'Foundation ready';

  @override
  String get foundationRouteMessage =>
      'This setting is prepared, but its workflow belongs to a later sprint.';

  @override
  String get accountCashWallet => 'Cash Wallet';

  @override
  String get accountBankAccount => 'Bank Account';

  @override
  String get categorySalary => 'Salary';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryAiSubscription => 'AI subscription';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryInvestment => 'Investment';

  @override
  String get categoryOther => 'Other';

  @override
  String get categoryFreelance => 'Freelance';

  @override
  String get categoryBusinessIncome => 'Business income';

  @override
  String get categoryGift => 'Gift';

  @override
  String get categoryOtherIncome => 'Other income';

  @override
  String get transactions => 'Transactions';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';

  @override
  String get amount => 'Amount';

  @override
  String get account => 'Account';

  @override
  String get category => 'Category';

  @override
  String get incomeSource => 'Income source';

  @override
  String get investment => 'Investment';

  @override
  String get necessity => 'Necessity';

  @override
  String get consumption => 'Consumption';

  @override
  String get note => 'Note';

  @override
  String get optionalNote => 'Optional note';

  @override
  String get date => 'Date';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get restore => 'Restore';

  @override
  String get undo => 'Undo';

  @override
  String get cancel => 'Cancel';

  @override
  String get search => 'Search transactions';

  @override
  String get filters => 'Filters';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get loadMore => 'Load more';

  @override
  String get all => 'All';

  @override
  String get recentlyDeleted => 'Recently deleted';

  @override
  String get emptyLedgerTitle => 'No transactions yet';

  @override
  String get emptyLedgerMessage =>
      'Record an expense or income to begin your ledger.';

  @override
  String get addTransaction => 'Add transaction';

  @override
  String get transactionDetails => 'Transaction details';

  @override
  String get deleteTransactionTitle => 'Delete transaction?';

  @override
  String get deleteTransactionMessage =>
      'It will leave your ledger and can be restored later.';

  @override
  String get transactionDeleted => 'Transaction deleted.';

  @override
  String get transactionRestored => 'Transaction restored.';

  @override
  String get invalidAmountError => 'Enter an amount greater than zero.';

  @override
  String get missingAccountError => 'Choose an account to continue.';

  @override
  String get archivedAccountError =>
      'This account is archived. Choose another.';

  @override
  String get missingCategoryError => 'Choose a category to continue.';

  @override
  String get categoryMismatchError =>
      'That category does not match this transaction type.';

  @override
  String get currencyMismatchError => 'This account uses a different currency.';

  @override
  String get versionConflictError =>
      'This transaction changed elsewhere. Reload and try again.';

  @override
  String get databaseWriteError => 'Could not save. Please try again.';

  @override
  String get databaseReadError =>
      'Could not load your transactions. Please try again.';

  @override
  String get unableToLoad => 'Unable to load';

  @override
  String get loadingTransactions => 'Loading transactions';

  @override
  String get selectAccount => 'Select account';

  @override
  String get selectCategory => 'Select category';

  @override
  String get today => 'Today';

  @override
  String get vaultEmergencyFund => 'Emergency Fund';

  @override
  String get vaultJapanMasters => 'Japan Master\'s';

  @override
  String get vaultAiInfrastructure => 'AI Infrastructure';

  @override
  String get vaultElysia => 'Elysia';

  @override
  String get vaultGpuUpgrade => 'GPU Upgrade';

  @override
  String get vaultInvestment => 'Investment';

  @override
  String get vaultFreedomFund => 'Freedom Fund';

  @override
  String get vaultVacation => 'Vacation';

  @override
  String get newVault => 'New vault';

  @override
  String get editVault => 'Edit vault';

  @override
  String get vaultName => 'Vault name';

  @override
  String get vaultDescription => 'Description';

  @override
  String get optionalDescription => 'Optional description';

  @override
  String get goalAmount => 'Goal amount';

  @override
  String get optionalGoalAmount => 'Optional goal amount';

  @override
  String get targetDate => 'Target date';

  @override
  String get optionalTargetDate => 'Optional target date';

  @override
  String get withdrawalPolicy => 'Withdrawal policy';

  @override
  String get withdrawalPolicyLocked => 'Locked';

  @override
  String get withdrawalPolicySoft => 'Soft';

  @override
  String get withdrawalPolicyDeadlineLinked => 'Deadline-linked';

  @override
  String get archiveVault => 'Archive vault';

  @override
  String get archiveVaultTitle => 'Archive this vault?';

  @override
  String get archiveVaultMessage =>
      'It leaves your active vaults and can be restored later.';

  @override
  String get restoreVault => 'Restore vault';

  @override
  String get vaultArchived => 'Vault archived.';

  @override
  String get vaultRestored => 'Vault restored.';

  @override
  String get activeVaults => 'Active vaults';

  @override
  String get seeAllVaults => 'See all';

  @override
  String get emptyVaultsTitle => 'No vaults yet';

  @override
  String get emptyVaultsMessage =>
      'Create a vault to start saving toward something.';

  @override
  String get createVault => 'Create vault';

  @override
  String get contribute => 'Contribute';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get transfer => 'Transfer';

  @override
  String get contributeToVault => 'Contribute to vault';

  @override
  String get withdrawFromVault => 'Withdraw from vault';

  @override
  String get transferBetweenVaults => 'Transfer between vaults';

  @override
  String get sourceVault => 'From vault';

  @override
  String get destinationVault => 'To vault';

  @override
  String get reason => 'Reason';

  @override
  String get optionalReason => 'Optional reason';

  @override
  String get reasonRequired => 'Reason (required for a locked vault)';

  @override
  String get currentBalance => 'Current balance';

  @override
  String get remainingAmount => 'Remaining';

  @override
  String get monthlyAverage => 'Monthly average';

  @override
  String get estimatedCompletion => 'Estimated completion';

  @override
  String get noGoalSet => 'No goal set';

  @override
  String get notEnoughData => 'Not enough data yet';

  @override
  String get goalCompletedLabel => 'Completed';

  @override
  String get goalOnTrack => 'On track';

  @override
  String get goalBehind => 'Behind';

  @override
  String get goalAtRisk => 'At risk';

  @override
  String get goalNoTarget => 'No target';

  @override
  String get goalNoData => 'No data';

  @override
  String get vaultHistory => 'Vault history';

  @override
  String get emptyVaultHistoryTitle => 'No activity yet';

  @override
  String get emptyVaultHistoryMessage =>
      'Contributions, withdrawals, and transfers will appear here.';

  @override
  String get historyContribution => 'Contribution';

  @override
  String get historyWithdrawal => 'Withdrawal';

  @override
  String get historyTransferIn => 'Transfer in';

  @override
  String get historyTransferOut => 'Transfer out';

  @override
  String get historyCreated => 'Vault created';

  @override
  String get historyEdited => 'Vault edited';

  @override
  String get historyArchived => 'Vault archived';

  @override
  String get historyRestored => 'Vault restored';

  @override
  String historyMilestone(String percent) {
    return 'Reached $percent%';
  }

  @override
  String get historyGoalCompleted => 'Goal completed';

  @override
  String get historyGoalReopened => 'Goal reopened';

  @override
  String get vaultCompletedCelebrationTitle => 'Goal complete!';

  @override
  String vaultCompletedCelebrationMessage(String vaultName) {
    return '$vaultName reached its goal.';
  }

  @override
  String get invalidGoalAmountError => 'Enter a goal amount greater than zero.';

  @override
  String get missingVaultError => 'Choose a vault to continue.';

  @override
  String get archivedVaultError => 'This vault is archived. Choose another.';

  @override
  String get currencyVaultMismatchError =>
      'This vault uses a different currency.';

  @override
  String get vaultCurrencyMismatchError =>
      'Both vaults must use the same currency.';

  @override
  String get sameVaultTransferError =>
      'Choose two different vaults to transfer between.';

  @override
  String get insufficientVaultBalanceError =>
      'This vault does not have enough balance for that amount.';

  @override
  String get withdrawalReasonRequiredError =>
      'This vault is locked. Add a reason to continue.';

  @override
  String get vaultCurrencyLockedError =>
      'This vault already has contributions and cannot change currency.';
}
