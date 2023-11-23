import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/ui/start/widgets/navigation_scaffold.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomeScreen({super.key, required this.navigationShell});

  static const _navBarDestinations = [
    DestinationItem(icon: Icon(Icons.list_rounded), label: 'Articles'),
    DestinationItem(icon: Icon(Icons.people_alt_rounded), label: 'Users'),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationScaffold(
      navigationShell: navigationShell,
      destinations: _navBarDestinations,
    );
  }
}
