import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_responsive/pages/route_arguments.dart';
import 'package:go_router_responsive/routing/route_parameters.dart';
import 'package:go_router_responsive/routing/routes.dart';

class ArticlesListPageArguments extends RouteArguments {
  final Map<int, String>? items;
  final int? selectedItemId;

  const ArticlesListPageArguments({this.items, this.selectedItemId});

  factory ArticlesListPageArguments.fromRoute({required GoRouterState state}) {
    Map<int, String>? items;
    int? selectedItemId;
    if (state.extra is Map<int, String>) {
      items = state.extra as Map<int, String>;
    }

    final articleParamName = RouteParameters.articleId.parameterName;
    if (state.pathParameters.containsKey(articleParamName)) {
      selectedItemId = int.tryParse(state.pathParameters[articleParamName]!);
    }
    return ArticlesListPageArguments(
      items: items,
      selectedItemId: selectedItemId,
    );
  }
}

class ArticlesListPage extends StatefulWidget {
  final Map<int, String>? items;
  final int? selectedItemId;

  const ArticlesListPage({super.key, this.items, this.selectedItemId});

  factory ArticlesListPage.fromRoute({required GoRouterState state}) {
    print('${state.fullPath}, extra: ${state.extra}');
    final arguments = ArticlesListPageArguments.fromRoute(state: state);
    return ArticlesListPage(
      items: arguments.items,
      selectedItemId: arguments.selectedItemId,
    );
  }

  @override
  State<ArticlesListPage> createState() => _ArticlesListPageState();
}

class _ArticlesListPageState extends State<ArticlesListPage> {
  Map<int, String>? items;
  int? selectedItemId;

  @override
  void initState() {
    items = widget.items;
    selectedItemId = widget.selectedItemId;
    // Загружаем статьи через секунды, если они не были переданы
    // с предыдущего экрана через навигатор
    if (items == null) {
      Timer(const Duration(seconds: 3), _loadArticles);
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ArticlesListPage oldWidget) {
    if (widget.selectedItemId != oldWidget.selectedItemId) {
      selectedItemId = widget.selectedItemId;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles List')),
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
            onTap: () => context.goNamed(
              Routes.articleDetails.name,
              pathParameters: {
                RouteParameters.articleId.parameterName: index.toString(),
              },
              extra: items,
            ),
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
