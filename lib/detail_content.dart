import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview;
import 'package:intl/intl.dart';
import 'models/menu_model.dart';

/// 🔹 Pemilih detail berdasarkan menu
Widget buildDetailContent(MenuModel menu) {
  switch (menu.title) {
    case "Aku Hari Ini":
      return _buildToday();
    case "Ruang Refleksi":
      return _buildReflection();
    case "Pelukan Musik":
      return _buildMusic();
    case "Karya yang Bicara":
      return _buildGallery();
    case "About":
      return _buildAbout();
    default:
      return const Text("Detail tidak tersedia");
  }
}

/// 🔹 Halaman DetailPage dengan BottomNavigationBar
class DetailPage extends StatefulWidget {
  final MenuModel menu;

  const DetailPage({super.key, required this.menu});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _selectedIndex = 0;

  final List<String> _tabs = [
    "Aku Hari Ini",
    "Ruang Refleksi",
    "Pelukan Musik",
    "Karya yang Bicara",
    "About",
  ];

  @override
  Widget build(BuildContext context) {
    final menu = MenuModel(
      _tabs[_selectedIndex],
      "favorite", // Pass a string instead of IconData
      Colors.deepPurple,
      Icons.favorite, // Add the missing fourth argument (example: icon)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_selectedIndex]),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: buildDetailContent(menu),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: "Hari Ini",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Refleksi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Musik",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush),
            label: "Karya",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About",
          ),
        ],
      ),
    );
  }
}

/// Reusable List Item dengan Edit & Delete
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
      color: Colors.black26,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.amber),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

/// 🟣 Aku Hari Ini (Mood)
Widget _buildToday() {
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

/// 🔵 Ruang Refleksi
Widget _buildReflection() {
  final TextEditingController controller = TextEditingController();

  return FutureBuilder<List<String>>(
    future: _loadList("reflections"),
    builder: (context, snapshot) {
      final reflections = snapshot.data ?? [];

      return Column(
        children: [
          Card(
            color: Colors.blue.shade800,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tulis refleksimu 🌸",
                    style: TextStyle(color: Colors.white, fontSize: 18),
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
                      final updated = [...reflections, controller.text];
                      await _saveList("reflections", updated);
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
          if (reflections.isNotEmpty)
            ...reflections.asMap().entries.map((entry) {
              final index = entry.key;
              final text = entry.value;
              return HistoryItem(
                text: text,
                onEdit: () async {
                  controller.text = text;
                  reflections[index] = controller.text;
                  await _saveList("reflections", reflections);
                },
                onDelete: () async {
                  reflections.removeAt(index);
                  await _saveList("reflections", reflections);
                },
              );
            }),
        ],
      );
    },
  );
}

Widget _buildMusic() {
  final webview.WebViewController controller = webview.WebViewController()
    ..setJavaScriptMode(webview.JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://music.youtube.com/")); // ✅ LEBIH BAIK

  return Card(
    color: Colors.green.shade800,
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: SizedBox(height: 400, child: webview.WebViewWidget(controller: controller)),
  );
}


/// 🟠 Karya yang Bicara
Widget _buildGallery() {
  final TextEditingController controller = TextEditingController();

  return FutureBuilder<List<String>>(
    future: _loadList("gallery"),
    builder: (context, snapshot) {
      final works = snapshot.data ?? [];

      return Column(
        children: [
          Card(
            color: Colors.orange.shade800,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tulis karya atau draft baru ✨",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Tulis puisi, cerpen, atau ide kreatifmu...",
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
                      final updated = [...works, controller.text];
                      await _saveList("gallery", updated);
                      controller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Karya tersimpan!")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Simpan Karya"),
                  ),
                ],
              ),
            ),
          ),
          if (works.isNotEmpty)
            ...works.asMap().entries.map((entry) {
              final index = entry.key;
              final text = entry.value;
              return HistoryItem(
                text: text,
                onEdit: () async {
                  controller.text = text;
                  works[index] = controller.text;
                  await _saveList("gallery", works);
                },
                onDelete: () async {
                  works.removeAt(index);
                  await _saveList("gallery", works);
                },
              );
            }),
        ],
      );
    },
  );
}

/// 🟡 About
Widget _buildAbout() {
  return FutureBuilder<Map<String, String>>(
    future: _getDeviceInfo(),
    builder: (context, snapshot) {
      final info = snapshot.data ?? {"Device": "Unknown"};

      return Card(
        color: Colors.teal.shade800,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tentang Aplikasi",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                "Nama Aplikasi: Ruang Ekspresi\n"
                "Versi: 1.0.0\n"
                "Tanggal: ${DateFormat.yMMMMd().format(DateTime.now())}\n"
                "Developer: Shofie Ardhya Shafina 🌸\n\n"
                "Application Info: \n"
                "- Nama Aplikasi : Ruang Ekspresi\n"
                "- Platform: ${info["model"] ?? "Flutter"}\n"
                "- OS: ${info["version"] ?? "-"}",
                style: const TextStyle(color: Colors.white, height: 1.5),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// Utils untuk SharedPreferences
Future<List<String>> _loadList(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key) ?? [];
}

Future<void> _saveList(String key, List<String> data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(key, data);
}

Future<Map<String, String>> _getDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  return {
    "model": androidInfo.model,
    "version": androidInfo.version.release,
  };
}
