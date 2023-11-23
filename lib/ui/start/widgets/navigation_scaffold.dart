import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/ui/start/widgets/bottom_navigation_scaffold.dart';
import 'package:go_router_responsive/ui/start/widgets/rail_navigation_scaffold.dart';
import 'package:go_router_responsive/util/reponsive_utility.dart';

class DestinationItem {
  final Widget icon;
  final String label;

  const DestinationItem({required this.icon, required this.label});
}

class NavigationScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<DestinationItem> destinations;

  const NavigationScaffold({
    super.key,
    required this.navigationShell,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = ResponsiveUtility.isBiggerThanMobile(context);
    return isWide
        ? RailNavigationScaffold(
            body: navigationShell,
            selectedIndex: navigationShell.currentIndex,
            onDestinationChanged: navigationShell.goBranch,
            destinations: destinations,
          )
        : BottomNavigationScaffold(
            body: navigationShell,
            selectedIndex: navigationShell.currentIndex,
            onDestinationChanged: navigationShell.goBranch,
            destinations: destinations);
  }
}
