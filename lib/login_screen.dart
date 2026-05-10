import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? imagePath;
  TextEditingController nameController = TextEditingController();

  // 📸 FOTO SEÇ
  Future<void> pickImage() async {
    var status = await Permission.photos.request();
    if (!status.isGranted) return;

    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      imagePath = file.path;
    });
  }

// 💾 KAYDET VE GİR
Future<void> saveAndEnter() async {
  final sp = await SharedPreferences.getInstance();

  await sp.setBool("seenLogin", true);
  await sp.setString("name", nameController.text);

  if (imagePath != null) {
    await sp.setString("img", imagePath!);
  }

  Navigator.pushReplacementNamed(context, "/home");
}

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // 🔹 GİRİŞ YAZISI
            Text(
              "Giriş Yap",
              style: TextStyle(
                fontSize: 22,
                color: dark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            // 🔹 PROFİL FOTO
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: imagePath != null
                    ? FileImage(File(imagePath!))
                    : const AssetImage("assets/images/default_profile.png")
                        as ImageProvider,
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 İSİM ALANI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "İsim gir",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 KAYDET BUTONU
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: saveAndEnter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Kaydet",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}