import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImagePath;
  String _description = "Belum ada deskripsi diri.";
  final TextEditingController _descController = TextEditingController();

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
      _descController.text = _description;
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileDescription', _description);
    if (_profileImagePath != null) {
      await prefs.setString('profileImagePath', _profileImagePath!);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _profileImagePath = picked.path);
      _saveProfileData();
    }
  }

  void _editDescription() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF4B0082),
        title: const Text(
          "Edit Deskripsi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: _descController,
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Tulis sesuatu tentang dirimu...",
            hintStyle: TextStyle(color: Colors.white54),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _description = _descController.text;
              });
              _saveProfileData();
              Navigator.pop(context);
            },
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  void _editProfile() {
    // Dialog sederhana untuk ganti nama user (opsional)
    TextEditingController nameController = TextEditingController(text: widget.username);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF4B0082),
        title: const Text(
          "Edit Profil",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: nameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: "Nama",
            labelStyle: TextStyle(color: Colors.white70),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // bisa diatur nanti untuk menyimpan perubahan username ke database/local
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0082),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        title: const Text("Profil", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: _profileImagePath != null
                    ? FileImage(File(_profileImagePath!))
                    : const AssetImage("assets/profile.png") as ImageProvider,
                backgroundColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _editDescription,
              child: Text(
                _description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            // 🟣 Tombol "Edit Profil" ditambahkan di sini
            _buildButton(Icons.edit, "Edit Profil", _editProfile),

            _buildButton(Icons.notifications, "Notifikasi", () {}),
            _buildButton(Icons.settings, "Pengaturan", () {}),
            _buildButton(Icons.logout, "Logout", _logout, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String text, VoidCallback onTap, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isLogout ? Colors.redAccent : const Color(0xFF1976D2),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        onPressed: onTap,
      ),
    );
  }
}
