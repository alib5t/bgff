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

  @override
  void initState() {
    super.initState();

    player = Player();

    controller = VideoController(player);

    player.open(
      Media(widget.path),
      play: widget.isActive,
    );

    player.setPlaylistMode(PlaylistMode.loop);
  }

  @override
  void didUpdateWidget(covariant VideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive) {
      player.play();
    } else {
      player.pause();
    }
  }

  void toggle() {
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

    return GestureDetector(
      onTap: toggle,
      child: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: Video(
          controller: controller,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
