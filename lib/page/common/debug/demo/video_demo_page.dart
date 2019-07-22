import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:video_player/video_player.dart';

class VideoDemoPage extends StatefulWidget {
  static final String sName = "video_demo";

  @override
  _VideoDemoPageState createState() => _VideoDemoPageState();
}

class _VideoDemoPageState extends State<VideoDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SMTitleBarWidget(
        title: 'VideoDemo',
      ),
      body: TabBarView(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                const Text('With remote m3u8'),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: NetworkPlayerLifeCycle(
                    'http://184.72.239.149/vod/smil:BigBuckBunny.smil/playlist.m3u8',
                    (BuildContext context, VideoPlayerController controller) =>
                        AspectRatioVideo(controller),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                const Text('With assets mp4'),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: AssetPlayerLifeCycle(
                      SMIcons.LOGIN_BG_MP4,
                      (BuildContext context,
                              VideoPlayerController controller) =>
                          AspectRatioVideo(controller)),
                ),
              ],
            ),
          ),
          AssetPlayerLifeCycle(
              SMIcons.LOGIN_BG_MP4,
              (BuildContext context, VideoPlayerController controller) =>
                  VideoInListOfCards(controller)),
        ],
      ),
    );
  }
}

class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;

  AspectRatioVideo(this.controller);

  VoidCallback listener;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }

      controller.addListener(listener);
    };
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayPause(controller),
        ),
      );
    }
    return SizedBox();
  }
}

class VideoPlayPause extends StatefulWidget {
  final VideoPlayerController controller;

  VideoPlayPause(this.controller);

  @override
  _VideoPlayPauseState createState() => _VideoPlayPauseState();
}

class _VideoPlayPauseState extends State<VideoPlayPause> {
  VideoPlayerController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

abstract class PlayerLifeCycle extends StatefulWidget {
  PlayerLifeCycle(this.dataSource, this.childBuilder);

  final VideoWidgetBuilder childBuilder;
  final String dataSource;
}

abstract class _PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = createVideoPlayerController();
    controller.addListener(() {
      if (controller.value.hasError) {
        LogUtil.i(controller.value.errorDescription);
      }
    });
    controller.initialize();
    controller.setLooping(true);
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }

  VideoPlayerController createVideoPlayerController();
}

class NetworkPlayerLifeCycle extends PlayerLifeCycle {
  NetworkPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);

  @override
  State<StatefulWidget> createState() {
    return _NetworkPlayerLifeCycleState();
  }
}

class AssetPlayerLifeCycle extends PlayerLifeCycle {
  AssetPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);

  @override
  State<StatefulWidget> createState() {
    return _AssetPlayerLifeCycleState();
  }
}

class _NetworkPlayerLifeCycleState extends _PlayerLifeCycleState {
  @override
  VideoPlayerController createVideoPlayerController() {
    return VideoPlayerController.network(widget.dataSource);
  }
}

class _AssetPlayerLifeCycleState extends _PlayerLifeCycleState {
  @override
  VideoPlayerController createVideoPlayerController() {
    return VideoPlayerController.asset(widget.dataSource);
  }
}
