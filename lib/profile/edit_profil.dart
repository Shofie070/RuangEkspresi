import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  
  const EditProfilePage({
    super.key,
    required this.username,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  String? _imagePath;
  String _currentDescription = "";
  String _currentName = "";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _loadCurrentProfile();
  }

  Future<void> _loadCurrentProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentName = prefs.getString('profileName') ?? widget.username;
      _currentDescription = prefs.getString('profileDescription') ?? "Belum ada deskripsi diri.";
      _imagePath = prefs.getString('profileImagePath');
      
      _nameController.text = _currentName;
      _descController.text = _currentDescription;
    });
  }

  Future<void> _saveChanges() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileName', _nameController.text);
    await prefs.setString('profileDescription', _descController.text);
    if (_imagePath != null) {
      await prefs.setString('profileImagePath', _imagePath!);
    }
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0082), // Ungu
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2), // Biru
        title: const Text("Edit Profil", style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: _imagePath != null
                  ? (kIsWeb
                      ? NetworkImage(_imagePath!)
                      : FileImage(File(_imagePath!)) as ImageProvider)
                  : const AssetImage("assets/profile.png") as ImageProvider,
            ),
            const SizedBox(height: 10),
            const Text(
              "Foto Profil",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
            
            // Nama Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nama",
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: const Color(0xFF2E2E42),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            
            // Deskripsi Field
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Deskripsi Diri",
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: const Color(0xFF2E2E42),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            
            // Tombol Simpan
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Simpan Perubahan",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}