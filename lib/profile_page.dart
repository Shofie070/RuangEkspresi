import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background gradasi ungu → biru lembut
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5E2B97), Color(0xFF3F51B5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                // Avatar & nama user
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                  backgroundColor: Color(0xFF7B5EDB),
                ),
                const SizedBox(height: 16),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Flutter Developer | UI/UX Enthusiast",
                  style: TextStyle(color: Color(0xFFE0D6FF)),
                ),
                const SizedBox(height: 25),

                // Statistik ringkas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _StatCard(title: "Projects", value: "12"),
                    _StatCard(title: "Followers", value: "320"),
                    _StatCard(title: "Following", value: "180"),
                  ],
                ),

                const SizedBox(height: 25),

                // Kolom putih transparan berisi action card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _ProfileActionButton(
                        icon: Icons.edit,
                        label: "Edit Profile",
                        onTap: () {},
                      ),
                      _ProfileActionButton(
                        icon: Icons.notifications_active,
                        label: "Notifications",
                        onTap: () {},
                      ),
                      _ProfileActionButton(
                        icon: Icons.settings,
                        label: "Settings",
                        onTap: () {},
                      ),
                      _ProfileActionButton(
                        icon: Icons.color_lens,
                        label: "Theme Customization",
                        onTap: () {},
                      ),
                      _ProfileActionButton(
                        icon: Icons.logout,
                        label: "Log Out",
                        color: Colors.redAccent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Footer
                const Text(
                  "App version 1.0.0",
                  style: TextStyle(
                    color: Color(0xFFCEC8FF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE0D6FF),
          ),
        ),
      ],
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  const _ProfileActionButton({
    required this.icon,
    required this.label,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.25),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.white),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: color ?? Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
        onTap: onTap,
      ),
    );
  }
}
