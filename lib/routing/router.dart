import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/routing/routes.dart';
import 'package:go_router_responsive/ui/articles/screens/articles_detail_screen.dart';
import 'package:go_router_responsive/ui/articles/screens/article_empty_selection_screen.dart';
import 'package:go_router_responsive/ui/articles/screens/article_list_screen.dart';
import 'package:go_router_responsive/ui/common/master_detail_view.dart';
import 'package:go_router_responsive/ui/home/screens/home_screen.dart';
import 'package:go_router_responsive/ui/start/screens/start_page.dart';
import 'package:go_router_responsive/ui/users/screens/user_list_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _navBarNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _articlesNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: Routes.start.path,
      name: Routes.start.name,
      pageBuilder: (_, __) => const MaterialPage(child: StartPage()),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __, shell) => HomeScreen(navigationShell: shell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _navBarNavigatorKey,
          routes: [
            ShellRoute(
              navigatorKey: _articlesNavigatorKey,
              builder: (context, state, child) {
                return MasterDetailResponsiveView.fromRoute(
                  state: state,
                  masterRoute: Routes.articleList,
                  master: ArticleListScreen.fromRoute(state: state),
                  child: child,
                );
              },
              routes: [
                GoRoute(
                  path: Routes.articleList.path,
                  name: Routes.articleList.name,
                  // Для пути со списком создаем заглушку, которая
                  // будет отображаться вместо detail в "широком" формате.
                  pageBuilder: (_, __) => const MaterialPage(
                    child: ArticleEmptySelectionScreen(),
                  ),
                  routes: [
                    GoRoute(
                      path: Routes.articleDetails.path,
                      name: Routes.articleDetails.name,
                      pageBuilder: (_, state) => MaterialPage(
                        child: ArticlesDetailScreen.fromRoute(state: state),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.userList.path,
              name: Routes.userList.name,
              pageBuilder: (_, __) =>
                  const MaterialPage(child: UserListScreen()),
            )
          ],
        )
      ],
    ),
  ],
);
