import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

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

  late final Player player;
  late final VideoController controller;

  bool initialized = false;

  @override
  void initState() {
    super.initState();

    player = Player();

    controller = VideoController(player);

    player.open(
      Media(widget.path),
      play: false,
    );

    player.setPlaylistMode(PlaylistMode.loop);

    Future.delayed(const Duration(milliseconds: 300), () {

      if (!mounted) return;

      setState(() {
        initialized = true;
      });

      if (widget.isActive) {
        player.play();
      }
    });
  }

  @override
  void didUpdateWidget(covariant VideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!initialized) return;

    if (widget.isActive) {
      player.play();
    } else {
      player.pause();
    }
  }

  void togglePause() {

    if (player.state.playing) {
      player.pause();
    } else {
      player.play();
    }

    setState(() {});
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!initialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return GestureDetector(
      onTap: togglePause,
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: 1920,
            height: 1080,
            child: Video(
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}
