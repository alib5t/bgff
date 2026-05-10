import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // 🔥 BURADAN DEĞİŞTİRECEKSİN
  final String appName = "otistik videolar";
  final String bigText = "tiktok kopyası";

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 📌 ÜSTTE UYGULAMA İSMİ
            Text(
              appName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black,
              ),
            ),

            const Spacer(),

            // 📌 ORTADA BÜYÜK YAZI
            Text(
              bigText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black,
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}