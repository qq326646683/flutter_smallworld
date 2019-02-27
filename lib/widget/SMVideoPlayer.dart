import 'package:flutter/material.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class SMVideoPlayer extends StatefulWidget {
  File file;


  SMVideoPlayer({this.file});

  @override
  _SMVideoPlayerState createState() => new _SMVideoPlayerState();
}

class _SMVideoPlayerState extends State<SMVideoPlayer> {
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file);

    _controller.setLooping(true);
    _controller.play();
    _controller.initialize().then((_) {
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.initialized
        ? VideoPlayer(_controller)
        : Container();
  }
}
