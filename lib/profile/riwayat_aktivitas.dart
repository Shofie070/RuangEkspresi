import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. UBAH MENJADI STATEFULWIDGET
class RiwayatAktivitasPage extends StatefulWidget {
  const RiwayatAktivitasPage({super.key});

  @override
  State<RiwayatAktivitasPage> createState() => _RiwayatAktivitasPageState();
}

class _RiwayatAktivitasPageState extends State<RiwayatAktivitasPage> {
  // 2. DATA TIDAK LAGI STATIS (HARDCODED)
  List<Map<String, String>> _aktivitasList = [];

  // DAFTAR KUNCI SHAREDPREFERENCES YANG INGIN DITAMPILKAN
  final List<String> _dataKeys = const [
    "moods",
    "reflections_Ruang Ekspresi", // Asumsi ini adalah kunci refleksi yang tersimpan
    "reflections_Ruang Kreativitas",
  ];
  
  // 3. MUAT DATA DARI SHAREDPREFERENCES SAAT INITSTATE
  @override
  void initState() {
    super.initState();
    _loadAllActivities();
  }

  // FUNGSI BARU: MEMUAT SEMUA DATA DARI BEBERAPA KUNCI
  Future<void> _loadAllActivities() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> tempActivities = [];

    for (String key in _dataKeys) {
      final List<String>? entries = prefs.getStringList(key);
      if (entries != null && entries.isNotEmpty) {
        // Asumsi data yang tersimpan adalah teks. Kita buat log-nya.
        String activityTitle = (key == "moods") ? "Mencatat Mood" : "Menulis Refleksi (${key.split('_').last})";
        
        for (String entry in entries) {
          // Anda mungkin ingin menambahkan timestamp di sini,
          // tapi karena data yang tersimpan hanya teks, kita gunakan tanggal hari ini sebagai placeholder
          tempActivities.add({
            "judul": "$activityTitle: $entry",
            "tanggal": "Tersimpan pada ${DateTime.now().day}/${DateTime.now().month}",
          });
        }
      }
    }
    
    // Sortir aktivitas (misalnya berdasarkan judul, atau tambahkan timestamp sungguhan)
    // Saat ini, kita hanya menampilkan data yang dimuat.
    
    if (mounted) {
      setState(() {
        _aktivitasList = tempActivities.reversed.toList(); // Tampilkan yang terbaru di atas
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0082),
      appBar: AppBar(
        title: const Text(
          "Riwayat Aktivitas",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 4,
        // Tombol refresh untuk memuat ulang data secara manual
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAllActivities,
          ),
        ],
      ),
      body: _aktivitasList.isEmpty
          ? const Center(
              child: Text(
                "Belum ada aktivitas yang tersimpan.",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _aktivitasList.length,
              itemBuilder: (context, index) {
                final item = _aktivitasList[index];
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
                  ),
                );
              },
            ),
    );
  }
}