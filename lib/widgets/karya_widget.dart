import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ruang_ekspresi/models/menu_model.dart';

class KaryaWidget extends StatefulWidget {
  final MenuModel menu;
  const KaryaWidget({super.key, required this.menu});

  @override
  State<KaryaWidget> createState() => _KaryaWidgetState();
}

class _KaryaWidgetState extends State<KaryaWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Map<String, String>> karyaList = [];
  List<Map<String, String>> draftList = [];

  @override
  void initState() {
    super.initState();
    _loadKarya();
  }

  Future<void> _loadKarya() async {
    final prefs = await SharedPreferences.getInstance();
    final karyaData = prefs.getStringList("karya_${widget.menu.title}") ?? [];
    final draftData = prefs.getStringList("draft_${widget.menu.title}") ?? [];

    setState(() {
      karyaList = karyaData.map((e) {
        final parts = e.split("||");
        return {"title": parts[0], "content": parts[1], "date": parts[2]};
      }).toList();

      draftList = draftData.map((e) {
        final parts = e.split("||");
        return {"title": parts[0], "content": parts[1], "date": parts[2]};
      }).toList();
    });
  }

  Future<void> _saveKarya() async {
    final prefs = await SharedPreferences.getInstance();
    final karyaData = karyaList
        .map((e) => "${e['title']}||${e['content']}||${e['date']}")
        .toList();
    await prefs.setStringList("karya_${widget.menu.title}", karyaData);
    _loadKarya();
  }

  Future<void> _saveDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final draftData = draftList
        .map((e) => "${e['title']}||${e['content']}||${e['date']}")
        .toList();
    await prefs.setStringList("draft_${widget.menu.title}", draftData);
    _loadKarya();
  }

  void _handleSave({required bool isDraft}) async {
    if (_contentController.text.trim().isEmpty) return;
    final newKarya = {
      "title": _titleController.text.isEmpty
          ? "Tanpa Judul"
          : _titleController.text.trim(),
      "content": _contentController.text.trim(),
      "date": DateFormat('d MMM yyyy, HH:mm').format(DateTime.now()),
    };

    if (isDraft) {
      draftList.add(newKarya);
      await _saveDraft();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Karya disimpan sebagai draft ✏️")),
      );
    } else {
      karyaList.add(newKarya);
      await _saveKarya();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Karya berhasil diunggah 🌸")),
      );
    }

    _titleController.clear();
    _contentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: widget.menu.bgColor.withOpacity(0.8),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Karya yang Bicara 🎨 (${widget.menu.title})",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Judul Karya",
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _contentController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Tulis isi karya kamu di sini...",
                    hintStyle: TextStyle(color: Colors.grey[300]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _handleSave(isDraft: true),
                      icon: const Icon(Icons.save_alt),
                      label: const Text("Simpan Draft"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade300,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _handleSave(isDraft: false),
                      icon: const Icon(Icons.cloud_upload_outlined),
                      label: const Text("Upload Karya"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ✅ Tampilkan Draft
        if (draftList.isNotEmpty) ...[
          const SizedBox(height: 10),
          const Text(
            "📄 Draft Karyamu",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          ...draftList.map((d) => _buildKaryaCard(d, isDraft: true)),
        ],

        // ✅ Tampilkan Karya yang Diunggah
        if (karyaList.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            "🌸 Karya yang Sudah Diunggah",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          ...karyaList.map((k) => _buildKaryaCard(k, isDraft: false)),
        ],
      ],
    );
  }

  Widget _buildKaryaCard(Map<String, String> data, {required bool isDraft}) {
    return Card(
      color: isDraft ? Colors.white70 : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          data["title"] ?? "Tanpa Judul",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(data["content"] ?? ""),
            const SizedBox(height: 4),
            Text(
              data["date"] ?? "",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () async {
            if (isDraft) {
              draftList.remove(data);
              await _saveDraft();
            } else {
              karyaList.remove(data);
              await _saveKarya();
            }
          },
        ),
      ),
    );
  }
}
