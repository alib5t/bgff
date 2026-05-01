import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String? image;

  TextEditingController c = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final sp = await SharedPreferences.getInstance();
    name = sp.getString("name") ?? "";
    image = sp.getString("img");
    c.text = name;
    setState(() {});
  }

  pickImage() async {
    var status = await Permission.photos.request();
    if (!status.isGranted) return;

    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final sp = await SharedPreferences.getInstance();
    await sp.setString("img", file.path);

    setState(() => image = file.path);
  }

  save() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString("name", c.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Text("Profil", style: TextStyle(fontSize: 22)),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: pickImage,
            child: CircleAvatar(
              radius: 55,
              backgroundImage: image != null
                  ? FileImage(File(image!))
                  : const AssetImage("assets/images/default_profile.png")
                      as ImageProvider,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(controller: c),
          ),

          ElevatedButton(onPressed: save, child: const Text("Kaydet")),
        ],
      ),
    );
  }
}