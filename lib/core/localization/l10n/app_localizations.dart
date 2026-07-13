import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Lys Finance'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @vaults.
  ///
  /// In en, this message translates to:
  /// **'Vaults'**
  String get vaults;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @assistant.
  ///
  /// In en, this message translates to:
  /// **'Assistant'**
  String get assistant;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @quickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get quickAdd;

  /// No description provided for @comingLater.
  ///
  /// In en, this message translates to:
  /// **'This feature belongs to a later sprint.'**
  String get comingLater;

  /// No description provided for @foundationReady.
  ///
  /// In en, this message translates to:
  /// **'The foundation is ready.'**
  String get foundationReady;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @currencies.
  ///
  /// In en, this message translates to:
  /// **'Currencies'**
  String get currencies;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @backupExport.
  ///
  /// In en, this message translates to:
  /// **'Backup & export'**
  String get backupExport;

  /// No description provided for @foundationEntryDescription.
  ///
  /// In en, this message translates to:
  /// **'Foundation settings for a future sprint.'**
  String get foundationEntryDescription;

  /// No description provided for @foundationRouteTitle.
  ///
  /// In en, this message translates to:
  /// **'Foundation ready'**
  String get foundationRouteTitle;

  /// No description provided for @foundationRouteMessage.
  ///
  /// In en, this message translates to:
  /// **'This setting is prepared, but its workflow belongs to a later sprint.'**
  String get foundationRouteMessage;

  /// No description provided for @accountCashWallet.
  ///
  /// In en, this message translates to:
  /// **'Cash Wallet'**
  String get accountCashWallet;

  /// No description provided for @accountBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank Account'**
  String get accountBankAccount;

  /// No description provided for @categorySalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get categorySalary;

  /// No description provided for @categoryFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get categoryFood;

  /// No description provided for @categoryTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get categoryTransport;

  /// No description provided for @categoryShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// No description provided for @categoryAiSubscription.
  ///
  /// In en, this message translates to:
  /// **'AI subscription'**
  String get categoryAiSubscription;

  /// No description provided for @categoryHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get categoryHealth;

  /// No description provided for @categoryEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categoryEducation;

  /// No description provided for @categoryInvestment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get categoryInvestment;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @categoryFreelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get categoryFreelance;

  /// No description provided for @categoryBusinessIncome.
  ///
  /// In en, this message translates to:
  /// **'Business income'**
  String get categoryBusinessIncome;

  /// No description provided for @categoryGift.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get categoryGift;

  /// No description provided for @categoryOtherIncome.
  ///
  /// In en, this message translates to:
  /// **'Other income'**
  String get categoryOtherIncome;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @incomeSource.
  ///
  /// In en, this message translates to:
  /// **'Income source'**
  String get incomeSource;

  /// No description provided for @investment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get investment;

  /// No description provided for @necessity.
  ///
  /// In en, this message translates to:
  /// **'Necessity'**
  String get necessity;

  /// No description provided for @consumption.
  ///
  /// In en, this message translates to:
  /// **'Consumption'**
  String get consumption;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @optionalNote.
  ///
  /// In en, this message translates to:
  /// **'Optional note'**
  String get optionalNote;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search transactions'**
  String get search;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @recentlyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Recently deleted'**
  String get recentlyDeleted;

  /// No description provided for @emptyLedgerTitle.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get emptyLedgerTitle;

  /// No description provided for @emptyLedgerMessage.
  ///
  /// In en, this message translates to:
  /// **'Record an expense or income to begin your ledger.'**
  String get emptyLedgerMessage;

  /// No description provided for @addTransaction.
  ///
  /// In en, this message translates to:
  /// **'Add transaction'**
  String get addTransaction;

  /// No description provided for @transactionDetails.
  ///
  /// In en, this message translates to:
  /// **'Transaction details'**
  String get transactionDetails;

  /// No description provided for @deleteTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete transaction?'**
  String get deleteTransactionTitle;

  /// No description provided for @deleteTransactionMessage.
  ///
  /// In en, this message translates to:
  /// **'It will leave your ledger and can be restored later.'**
  String get deleteTransactionMessage;

  /// No description provided for @transactionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted.'**
  String get transactionDeleted;

  /// No description provided for @transactionRestored.
  ///
  /// In en, this message translates to:
  /// **'Transaction restored.'**
  String get transactionRestored;

  /// No description provided for @invalidAmountError.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount greater than zero.'**
  String get invalidAmountError;

  /// No description provided for @missingAccountError.
  ///
  /// In en, this message translates to:
  /// **'Choose an account to continue.'**
  String get missingAccountError;

  /// No description provided for @archivedAccountError.
  ///
  /// In en, this message translates to:
  /// **'This account is archived. Choose another.'**
  String get archivedAccountError;

  /// No description provided for @missingCategoryError.
  ///
  /// In en, this message translates to:
  /// **'Choose a category to continue.'**
  String get missingCategoryError;

  /// No description provided for @categoryMismatchError.
  ///
  /// In en, this message translates to:
  /// **'That category does not match this transaction type.'**
  String get categoryMismatchError;

  /// No description provided for @currencyMismatchError.
  ///
  /// In en, this message translates to:
  /// **'This account uses a different currency.'**
  String get currencyMismatchError;

  /// No description provided for @versionConflictError.
  ///
  /// In en, this message translates to:
  /// **'This transaction changed elsewhere. Reload and try again.'**
  String get versionConflictError;

  /// No description provided for @databaseWriteError.
  ///
  /// In en, this message translates to:
  /// **'Could not save. Please try again.'**
  String get databaseWriteError;

  /// No description provided for @databaseReadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load your transactions. Please try again.'**
  String get databaseReadError;

  /// No description provided for @unableToLoad.
  ///
  /// In en, this message translates to:
  /// **'Unable to load'**
  String get unableToLoad;

  /// No description provided for @loadingTransactions.
  ///
  /// In en, this message translates to:
  /// **'Loading transactions'**
  String get loadingTransactions;

  /// No description provided for @selectAccount.
  ///
  /// In en, this message translates to:
  /// **'Select account'**
  String get selectAccount;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @vaultEmergencyFund.
  ///
  /// In en, this message translates to:
  /// **'Emergency Fund'**
  String get vaultEmergencyFund;

  /// No description provided for @vaultJapanMasters.
  ///
  /// In en, this message translates to:
  /// **'Japan Master\'s'**
  String get vaultJapanMasters;

  /// No description provided for @vaultAiInfrastructure.
  ///
  /// In en, this message translates to:
  /// **'AI Infrastructure'**
  String get vaultAiInfrastructure;

  /// No description provided for @vaultElysia.
  ///
  /// In en, this message translates to:
  /// **'Elysia'**
  String get vaultElysia;

  /// No description provided for @vaultGpuUpgrade.
  ///
  /// In en, this message translates to:
  /// **'GPU Upgrade'**
  String get vaultGpuUpgrade;

  /// No description provided for @vaultInvestment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get vaultInvestment;

  /// No description provided for @vaultFreedomFund.
  ///
  /// In en, this message translates to:
  /// **'Freedom Fund'**
  String get vaultFreedomFund;

  /// No description provided for @vaultVacation.
  ///
  /// In en, this message translates to:
  /// **'Vacation'**
  String get vaultVacation;

  /// No description provided for @newVault.
  ///
  /// In en, this message translates to:
  /// **'New vault'**
  String get newVault;

  /// No description provided for @editVault.
  ///
  /// In en, this message translates to:
  /// **'Edit vault'**
  String get editVault;

  /// No description provided for @vaultName.
  ///
  /// In en, this message translates to:
  /// **'Vault name'**
  String get vaultName;

  /// No description provided for @vaultDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get vaultDescription;

  /// No description provided for @optionalDescription.
  ///
  /// In en, this message translates to:
  /// **'Optional description'**
  String get optionalDescription;

  /// No description provided for @goalAmount.
  ///
  /// In en, this message translates to:
  /// **'Goal amount'**
  String get goalAmount;

  /// No description provided for @optionalGoalAmount.
  ///
  /// In en, this message translates to:
  /// **'Optional goal amount'**
  String get optionalGoalAmount;

  /// No description provided for @targetDate.
  ///
  /// In en, this message translates to:
  /// **'Target date'**
  String get targetDate;

  /// No description provided for @optionalTargetDate.
  ///
  /// In en, this message translates to:
  /// **'Optional target date'**
  String get optionalTargetDate;

  /// No description provided for @withdrawalPolicy.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal policy'**
  String get withdrawalPolicy;

  /// No description provided for @withdrawalPolicyLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get withdrawalPolicyLocked;

  /// No description provided for @withdrawalPolicySoft.
  ///
  /// In en, this message translates to:
  /// **'Soft'**
  String get withdrawalPolicySoft;

  /// No description provided for @withdrawalPolicyDeadlineLinked.
  ///
  /// In en, this message translates to:
  /// **'Deadline-linked'**
  String get withdrawalPolicyDeadlineLinked;

  /// No description provided for @archiveVault.
  ///
  /// In en, this message translates to:
  /// **'Archive vault'**
  String get archiveVault;

  /// No description provided for @archiveVaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive this vault?'**
  String get archiveVaultTitle;

  /// No description provided for @archiveVaultMessage.
  ///
  /// In en, this message translates to:
  /// **'It leaves your active vaults and can be restored later.'**
  String get archiveVaultMessage;

  /// No description provided for @restoreVault.
  ///
  /// In en, this message translates to:
  /// **'Restore vault'**
  String get restoreVault;

  /// No description provided for @vaultArchived.
  ///
  /// In en, this message translates to:
  /// **'Vault archived.'**
  String get vaultArchived;

  /// No description provided for @vaultRestored.
  ///
  /// In en, this message translates to:
  /// **'Vault restored.'**
  String get vaultRestored;

  /// No description provided for @activeVaults.
  ///
  /// In en, this message translates to:
  /// **'Active vaults'**
  String get activeVaults;

  /// No description provided for @seeAllVaults.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAllVaults;

  /// No description provided for @emptyVaultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No vaults yet'**
  String get emptyVaultsTitle;

  /// No description provided for @emptyVaultsMessage.
  ///
  /// In en, this message translates to:
  /// **'Create a vault to start saving toward something.'**
  String get emptyVaultsMessage;

  /// No description provided for @createVault.
  ///
  /// In en, this message translates to:
  /// **'Create vault'**
  String get createVault;

  /// No description provided for @contribute.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get contribute;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @contributeToVault.
  ///
  /// In en, this message translates to:
  /// **'Contribute to vault'**
  String get contributeToVault;

  /// No description provided for @withdrawFromVault.
  ///
  /// In en, this message translates to:
  /// **'Withdraw from vault'**
  String get withdrawFromVault;

  /// No description provided for @transferBetweenVaults.
  ///
  /// In en, this message translates to:
  /// **'Transfer between vaults'**
  String get transferBetweenVaults;

  /// No description provided for @sourceVault.
  ///
  /// In en, this message translates to:
  /// **'From vault'**
  String get sourceVault;

  /// No description provided for @destinationVault.
  ///
  /// In en, this message translates to:
  /// **'To vault'**
  String get destinationVault;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @optionalReason.
  ///
  /// In en, this message translates to:
  /// **'Optional reason'**
  String get optionalReason;

  /// No description provided for @reasonRequired.
  ///
  /// In en, this message translates to:
  /// **'Reason (required for a locked vault)'**
  String get reasonRequired;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current balance'**
  String get currentBalance;

  /// No description provided for @remainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remainingAmount;

  /// No description provided for @monthlyAverage.
  ///
  /// In en, this message translates to:
  /// **'Monthly average'**
  String get monthlyAverage;

  /// No description provided for @estimatedCompletion.
  ///
  /// In en, this message translates to:
  /// **'Estimated completion'**
  String get estimatedCompletion;

  /// No description provided for @noGoalSet.
  ///
  /// In en, this message translates to:
  /// **'No goal set'**
  String get noGoalSet;

  /// No description provided for @notEnoughData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data yet'**
  String get notEnoughData;

  /// No description provided for @goalCompletedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get goalCompletedLabel;

  /// No description provided for @goalOnTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get goalOnTrack;

  /// No description provided for @goalBehind.
  ///
  /// In en, this message translates to:
  /// **'Behind'**
  String get goalBehind;

  /// No description provided for @goalAtRisk.
  ///
  /// In en, this message translates to:
  /// **'At risk'**
  String get goalAtRisk;

  /// No description provided for @goalNoTarget.
  ///
  /// In en, this message translates to:
  /// **'No target'**
  String get goalNoTarget;

  /// No description provided for @goalNoData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get goalNoData;

  /// No description provided for @vaultHistory.
  ///
  /// In en, this message translates to:
  /// **'Vault history'**
  String get vaultHistory;

  /// No description provided for @emptyVaultHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get emptyVaultHistoryTitle;

  /// No description provided for @emptyVaultHistoryMessage.
  ///
  /// In en, this message translates to:
  /// **'Contributions, withdrawals, and transfers will appear here.'**
  String get emptyVaultHistoryMessage;

  /// No description provided for @historyContribution.
  ///
  /// In en, this message translates to:
  /// **'Contribution'**
  String get historyContribution;

  /// No description provided for @historyWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get historyWithdrawal;

  /// No description provided for @historyTransferIn.
  ///
  /// In en, this message translates to:
  /// **'Transfer in'**
  String get historyTransferIn;

  /// No description provided for @historyTransferOut.
  ///
  /// In en, this message translates to:
  /// **'Transfer out'**
  String get historyTransferOut;

  /// No description provided for @historyCreated.
  ///
  /// In en, this message translates to:
  /// **'Vault created'**
  String get historyCreated;

  /// No description provided for @historyEdited.
  ///
  /// In en, this message translates to:
  /// **'Vault edited'**
  String get historyEdited;

  /// No description provided for @historyArchived.
  ///
  /// In en, this message translates to:
  /// **'Vault archived'**
  String get historyArchived;

  /// No description provided for @historyRestored.
  ///
  /// In en, this message translates to:
  /// **'Vault restored'**
  String get historyRestored;

  /// No description provided for @historyMilestone.
  ///
  /// In en, this message translates to:
  /// **'Reached {percent}%'**
  String historyMilestone(String percent);

  /// No description provided for @historyGoalCompleted.
  ///
  /// In en, this message translates to:
  /// **'Goal completed'**
  String get historyGoalCompleted;

  /// No description provided for @historyGoalReopened.
  ///
  /// In en, this message translates to:
  /// **'Goal reopened'**
  String get historyGoalReopened;

  /// No description provided for @vaultCompletedCelebrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Goal complete!'**
  String get vaultCompletedCelebrationTitle;

  /// No description provided for @vaultCompletedCelebrationMessage.
  ///
  /// In en, this message translates to:
  /// **'{vaultName} reached its goal.'**
  String vaultCompletedCelebrationMessage(String vaultName);

  /// No description provided for @invalidGoalAmountError.
  ///
  /// In en, this message translates to:
  /// **'Enter a goal amount greater than zero.'**
  String get invalidGoalAmountError;

  /// No description provided for @missingVaultError.
  ///
  /// In en, this message translates to:
  /// **'Choose a vault to continue.'**
  String get missingVaultError;

  /// No description provided for @archivedVaultError.
  ///
  /// In en, this message translates to:
  /// **'This vault is archived. Choose another.'**
  String get archivedVaultError;

  /// No description provided for @currencyVaultMismatchError.
  ///
  /// In en, this message translates to:
  /// **'This vault uses a different currency.'**
  String get currencyVaultMismatchError;

  /// No description provided for @vaultCurrencyMismatchError.
  ///
  /// In en, this message translates to:
  /// **'Both vaults must use the same currency.'**
  String get vaultCurrencyMismatchError;

  /// No description provided for @sameVaultTransferError.
  ///
  /// In en, this message translates to:
  /// **'Choose two different vaults to transfer between.'**
  String get sameVaultTransferError;

  /// No description provided for @insufficientVaultBalanceError.
  ///
  /// In en, this message translates to:
  /// **'This vault does not have enough balance for that amount.'**
  String get insufficientVaultBalanceError;

  /// No description provided for @withdrawalReasonRequiredError.
  ///
  /// In en, this message translates to:
  /// **'This vault is locked. Add a reason to continue.'**
  String get withdrawalReasonRequiredError;

  /// No description provided for @vaultCurrencyLockedError.
  ///
  /// In en, this message translates to:
  /// **'This vault already has contributions and cannot change currency.'**
  String get vaultCurrencyLockedError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
