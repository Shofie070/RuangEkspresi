// KredensialPage.dart
import 'package:flutter/material.dart';

class KredensialPage extends StatefulWidget {
  final String username;
  final String email;
  final String password; // MENERIMA DATA DARI PROFILE PAGE

  const KredensialPage({
    super.key, 
    required this.username, 
    required this.email,
    required this.password, 
  });

  @override
  State<KredensialPage> createState() => _KredensialPageState();
}

class _KredensialPageState extends State<KredensialPage> {
  // STATE UNTUK MENGONTROL VISIBILITAS PASSWORD
  bool _isPasswordVisible = false;

  Widget _buildInfoRow(String label, String value, {bool isPassword = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E42),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          
          Expanded( 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  // MENGGUNAKAN NILAI DARI ARGUMEN WIDGET (EMAIL/PASSWORD LOGIN)
                  isPassword
                      ? (_isPasswordVisible ? value : "••••••••")
                      : value, 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                
                // TOMBOL TOGGLE (MATA)
                if (isPassword)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0082), // Ungu
      appBar: AppBar(
        title: const Text('Kredensial Akun'),
        backgroundColor: const Color(0xFF1976D2), // Biru
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // USERNAME
            _buildInfoRow("Nama Pengguna", widget.username),
            const SizedBox(height: 15),
            
            // EMAIL DARI LOGIN
            _buildInfoRow("Email", widget.email), 
            const SizedBox(height: 15),
            
            // PASSWORD DARI LOGIN DENGAN IKON MATA
            _buildInfoRow("Kata Sandi", widget.password, isPassword: true), 
            const SizedBox(height: 35),
            
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fitur ubah kata sandi akan segera hadir!")),
                  );
                },
                icon: const Icon(Icons.lock_reset, color: Colors.white),
                label: const Text("Ubah Kata Sandi", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}