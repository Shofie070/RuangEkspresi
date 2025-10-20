import 'package:flutter/material.dart';
import 'models/menu_model.dart';

Widget buildDetailContent(MenuModel menu) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          menu.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(menu.description),
      ],
    ),
  );
}
