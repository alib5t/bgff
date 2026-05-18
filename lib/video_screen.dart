import 'package:flutter/material.dart';
import 'video_item.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late final PageController controller;

  int currentIndex = 0;

  final List<String> videos = List.generate(
    60,
    (i) => "assets/videos/${i + 1}.mp4",
  );

  @override
  void initState() {
    super.initState();

    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [

          PageView.builder(
            controller: controller,
            scrollDirection: Axis.vertical,
            itemCount: videos.length,

            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            itemBuilder: (context, index) {

              return VideoItem(
                path: videos[index],
                isActive: currentIndex == index,
              );
            },
          ),

          Positioned(
            top: 50,
            left: 15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
