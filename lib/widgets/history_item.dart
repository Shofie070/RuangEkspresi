import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  final String text;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HistoryItem({
    super.key,
    required this.text,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade100,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.indigo),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
