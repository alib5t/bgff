import 'package:flutter/material.dart';
import 'video_item.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final PageController controller = PageController();

  // 📌 SIRALI 1 → 60 VİDEO
  final List<String> videos = List.generate(
    60,
    (i) => "assets/videos/${i + 1}.mp4",
  );

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: videos.length,

        // 📌 hangi video ekranda
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        itemBuilder: (context, index) {
          return VideoItem(
            path: videos[index],
            isActive: index == currentIndex, // 🔥 sadece bu oynar
          );
        },
      ),
    );
  }
}