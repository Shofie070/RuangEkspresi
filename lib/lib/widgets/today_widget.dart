import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ruang_ekspresi/utils/shared_util.dart'; // pastikan ini sesuai
import 'history_item.dart';

class TodayWidget extends StatefulWidget {
  const TodayWidget({super.key});

  @override
  State<TodayWidget> createState() => _TodayWidgetState();
}

class _TodayWidgetState extends State<TodayWidget> {
  final TextEditingController controller = TextEditingController();
  List<String> moods = [];

  @override
  void initState() {
    super.initState();
    _loadMoods();
  }

  Future<void> _loadMoods() async {
    final data = await loadList("moods");
    setState(() {
      moods = data;
    });
  }

  Future<void> _saveMoods() async {
    await saveList("moods", moods);
    _loadMoods();
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration: const InputDecoration(
                    hintText: "Tulis mood kamu...",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (controller.text.trim().isEmpty) return;
                    setState(() {
                      moods.add(controller.text);
                    });
                    await _saveMoods();
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
        ...moods.asMap().entries.map((entry) {
          final index = entry.key;
          final mood = entry.value;
          return HistoryItem(
            text: mood,
            onEdit: () async {
              controller.text = mood;
              setState(() {
                moods[index] = controller.text;
              });
              await _saveMoods();
            },
            onDelete: () async {
              setState(() {
                moods.removeAt(index);
              });
              await _saveMoods();
            },
          );
        }),
      ],
    );
  }
}
