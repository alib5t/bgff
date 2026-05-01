import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_app.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Giriş Yap"),
          onPressed: () async {
            final sp = await SharedPreferences.getInstance();
            await sp.setBool("seenLogin", true);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainApp()),
            );
          },
        ),
      ),
    );
  }
}