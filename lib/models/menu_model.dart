import 'package:flutter/material.dart';

// Parent class dengan enkapsulasi
class MenuModel {
  String title;
  String _description;
  Color _bgColor;
  String? _imagePath;
  String _subtitle;
  IconData _icon;

  // Constructor
  MenuModel(
    this.title,
    this._description,
    this._bgColor,
    this._icon, [
    this._imagePath,
    this._subtitle = "",
  ]);
  String get description => _description;
  Color get bgColor => _bgColor;
  String? get imagePath => _imagePath;
  String get subtitle => _subtitle;
  IconData get icon => _icon;
  set description(String v) => _description = v;
  set bgColor(Color v) => _bgColor = v;
  set imagePath(String? v) => _imagePath = v;
  set subtitle(String v) => _subtitle = v;
  set icon(IconData v) => _icon = v;

  // Polymorphism: method bisa dioverride oleh subclass
  String getDetail() => _description;
}

// Subclass (contoh Inheritance + Polymorphism)
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

// ✅ List data menu
List<MenuModel> menuList = [
  MenuModel(
    "Aku Hari Ini",
    "Catat ekspresimu setiap hari di sini.",
    Colors.purple,
    Icons.edit,
    "assets/logo.jpeg",
    "Menjadi cermin emosi harian",
  ),
  MenuModel(
    "Ruang Refleksi",
    "Ruang untuk merenung dan memahami diri.",
    Colors.blue,
    Icons.self_improvement,
    null,
    "Memberi tempat untuk menata pikiran",
  ),
  SpecialMenuModel(
    "Pelukan Musik",
    "Dengarkan musik untuk menenangkan hati.",
    Colors.green,
    Icons.music_note,
    "Musik favorit ditambahkan setiap minggu.",
  ),
  MenuModel(
    "Karya yang Bicara",
    "Bagikan karya tulisan atau gambarmu.",
    Colors.orange,
    Icons.brush,
    null,
    "Diam pun bisa menyampaikan",
  ),
  MenuModel(
    "About",
    "Informasi aplikasi dan pembuat.",
    Colors.teal,
    Icons.info,
    null,
    "Tentang aplikasi & developer",
  ),
];
