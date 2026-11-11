import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flicksy/app/root.dart';
import 'package:flicksy/core/theme.dart';
import 'package:flicksy/screens/login_screen.dart';
import 'package:flicksy/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('favorites');
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
    _loginStatus = AuthService.isLoggedIn();
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
