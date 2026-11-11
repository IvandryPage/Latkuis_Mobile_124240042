import 'package:flutter/material.dart';
import 'package:flicksy/app/root.dart';
import 'package:flicksy/core/theme.dart';
import 'package:flicksy/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_usernameController.value.text == "124240042" &&
        _passwordController.value.text == "123") {
      final saved = await AuthService.saveLogin(
        _usernameController.value.text,
      );

      if (!mounted) return;

      if (saved) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (context) => const Root()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Status tidak tersimpan!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username atau Password salah!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Flicksy",
                style: TextStyle(
                  color: tertiaryColor,
                  fontFamily: 'cursive',
                  fontSize: 72,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                cursorColor: secondaryColor,
                style: const TextStyle(color: onPrimaryColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor,
                  hintText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: secondaryColor,
                  border: InputBorder.none,
                ),
                controller: _usernameController,
              ),
              const SizedBox(height: 16),
              TextField(
                cursorColor: secondaryColor,
                style: const TextStyle(color: onPrimaryColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: primaryColor,
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: secondaryColor,
                  border: InputBorder.none,
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tertiaryColor,
                    foregroundColor: onTertiaryColor,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
