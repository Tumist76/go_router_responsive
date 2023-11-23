import 'package:go_router_responsive/routing/route_parameters.dart';

enum Routes {
  home(name: 'home', path: '/'),
  articleList(name: 'articleList1', path: 'articleList'),
  articleDetails(name: 'articleDetails', path: ':aid'),
  userList(name: 'userList', path: 'userList'),
  userDetail(name: 'userDetail', path: 'userDetail');

  const Routes({
    required this.name,
    required this.path,
  });

  /// Represents the route name
  ///
  /// Example: `Routes.recipesList.name`
  /// Returns: 'recipesList'
  final String name;

  /// Represents the route path
  ///
  /// Example: `Routes.recipesList.path`
  /// Returns: '/recipesList'
  final String path;

  @override
  String toString() => name;
}
