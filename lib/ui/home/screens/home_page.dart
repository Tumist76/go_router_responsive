import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/routing/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static MaterialPage<void> routeBuilder(BuildContext context) {
    return const MaterialPage<void>(child: HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => context.goNamed(Routes.articleList.name),
        child: const Text('Go to Article List'),
      ),
    );
  }
}
