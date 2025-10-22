import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; 
// Import Simple Icons dan Font Awesome sudah dihapus karena tidak digunakan
import '../utils/device_utils.dart'; // Asumsi file ini ada dan menyediakan getDeviceInfo()

// Data Link Sosial Media & Kontak
const Map<String, String> _developerInfo = {
  'github': 'https://github.com/Shofie070', // Ganti dengan link Anda
  'instagram': 'https://www.instagram.com/shofnotsoph?igsh=NGVhNHY0dGdmZDBv', // Ganti dengan link Anda
  'linkedin': 'https://www.linkedin.com/in/shofie-a-shafina-7867402b7?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app', // Ganti dengan link Anda
  'email': 'mailto:24111814070@mhs.unesa.ac.id?subject=Inquiry%20from%20App', // Ganti dengan email Anda
};

// Fungsi untuk meluncurkan URL
Future<void> _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch $url');
  }
}

// Widget Pembantu untuk Tombol Sosial Media
// Parameter 'icon' tetap dipertahankan untuk kompatibilitas, tapi tidak digunakan
Widget _buildSocialButton(IconData icon, String label, String url) {
  return InkWell(
    onTap: () => _launchURL(url),
    customBorder: const CircleBorder(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0), // Padding disesuaikan
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Widget Icon telah DIHAPUS di sini.
          
          // SizedBox(width: 8) juga dihapus karena tidak ada ikon
          
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    ),
  );
}

Widget buildAboutWidget() {
  // Asumsi fungsi getDeviceInfo() ada di ../utils/device_utils.dart
  return FutureBuilder<Map<String, String>>(
    future: getDeviceInfo(),
    builder: (context, snapshot) {
      final info = snapshot.data ?? {"model": "N/A", "version": "N/A"};

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
                Color(0xFF00695C), 
                Color(0xFF004D40), 
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
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

              // Bagian Info Aplikasi Statis
              Text(
                "Nama Aplikasi: Ruang Ekspresi\n"
                "Versi: 1.0.0\n"
                "Tanggal: ${DateFormat.yMMMMd().format(DateTime.now())}\n\n"
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

              const Divider(color: Colors.white38, height: 30),
              
              const Text(
                "Kontak Developer 🌸",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Bagian Sosial Media yang Hanya Berupa Teks
              Wrap(
                spacing: 16.0,
                runSpacing: 8.0,
                children: [
                  // Ikon diganti dengan Icons.circle_outlined sebagai placeholder untuk memenuhi fungsi _buildSocialButton
                  _buildSocialButton(Icons.circle_outlined, "Email", _developerInfo['email']!),
                  _buildSocialButton(Icons.circle_outlined, "GitHub", _developerInfo['github']!), 
                  _buildSocialButton(Icons.circle_outlined, "LinkedIn", _developerInfo['linkedin']!),
                  _buildSocialButton(Icons.circle_outlined, "Instagram", _developerInfo['instagram']!), 
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}