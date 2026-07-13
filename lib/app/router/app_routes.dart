abstract final class AppRoutes {
  static const String home = '/home';
  static const String vaults = '/vaults';
  static const String insights = '/insights';
  static const String assistant = '/assistant';
  static const String settings = '/settings';
  static const String quickAdd = '/quick-add';
  static const String settingsAccounts = '/settings/accounts';
  static const String settingsCategories = '/settings/categories';
  static const String settingsCurrencies = '/settings/currencies';
  static const String settingsAppearance = '/settings/appearance';
  static const String settingsNotifications = '/settings/notifications';
  static const String settingsBackup = '/settings/backup';
  static const String ledger = '/ledger';
  static const String recentlyDeleted = '/ledger/deleted';
  static const String transactionDetail = '/transactions/:id';
  static const String transactionEdit = '/transactions/:id/edit';
  static const String vaultDetail = '/vaults/:id';

  static String transaction(String id) => '/transactions/$id';
  static String editTransaction(String id) => '/transactions/$id/edit';
  static String vault(String id) => '/vaults/$id';
}
