import 'package:flutter/material.dart';
import 'package:latres_mobile_124240042/auth_preferences.dart';
import 'package:latres_mobile_124240042/root.dart';
import 'package:latres_mobile_124240042/theme.dart';
import 'package:latres_mobile_124240042/views/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final Future<bool> _loginStatus;

  @override
  void initState() {
    super.initState();
    _loginStatus = AuthPreferences.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: FutureBuilder<bool>(
        future: _loginStatus,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Unable to load login status: ${snapshot.error}'),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data! ? const Root() : LoginScreen();
        },
      ),
    );
  }
}
