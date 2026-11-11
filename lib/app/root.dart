import 'package:flutter/material.dart';
import 'package:flicksy/services/favorite_service.dart';
import 'package:flicksy/screens/favorite_screen.dart';
import 'package:flicksy/screens/home_screen.dart';
import 'package:flicksy/screens/profile_screen.dart';

class Root extends StatefulWidget {
  const new({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  final FavoriteService _favoriteService = FavoriteService();

  late final List<Widget> pages = [
    HomeScreen(favoriteService: _favoriteService),
    FavoriteScreen(favoriteService: _favoriteService),
    ProfileScreen(),
  ];

  final List<String> _pageTitles = ["Beranda", "Favorit", "Profil"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentIndex]),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
