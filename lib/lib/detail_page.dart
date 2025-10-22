import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ruang_ekspresi/widgets/music_widget.dart';
import 'package:ruang_ekspresi/widgets/reflection_widget.dart';
import 'package:ruang_ekspresi/widgets/today_widget.dart';
import 'package:ruang_ekspresi/widgets/about_widget.dart';
import 'package:ruang_ekspresi/widgets/karya_widget.dart';
import 'models/menu_model.dart';

class DetailPage extends StatelessWidget {
  final MenuModel menu;

  const DetailPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text(
          menu.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4B0082),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9AD0EC), // lebih terang agar kontras
              Color(0xFF4B0082)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GFCard(
              color: Colors.deepPurple.shade700.withOpacity(0.85), // ubah background card biar gak putih
              boxFit: BoxFit.cover,
              title: GFListTile(
                avatar: Icon(menu.icon, color: Colors.white, size: 36),
                title: Text(
                  menu.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subTitle: Text(
                  menu.subtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white), // semua teks dalam konten jadi putih
                  child: _buildContent(menu),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(MenuModel menu) {
    switch (menu.title) {
      case "Aku Hari Ini":
        return const TodayWidget();

      case "Ruang Refleksi":
        return ReflectionWidget(menu: menu);

      case "Karya yang Bicara":
        return KaryaWidget(menu: menu);

      case "Pelukan Musik":
        return const MusicWidget();

      case "About":
        return buildAboutWidget();

      case "Berita":
        return _buildNews();

      case "Galeri":
        return _buildGallery();

      case "Forum":
        return _buildForum();

      default:
        return const Text(
          "Detail tidak tersedia",
          style: TextStyle(color: Colors.white),
        );
    }
  }

  Widget _buildNews() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Update berita terbaru akan segera tersedia...",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildGallery() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Galeri karya akan segera ditampilkan...",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildForum() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Forum diskusi akan segera dibuka...",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
