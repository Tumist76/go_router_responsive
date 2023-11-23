import 'package:flutter/material.dart';
import 'package:go_router_responsive/ui/common/detail_placeholder_widget.dart';

class ArticlesEmptySelectionScreen extends StatelessWidget {
  const ArticlesEmptySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailPlaceholderWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Select an article',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
