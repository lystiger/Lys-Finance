import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/assistant/presentation/assistant_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/insights/presentation/insights_screen.dart';
import '../../features/quick_add/presentation/quick_add_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
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
      GoRoute(
        path: AppRoutes.quickAdd,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<void>(
              fullscreenDialog: true,
              child: QuickAddScreen(),
            ),
      ),
    ],
  );
}
