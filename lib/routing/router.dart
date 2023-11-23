import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/ui/articles/screens/articles_detail_screen.dart';
import 'package:go_router_responsive/ui/articles/screens/articles_empty_screen.dart';
import 'package:go_router_responsive/ui/articles/screens/articles_list_screen.dart';
import 'package:go_router_responsive/ui/home/screens/home_page.dart';
import 'package:go_router_responsive/routing/route_parameters.dart';
import 'package:go_router_responsive/routing/routes.dart';
import 'package:go_router_responsive/ui/common/master_detail_view.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _articlesNavigatorKey =
    GlobalKey<NavigatorState>();

GoRouter buildRouter(BuildContext context) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        pageBuilder: (context, state) {
          return HomePage.routeBuilder(context);
        },
        routes: [
          // Articles List Base
          ShellRoute(
            navigatorKey: _articlesNavigatorKey,
            builder: (context, state, child) {
              final isOnlyMaster =
                  state.fullPath?.endsWith(Routes.articleList.path) ?? false;
              if (isOnlyMaster) {
                return MasterDetailResponsiveView.master(
                  master: const ArticlesListScreen(),
                  detailPlaceholder: child,
                );
              }
              return MasterDetailResponsiveView.detail(
                master: const ArticlesListScreen(),
                detail: child,
              );
            },
            routes: [
              // Article Empty Selection Screen
              GoRoute(
                path: Routes.articleList.path,
                name: Routes.articleList.name,
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    child: ArticlesEmptySelectionScreen(),
                  );
                },
                routes: [
                  GoRoute(
                    path: Routes.articleDetails.path,
                    name: Routes.articleDetails.name,
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        child: ArticlesDetailScreen.fromRoute(state: state),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
