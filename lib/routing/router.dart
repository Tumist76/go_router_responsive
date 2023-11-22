import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/pages/articles_detail_page.dart';
import 'package:go_router_responsive/pages/articles_list_page.dart';
import 'package:go_router_responsive/pages/home_page.dart';
import 'package:go_router_responsive/routing/route_parameters.dart';
import 'package:go_router_responsive/routing/routes.dart';
import 'package:go_router_responsive/widget/master_detail_view.dart';

GoRouter buildRouter(BuildContext context) {
  return GoRouter(
    routes: [
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        pageBuilder: (context, state) {
          return HomePage.routeBuilder(context);
        },
        routes: [
          GoRoute(
            path: Routes.articleList.path,
            name: Routes.articleList.name,
            pageBuilder: (context, state) {
              return MasterDetailResponsiveView.buildRoute(
                routeName: Routes.articleList.name,
                context: context,
                masterBuilder: (context) =>
                    ArticlesListPage.fromRoute(state: state),
              );
            },
            routes: [
              GoRoute(
                path:
                    '${Routes.articleDetails.path}/:${RouteParameters.articleId.parameterName}',
                name: Routes.articleDetails.name,
                pageBuilder: (context, state) {
                  return MasterDetailResponsiveView.buildRoute(
                    routeName: Routes.articleDetails.name,
                    context: context,
                    masterBuilder: (context) =>
                        ArticlesListPage.fromRoute(state: state),
                    detailBuilder: (context) =>
                        ArticlesDetailPage.fromRoute(state: state),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
