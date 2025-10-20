import 'package:flutter/material.dart';

class RiwayatAktivitasPage extends StatelessWidget {
  const RiwayatAktivitasPage({super.key});

  final List<Map<String, String>> aktivitas = const [
    {"judul": "Mengunggah Karya", "tanggal": "10 Oktober 2025"},
    {"judul": "Mengisi Refleksi Mingguan", "tanggal": "8 Oktober 2025"},
    {"judul": "Mengupdate Profil", "tanggal": "5 Oktober 2025"},
    {"judul": "Login ke Aplikasi", "tanggal": "1 Oktober 2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0082), // Ungu
      appBar: AppBar(
        title: const Text("Riwayat Aktivitas"),
        backgroundColor: const Color(0xFF1976D2), // Biru
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: aktivitas.length,
        itemBuilder: (context, index) {
          final item = aktivitas[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2E2E42),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              leading: const Icon(Icons.history, color: Colors.deepPurpleAccent, size: 32),
              title: Text(item['judul']!, 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              subtitle: Text(item['tanggal']!, 
                  style: const TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
            ),
          );
        },
      ),
    );
  }
}