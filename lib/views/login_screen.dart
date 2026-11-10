import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
