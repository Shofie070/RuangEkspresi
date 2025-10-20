import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/device_utils.dart';

Widget buildAboutWidget() {
  return FutureBuilder<Map<String, String>>(
    future: getDeviceInfo(),
    builder: (context, snapshot) {
      final info = snapshot.data ?? {"Device": "Unknown"};

      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF00695C), // lebih gelap dari teal.shade800
                Color(0xFF004D40), // deep teal
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tentang Aplikasi",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black54,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Nama Aplikasi: Ruang Ekspresi\n"
                "Versi: 1.0.0\n"
                "Tanggal: ${DateFormat.yMMMMd().format(DateTime.now())}\n"
                "Developer: Shofie Ardhya Shafina 🌸\n\n"
                "Platform: ${info["model"] ?? "Flutter"}\n"
                "OS: ${info["version"] ?? "-"}",
                style: const TextStyle(
                  color: Colors.white,
                  height: 1.6,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black45,
                      offset: Offset(0.5, 0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
