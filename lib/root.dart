import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  final AppBar? appBar;
  final Widget? body;

  const new({super.key, this.appBar, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: BottomNavigationBar(items: ),
    );
  }
}