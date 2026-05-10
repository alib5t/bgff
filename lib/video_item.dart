import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String path;
  final bool isActive;

  const VideoItem({
    super.key,
    required this.path,
    required this.isActive,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController controller;
  bool initialized = false;

@override
void initState() {
  super.initState();

  controller = VideoPlayerController.asset(widget.path);

  controller.initialize().then((_) async {

    await controller.setLooping(true);

    if (widget.isActive) {
      await controller.play();
    }

    if (mounted) {
      setState(() {
        initialized = true;
      });
    }
  });
}

@override
void didUpdateWidget(covariant VideoItem oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (!initialized) return;

  if (widget.isActive) {
    controller.play();
  } else {
    controller.pause();
  }
}

  void togglePlay() {
    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePlay, // 📌 dokun → dur / devam

      child: Container(
        color: Colors.black,
        child: Center(
          child: initialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height
                    child: VideoPlayer(controller),
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}