import 'package:flutter/material.dart';
import 'package:go_router_responsive/ui/users/widgets/user_list_item.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Center(
        child: ConstrainedBox(
          // "Тестовый" constraint просто чтобы показать немного адаптива.
          constraints: BoxConstraints.loose(const Size(600, double.infinity)),
          child: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        final title = 'Person ${index + 1}';
        return UserListItem(name: title);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
