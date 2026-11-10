import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/theme.dart';
import 'package:latres_mobile_124240042/views/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme, home: const LoginScreen());
  }
}
