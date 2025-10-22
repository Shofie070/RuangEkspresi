import 'package:flutter/material.dart';

/// 🔹 Parent class dengan enkapsulasi
class MenuModel {
  String title;
  String _description;
  Color _bgColor;
  String? _imagePath;
  String _subtitle;
  IconData _icon;

  /// 🔹 Constructor
  MenuModel(
    this.title,
    String description,
    this._bgColor,
    this._icon, [
    this._imagePath,
    this._subtitle = "",
  ]) : _description = description;

  /// 🔹 Getter
  String get description => _description;
  Color get bgColor => _bgColor;
  String? get imagePath => _imagePath;
  String get subtitle => _subtitle;
  IconData get icon => _icon;

  /// 🔹 Setter
  set description(String value) => _description = value;
  set bgColor(Color value) => _bgColor = value;
  set imagePath(String? value) => _imagePath = value;
  set subtitle(String value) => _subtitle = value;
  set icon(IconData value) => _icon = value;

  /// 🔹 Polymorphism: method bisa dioverride oleh subclass
  String getDetail() => _description;
}

/// 🔹 Subclass (contoh Inheritance + Polymorphism)
class SpecialMenuModel extends MenuModel {
  final String extraNote;

  SpecialMenuModel(
    String title,
    String description,
    Color bgColor,
    IconData icon,
    this.extraNote, [
    String? image,
  ]) : super(title, description, bgColor, icon, image);

  @override
  String getDetail() => "${super.getDetail()}\nCatatan: $extraNote";
}

/// ✅ List data menu
List<MenuModel> menuList = [
  MenuModel(
    "Aku Hari Ini",
    "Catat ekspresimu setiap hari di sini.",
    Colors.deepPurple, // 🔹 Lebih gelap biar teks kontras
    Icons.edit,
    "assets/logo.jpeg",
    "Menjadi cermin emosi harian",
  ),
  MenuModel(
    "Ruang Refleksi",
    "Ruang untuk merenung dan memahami diri.",
    Colors.indigo, // 🔹 Lebih pekat daripada biru biasa
    Icons.self_improvement,
    null,
    "Memberi tempat untuk menata pikiran",
  ),
  SpecialMenuModel(
    "Pelukan Musik",
    "Dengarkan musik untuk menenangkan hati.",
    Colors.teal.shade700, // 🔹 Hijau tua tapi masih lembut
    Icons.music_note,
    "Musik favorit ditambahkan setiap minggu.",
  ),
  MenuModel(
    "Karya yang Bicara",
    "Bagikan karya tulisan atau gambarmu.",
    Colors.orange.shade700, // 🔹 Oranye agak tua supaya nggak silau
    Icons.brush,
    null,
    "Diam pun bisa menyampaikan",
  ),
  MenuModel(
    "About",
    "Informasi aplikasi dan pembuat.",
    Colors.cyan.shade800, // 🔹 Teal diganti cyan tua biar teks kebaca
    Icons.info,
    null,
    "Tentang aplikasi & developer",
  ),
];
