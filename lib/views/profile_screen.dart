import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/auth_preferences.dart';
import 'package:latres_mobile_124240042/views/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final cleared = await AuthPreferences.clearLogin();
    if (!context.mounted) return;
    if (cleared) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Status login tidak terhapus!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Username",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          FutureBuilder<String?>(
            future: AuthPreferences.getUsername(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Username tidak dapat dimuat!");
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }
              return Text(snapshot.data ?? "Username belum tersedia");
            },
          ),
          const SizedBox(height: 24),
          const Text(
            "Saran dan Kesan",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
            "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
