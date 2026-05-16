import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

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
  late BetterPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: false,
        looping: true,
        fit: BoxFit.cover,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
        ),
      ),
    );

    controller.setupDataSource(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.asset,
        widget.path,
      ),
    );

    if (widget.isActive) {
      controller.play();
    }
  }

  @override
  void didUpdateWidget(covariant VideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isActive) {
      controller.play();
    } else {
      controller.pause();
    }
  }

  void togglePlay() {
    if (controller.isPlaying() == true) {
      controller.pause();
    } else {
      controller.play();
    }

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePlay,
      child: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: BetterPlayer(
          controller: controller,
        ),
      ),
    );
  }
}
