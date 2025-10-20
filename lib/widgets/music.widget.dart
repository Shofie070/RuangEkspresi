import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MusicWidget extends StatefulWidget {
  const MusicWidget({super.key});

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse("https://music.youtube.com/watch?v=EhO_MrRfftU&si=zsO4acXFV9wC5pFH"),
      );
  }

  @override
  void dispose() {
    // Hentikan WebView dengan memuat halaman kosong agar tidak crash saat dispose
    _controller.loadRequest(Uri.dataFromString('', mimeType: 'text/html'));

    // Jangan panggil _controller.clearCache(); karena bisa memicu assertion error
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Mencegah crash saat tombol back ditekan
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }
        return true;
      },
      child: Column(
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    await _controller.loadRequest(
                      Uri.parse("https://music.youtube.com/watch?v=EhO_MrRfftU&si=zsO4acXFV9wC5pFH"),
                    );
                  },
                  child: const Text("Klik di sini untuk membuka playlist 🎧"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 400,
              child: Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
