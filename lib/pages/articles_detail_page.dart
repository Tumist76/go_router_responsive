import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/pages/route_arguments.dart';
import 'package:go_router_responsive/routing/route_parameters.dart';

class ArticlesDetailRouteArguments extends RouteArguments {
  final int id;

  ArticlesDetailRouteArguments({required this.id});

  factory ArticlesDetailRouteArguments.fromRoute({
    required GoRouterState state,
  }) {
    int? id;
    final articleParamName = RouteParameters.articleId.parameterName;
    if (state.pathParameters.containsKey(articleParamName)) {
      id = int.tryParse(state.pathParameters[articleParamName]!);
    }
    if (id == null) {
      throw ArgumentError('ArticlesDetailsPage route path must contain id');
    }
    return ArticlesDetailRouteArguments(id: id);
  }
}

class ArticlesDetailPage extends StatefulWidget {
  final int id;
  const ArticlesDetailPage({super.key, required this.id});

  factory ArticlesDetailPage.fromRoute({
    required GoRouterState state,
  }) {
    final arguments = ArticlesDetailRouteArguments.fromRoute(state: state);
    return ArticlesDetailPage(id: arguments.id);
  }

  @override
  State<ArticlesDetailPage> createState() => _ArticlesDetailPageState();
}

class _ArticlesDetailPageState extends State<ArticlesDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles Detail')),
      body: Center(child: Text('Articles Detail Page, id: ${widget.id + 1}')),
    );
  }
}
