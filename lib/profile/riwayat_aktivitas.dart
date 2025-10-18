import 'package:flutter/material.dart';

class RiwayatAktivitasPage extends StatelessWidget {
  const RiwayatAktivitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Aktivitas'),
      ),
      body: const Center(
        child: Text('Halaman Riwayat Aktivitas'),
      ),
    );
  }
}