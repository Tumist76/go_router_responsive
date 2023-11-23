import 'package:flutter/material.dart';
import 'package:go_router_responsive/util/reponsive_utility.dart';

class DetailPlaceholderWidget extends StatelessWidget {
  final Widget child;
  const DetailPlaceholderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isTwoPane = ResponsiveUtility.isBiggerThanMobile(context);
    return Opacity(
      opacity: isTwoPane ? 1.0 : 0.0,
      child: child,
    );
  }
}
