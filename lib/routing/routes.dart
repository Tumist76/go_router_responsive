import 'package:go_router_responsive/routing/route_parameters.dart';

enum Routes {
  start(name: 'start', path: '/'),
  articleList(name: 'articleList', path: '/articleList'),
  articleDetails(name: 'articleDetails', path: ':${RouteParameters.articleId}'),
  userList(name: 'userList', path: '/userList');

  const Routes({required this.name, required this.path});

  final String name;

  final String path;

  @override
  String toString() => name;
}
