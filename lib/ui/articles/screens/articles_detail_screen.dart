import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/routing/route_parameters.dart';
import 'package:go_router_responsive/util/reponsive_utility.dart';

class ArticlesDetailScreenRouteArguments {
  final int id;

  ArticlesDetailScreenRouteArguments({required this.id});

  factory ArticlesDetailScreenRouteArguments.fromRoute({
    required GoRouterState state,
  }) {
    int? id;
    const articleParamName = RouteParameters.articleId;
    if (state.pathParameters.containsKey(articleParamName)) {
      id = int.tryParse(state.pathParameters[articleParamName]!);
    }
    if (id == null) {
      throw ArgumentError('ArticlesDetailsPage route path must contain id');
    }
    return ArticlesDetailScreenRouteArguments(id: id);
  }
}

class ArticlesDetailScreen extends StatelessWidget {
  factory ArticlesDetailScreen.fromRoute({
    required GoRouterState state,
  }) {
    final arguments = ArticlesDetailScreenRouteArguments.fromRoute(
      state: state,
    );
    return ArticlesDetailScreen(id: arguments.id);
  }

  final int id;
  const ArticlesDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final isTwoPane = ResponsiveUtility.isBiggerThanMobile(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles Detail'),
        leading: isTwoPane ? const CloseButton() : const BackButton(),
      ),
      body: Center(child: Text('Articles Detail Page, id: ${id + 1}')),
    );
  }
}
