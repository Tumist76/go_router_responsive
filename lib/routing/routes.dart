enum Routes {
  home(name: 'home', path: '/'),
  articleList(name: 'articleList', path: 'articleList'),
  articleDetails(name: 'articleDetails', path: 'articleDetails'),
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
