import 'package:flutter/material.dart';
import 'package:go_router_responsive/ui/start/widgets/navigation_scaffold.dart';

class RailNavigationScaffold extends StatelessWidget {
  const RailNavigationScaffold({
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
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationChanged,
            labelType: NavigationRailLabelType.all,
            destinations: destinations
                .map((e) => NavigationRailDestination(
                      icon: e.icon,
                      label: Text(e.label),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}
