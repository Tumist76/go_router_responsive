import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final String name;
  const UserListItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.blue.shade300,
          ),
          child: const SizedBox(
            height: 48,
            width: 48,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(name, style: Theme.of(context).textTheme.bodyLarge),
        )
      ],
    );
  }
}
