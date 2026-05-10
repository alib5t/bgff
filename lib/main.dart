import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';
import 'main_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const MainApp(),
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool? first;

  @override
  void initState() {
    super.initState();
    check();
  }

  check() async {
    final sp = await SharedPreferences.getInstance();
    bool seen = sp.getBool("seenLogin") ?? false;

    setState(() {
      first = !seen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (first == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (first == true) {
      return const LoginScreen();
    }

    return const MainApp();
  }
}
