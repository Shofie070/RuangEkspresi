import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ruang_ekspresi/profile/edit_profil.dart';
import 'package:ruang_ekspresi/profile/kredensial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './riwayat_aktivitas.dart'; 

// Asumsi: Anda memiliki halaman LoginPage di path '../login.dart'
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Halaman Login")),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImagePath;
  String _description = "Memuat..."; 
  // Ganti widget.username dengan _userName agar bisa di-update
  String _userName = "Memuat..."; 

  final ImagePicker _imagePicker = ImagePicker();
  
  // VARIABLE UNTUK MENYIMPAN DATA LOGIN (MEMUAT DARI SHAREDPREFERENCES)
  String _userEmail = "Memuat..."; 
  String _userPassword = "Memuat...";

  @override
  void initState() {
    super.initState();
    // Awalnya, gunakan username dari argumen widget
    _userName = widget.username; 
    _loadProfileData();
    _loadKredensialData(); 
  }
  
  // FUNGSI UNTUK MEMUAT EMAIL DAN PASSWORD DARI SHAREDPREFERENCES
  Future<void> _loadKredensialData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _userEmail = prefs.getString('userEmail') ?? 'Email tidak ditemukan'; 
      _userPassword = prefs.getString('userPassword') ?? 'Password tidak ditemukan'; 
    });
  }

  // FUNGSI DITINGKATKAN: MEMUAT NAMA DAN DESKRIPSI
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      // Ambil nama dari 'profileName' (disimpan di EditProfilePage)
      _userName = prefs.getString('profileName') ?? widget.username; 
      _profileImagePath = prefs.getString('profileImagePath');
      _description = prefs.getString('profileDescription') ?? "Belum ada deskripsi diri.";
    });
  }

  // >>> FUNGSI _pickImage YANG LENGKAP <<<
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

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Foto profil berhasil diubah! 📸"),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal memilih gambar"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // >>> FUNGSI _openEditProfile SUDAH DIKOREKSI UNTUK NAVIGASI <<<
  void _openEditProfile() async {
    if (context.mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EditProfilePage(
            username: _userName, // Kirim nama yang sedang aktif
          ),
        ),
      );
      // MEMUAT ULANG DATA SETELAH KEMBALI DARI EDIT PROFILE PAGE
      _loadProfileData(); 
    }
  }

  void _openRiwayatAktivitas() {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RiwayatAktivitasPage()),
      );
    }
  }

  // MENGIRIM EMAIL DAN PASSWORD YANG SUDAH DI-LOAD KE KredensialPage
  void _openKredensial() {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => KredensialPage(
            username: _userName, // Ganti widget.username ke _userName
            email: _userEmail,      
            password: _userPassword, 
          ),
        ),
      );
    }
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
      // Mengarahkan ke halaman Login (Asumsi LoginPage ada di path yang benar)
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  // >>> WIDGET _buildButton LENGKAP <<<
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
                      // >>> CircleAvatar LENGKAP <<<
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: _profileImagePath != null
                            ? FileImage(File(_profileImagePath!))
                            : const AssetImage('assets/profile.png') as ImageProvider, // ASUMSI PATH DEFAULT PROFILE
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
                  _userName, // Ganti widget.username ke _userName
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