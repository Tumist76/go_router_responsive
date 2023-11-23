import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/routing/route_parameters.dart';
import 'package:go_router_responsive/routing/routes.dart';

class ArticleListScreen extends StatefulWidget {
  final bool noDetailSelected;
  const ArticleListScreen({super.key, required this.noDetailSelected});

  factory ArticleListScreen.fromRoute({required GoRouterState state}) {
    final noDetailSelected = state.fullPath == Routes.articleList.path;
    return ArticleListScreen(noDetailSelected: noDetailSelected);
  }

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  Map<int, String>? items;
  int? selectedItemId;

  @override
  void initState() {
    // Симулируем загрузку
    Timer(const Duration(seconds: 2), _loadArticles);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ArticleListScreen oldWidget) {
    if (widget.noDetailSelected) selectedItemId = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Article List')),
      body: Center(
        child: Column(
          children: [
            Expanded(child: _buildList()),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    if (items == null) return const Center(child: CircularProgressIndicator());
    return ListView.separated(
      itemCount: items!.length,
      itemBuilder: (context, index) {
        final isSelected = index == selectedItemId;
        final title = items![index]!;
        final text = isSelected ? '$title (Selected)' : title;
        return Card(
          child: InkWell(
            onTap: () async {
              setState(() => selectedItemId = index);
              context.goNamed(
                Routes.articleDetails.name,
                pathParameters: {
                  RouteParameters.articleId: index.toString(),
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }

  void _loadArticles() {
    items = <int, String>{};
    for (var i = 0; i < 15; i++) {
      items![i] = 'Article ${i + 1}';
    }
    if (!mounted) return;
    setState(() {});
  }
}
