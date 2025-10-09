import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'models/menu_model.dart';
import 'detail_content.dart';

class DetailPage extends StatelessWidget {
  final MenuModel menu;

  const DetailPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text(menu.title),
        centerTitle: true,
        backgroundColor: const Color(0xFF4B0082),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF87CEEB), Color(0xFF4B0082)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GFCard(
              boxFit: BoxFit.cover,
              title: GFListTile(
                avatar: Icon(menu.icon, color: Colors.white, size: 36),
                titleText: menu.title,
                subTitleText: menu.subtitle,
              ),
              content: buildDetailContent(menu),
            ),
          ],
        ),
      ),
    );
  }
}
