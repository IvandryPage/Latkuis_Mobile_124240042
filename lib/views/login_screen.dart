import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/root.dart';
import 'package:latres_mobile_124240042/theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin(BuildContext context) {
    if (_usernameController.value.text == "124240042" &&
        _passwordController.value.text == "124240042") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (context) => const Root()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid username or password")),
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
                  onPressed: () => _handleLogin(context),
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
