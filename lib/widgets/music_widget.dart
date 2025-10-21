import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MusicWidget extends StatefulWidget {
  const MusicWidget({super.key});

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  // Hanya ambil ID video dari URL penuh Anda
  final String _videoId = "EhO_MrRfftU"; 
  
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
    
    // 1. Inisialisasi Controller YoutubePlayer
    _ytController = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: const YoutubePlayerFlags(
        // Diatur FALSE. Ini WAJIB untuk Web agar tidak diblokir browser.
        autoPlay: false, 
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    // Controller harus dibersihkan
    _ytController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Struktur Tampilan Tetap Sama
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade700.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "🎵 Pelukan Musik 🎵",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              
              // 2. Tombol Eksternal (Hanya untuk memicu Play)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Tombol ini mungkin tidak berfungsi di Web karena pembatasan browser.
                  // Pengguna mungkin harus mengklik langsung tombol Play di tengah video.
                  _ytController.play();
                },
                child: const Text("Klik di sini untuk membuka playlist 🎧"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // 3. Area Pemutar Video
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 400,
            // Widget yang berfungsi di Web, menggantikan WebViewWidget
            child: YoutubePlayer(
              controller: _ytController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.purpleAccent,
              progressColors: const ProgressBarColors(
                playedColor: Colors.purpleAccent,
                handleColor: Colors.purpleAccent,
              ),
              // Opsional: tampilkan loading indicator saat memuat
              bufferIndicator: const Center(child: CircularProgressIndicator(color: Colors.white)), 
            ),
          ),
        ),
      ],
    );
  }
}