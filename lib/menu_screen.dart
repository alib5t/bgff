import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController appName = TextEditingController();
  TextEditingController bigText = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final sp = await SharedPreferences.getInstance();
    appName.text = sp.getString("appName") ?? "Uygulama";
    bigText.text = sp.getString("bigText") ?? "Merhaba";
    setState(() {});
  }

  save() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString("appName", appName.text);
    await sp.setString("bigText", bigText.text);
  }

  @override
  Widget build(BuildContext context) {
    bool dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: dark ? Colors.black : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            TextField(controller: appName),
            TextField(controller: bigText),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: const Text("Kaydet")),
            const Spacer(),
            Text(
              bigText.text,
              style: TextStyle(
                fontSize: 28,
                color: dark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}