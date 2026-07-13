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
}
