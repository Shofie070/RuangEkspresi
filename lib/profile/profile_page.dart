import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruang_ekspresi/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImagePath;
  String _description = "Belum ada deskripsi diri.";
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileImagePath = prefs.getString('profileImagePath');
      _description = prefs.getString('profileDescription') ?? "Belum ada deskripsi diri.";
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profileImagePath', pickedFile.path);

        setState(() {
          _profileImagePath = pickedFile.path;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Foto profil berhasil diubah! 📸"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal memilih gambar"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // === NON-AKTIFKAN DULU NAVIGASI KE HALAMAN LAIN ===
  void _openEditProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Edit Profil - Coming Soon! 🚀")),
    );
  }

  void _openRiwayatAktivitas() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Riwayat Aktivitas - Coming Soon! 🚀")),
    );
  }

  void _openKredensial() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Kredensial - Coming Soon! 🚀")),
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  Widget _buildButton(IconData icon, String label, VoidCallback onTap,
      {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isLogout ? Colors.red.shade400 : const Color(0xFF5E35B1).withOpacity(0.9),
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
        leading: Icon(icon,
            color: Colors.white,
            size: 32),
        title: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: isLogout
            ? null
            : Text(
                "Kelola ${label.toLowerCase()} Anda",
                style: const TextStyle(color: Colors.white70),
              ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0082),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 4,
        title: const Text(
          "Profil Saya",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 30, top: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: _profileImagePath != null
                            ? FileImage(File(_profileImagePath!))
                            : const AssetImage('assets/profile.png') as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1976D2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.username,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Online • Ruang Ekspresi",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade300,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5E35B1).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.white70, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildButton(Icons.edit, "Edit Profil", _openEditProfile),
          _buildButton(Icons.history, "Riwayat Aktivitas", _openRiwayatAktivitas),
          _buildButton(Icons.key, "Kredensial", _openKredensial),
          const SizedBox(height: 10),
          _buildButton(Icons.logout, "Logout", _logout, isLogout: true),
        ],
      ),
    );
  }
}