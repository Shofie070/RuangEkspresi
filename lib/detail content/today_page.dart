import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Simple HistoryItem widget used by today_page.dart
class HistoryItem extends StatelessWidget {
  final String text;
  final Future<void> Function()? onEdit;
  final Future<void> Function()? onDelete;

  const HistoryItem({
    Key? key,
    required this.text,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit == null ? null : () => onEdit!(),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete == null ? null : () => onDelete!(),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🟣 Aku Hari Ini (Mood)
Widget buildTodayPage() {
  final TextEditingController controller = TextEditingController();

  return FutureBuilder<List<String>>(
    future: _loadList("moods"),
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
                      hintStyle: TextStyle(color: Colors.grey[300]),
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
                      await _saveList("moods", updated);
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
                  await _saveList("moods", moods);
                },
                onDelete: () async {
                  moods.removeAt(index);
                  await _saveList("moods", moods);
                },
              );
            }),
        ],
      );
    },
  );
}

Future<List<String>> _loadList(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key) ?? [];
}

Future<void> _saveList(String key, List<String> data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(key, data);
}