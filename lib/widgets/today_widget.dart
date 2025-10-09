import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/shared_util.dart';
import 'package:getwidget/getwidget.dart';
import 'history_item.dart';

Widget buildTodayWidget() {
  final TextEditingController controller = TextEditingController();

  return FutureBuilder<List<String>>(
    future: loadList("moods"),
    builder: (context, snapshot) {
      final moods = snapshot.data ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.deepPurple.shade800,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bagaimana mood kamu hari ini?",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  GFTextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Tulis mood kamu...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.text.trim().isEmpty) return;
                      final updated = [...moods, controller.text];
                      await saveList("moods", updated);
                      controller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Mood tersimpan!")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Simpan Mood"),
                  ),
                ],
              ),
            ),
          ),
          if (moods.isNotEmpty)
            ...moods.asMap().entries.map((entry) {
              final index = entry.key;
              final mood = entry.value;
              return HistoryItem(
                text: mood,
                onEdit: () async {
                  controller.text = mood;
                  moods[index] = controller.text;
                  await saveList("moods", moods);
                },
                onDelete: () async {
                  moods.removeAt(index);
                  await saveList("moods", moods);
                },
              );
            }),
        ],
      );
    },
  );
}
