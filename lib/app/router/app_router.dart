import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/l10n/app_localizations.dart';
import '../../features/assistant/presentation/assistant_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/insights/presentation/insights_screen.dart';
import '../../features/quick_add/presentation/quick_add_screen.dart';
import '../../features/settings/presentation/foundation_settings_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/transactions/presentation/ledger_screen.dart';
import '../../features/transactions/presentation/transaction_detail_screen.dart';
import '../../features/vaults/presentation/vault_detail_screen.dart';
import '../../features/vaults/presentation/vaults_screen.dart';
import 'app_routes.dart';
import 'navigation_shell.dart';

final GoRouter appRouter = createAppRouter();

GoRouter createAppRouter({String initialLocation = AppRoutes.home}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) => NavigationShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.vaults,
                builder: (BuildContext context, GoRouterState state) =>
                    const VaultsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.insights,
                builder: (BuildContext context, GoRouterState state) =>
                    const InsightsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.assistant,
                builder: (BuildContext context, GoRouterState state) =>
                    const AssistantScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (BuildContext context, GoRouterState state) =>
            const SettingsScreen(),
      ),
      ...<
            ({
              String path,
              IconData icon,
              String Function(AppLocalizations) title,
            })
          >[
            (
              path: AppRoutes.settingsAccounts,
              icon: Icons.account_balance_wallet_outlined,
              title: (AppLocalizations l) => l.accounts,
            ),
            (
              path: AppRoutes.settingsCategories,
              icon: Icons.category_outlined,
              title: (AppLocalizations l) => l.categories,
            ),
            (
              path: AppRoutes.settingsCurrencies,
              icon: Icons.currency_exchange,
              title: (AppLocalizations l) => l.currencies,
            ),
            (
              path: AppRoutes.settingsAppearance,
              icon: Icons.palette_outlined,
              title: (AppLocalizations l) => l.appearance,
            ),
            (
              path: AppRoutes.settingsNotifications,
              icon: Icons.notifications_outlined,
              title: (AppLocalizations l) => l.notifications,
            ),
            (
              path: AppRoutes.settingsBackup,
              icon: Icons.ios_share_outlined,
              title: (AppLocalizations l) => l.backupExport,
            ),
          ]
          .map(
            (
              ({
                String path,
                IconData icon,
                String Function(AppLocalizations) title,
              })
              route,
            ) => GoRoute(
              path: route.path,
              builder: (BuildContext context, GoRouterState state) =>
                  FoundationSettingsScreen(
                    title: route.title(AppLocalizations.of(context)),
                    icon: route.icon,
                  ),
            ),
          ),
      GoRoute(
        path: AppRoutes.quickAdd,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<void>(
              fullscreenDialog: true,
              child: QuickAddScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.ledger,
        builder: (BuildContext context, GoRouterState state) =>
            const LedgerScreen(),
      ),
      GoRoute(
        path: AppRoutes.recentlyDeleted,
        builder: (BuildContext context, GoRouterState state) =>
            const LedgerScreen(deletedOnly: true),
      ),
      GoRoute(
        path: AppRoutes.transactionDetail,
        builder: (BuildContext context, GoRouterState state) =>
            TransactionDetailScreen(transactionId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.transactionEdit,
        builder: (BuildContext context, GoRouterState state) =>
            EditTransactionScreen(transactionId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.vaultDetail,
        builder: (BuildContext context, GoRouterState state) =>
            VaultDetailScreen(vaultId: state.pathParameters['id']!),
      ),
    ],
  );
}
