import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/detail_page.dart';
import 'package:flutter_application_1/models/menu_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile/profile_page.dart';

class DashboardPage extends StatefulWidget {
  final String username;
  const DashboardPage({super.key, required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath = prefs.getString('profileImagePath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0082), // ungu
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2), // biru
        elevation: 4,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: _profileImagePath != null
                  ? FileImage(File(_profileImagePath!))
                  : const AssetImage("assets/profile.png") as ImageProvider,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(username: widget.username),
                ),
              );
              // refresh foto setelah kembali dari profile page
              _loadProfileImage();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔹 Logo + Nama Aplikasi + Salam
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 30, top: 20),
            child: Column(
              children: [
                Image.asset("assets/logo.jpeg", height: 100),
                const SizedBox(height: 10),
                const Text(
                  "Ruang Ekspresi",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Selamat datang, ${widget.username} 🌸",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),

          // 🔹 List menu dari model
          ...menuList.map((menu) => _buildMenuCard(context, menu)),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, MenuModel menu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: menu.bgColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
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
        leading: Icon(menu.icon, color: Colors.black, size: 32),
        title: Text(
          menu.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          menu.subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(menu: menu),
            ),
          );
        },
      ),
    );
  }
}
