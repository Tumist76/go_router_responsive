import 'package:flutter/material.dart';
import 'package:go_router_responsive/ui/start/widgets/navigation_scaffold.dart';

class BottomNavigationScaffold extends StatelessWidget {
  const BottomNavigationScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationChanged,
    required this.destinations,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationChanged;
  final List<DestinationItem> destinations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationChanged,
        destinations: destinations
            .map((e) => NavigationDestination(icon: e.icon, label: e.label))
            .toList(),
      ),
    );
  }
}
