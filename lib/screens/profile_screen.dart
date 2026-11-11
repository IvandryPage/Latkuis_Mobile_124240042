import 'package:flutter/material.dart';
import 'package:flicksy/screens/login_screen.dart';
import 'package:flicksy/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Future<String?> _username;

  @override
  void initState() {
    super.initState();
    _username = AuthService.getUsername();
  }

  Future<void> _logout(BuildContext context) async {
    final cleared = await AuthService.clearLogin();
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
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          elevation: 0,
          color: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: colors.secondary.withValues(alpha: 0.12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              children: [
                FutureBuilder<String?>(
                  future: _username,
                  builder: (context, snapshot) {
                    final username = snapshot.data?.trim();
                    final hasUsername = username != null && username.isNotEmpty;
                    final initial = hasUsername
                        ? username.characters.first.toUpperCase()
                        : '?';

                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: colors.secondary,
                          foregroundColor: colors.onSecondary,
                          child: Text(
                            initial,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          snapshot.hasError
                              ? 'Username tidak dapat dimuat'
                              : snapshot.connectionState != ConnectionState.done
                              ? 'Memuat profil...'
                              : hasUsername
                              ? username
                              : 'Username belum tersedia',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Profil pengguna',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.secondary.withValues(alpha: 0.72),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Kesan dan Pesan',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          color: colors.secondary.withValues(alpha: 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.format_quote, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Praktikum ini memberi saya pengalaman langsung dalam '
                    'membangun aplikasi dan memahami alur kerja pengembangan '
                    'perangkat lunak. Terima kasih atas bimbingan dan suasana '
                    'belajar yang menyenangkan. Semoga praktikum berikutnya '
                    'semakin seru dan bermanfaat!',
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        OutlinedButton.icon(
          onPressed: () => _logout(context),
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.error,
            side: BorderSide(color: colors.error.withValues(alpha: 0.5)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
