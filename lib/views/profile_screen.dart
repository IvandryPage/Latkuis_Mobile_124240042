import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/auth_preferences.dart';
import 'package:latres_mobile_124240042/views/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const new({super.key});

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
        const SnackBar(content: Text("Unable to clear login status")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _logout(context),
        child: const Text("Logout"),
      ),
    );
  }
}
