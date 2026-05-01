import 'package:flutter/material.dart';

import 'menu_screen.dart';
import 'video_screen.dart';
import 'profile_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int index = 1;

  final pages = const [
    MenuScreen(),
    VideoScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menü"),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}