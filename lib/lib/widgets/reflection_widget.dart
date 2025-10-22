// reflection_widget.dart
import 'package:flutter/material.dart';
import 'package:ruang_ekspresi/widgets/history_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ruang_ekspresi/models/menu_model.dart'; // ✅ koneksi ke MenuModel

class ReflectionWidget extends StatefulWidget {
  final MenuModel menu; // ✅ tambahkan koneksi ke MenuModel
  const ReflectionWidget({super.key, required this.menu});

  @override
  State<ReflectionWidget> createState() => _ReflectionWidgetState();
}

class _ReflectionWidgetState extends State<ReflectionWidget> {
  final TextEditingController controller = TextEditingController();
  List<String> reflections = [];

  @override
  void initState() {
    super.initState();
    _loadReflections();
  }

  Future<void> _loadReflections() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      reflections = prefs.getStringList("reflections_${widget.menu.title}") ?? [];
    });
  }

  Future<void> _saveReflections() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("reflections_${widget.menu.title}", reflections);
    _loadReflections();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: widget.menu.bgColor.withOpacity(0.8), // ✅ dinamis dari MenuModel
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tulis refleksimu 🌸 (${widget.menu.title})", // ✅ tampilkan nama menu
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Apa yang kamu rasakan hari ini?",
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
                    reflections.add(controller.text);
                    await _saveReflections();
                    controller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Refleksi tersimpan!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Simpan Refleksi"),
                ),
              ],
            ),
          ),
        ),
        ...reflections.asMap().entries.map((entry) {
          final index = entry.key;
          final text = entry.value;
          return HistoryItem(
            text: text,
            onEdit: () async {
              controller.text = text;
              reflections[index] = controller.text;
              await _saveReflections();
            },
            onDelete: () async {
              reflections.removeAt(index);
              await _saveReflections();
            },
          );
        }),
      ],
    );
  }
}
