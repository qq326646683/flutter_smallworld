// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

/// An example of using the plugin, controlling lifecycle and playback of the
/// video.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:video_player/video_player.dart';

/// Controls play and pause of [controller].
///
/// Toggles play/pause on tap (accompanied by a fading status icon).
///
/// Plays (looping) on initialization, and mutes on deactivation.
class VideoPlayPause extends StatefulWidget {
  VideoPlayPause(this.controller);

  final VideoPlayerController controller;

  @override
  State createState() {
    return _VideoPlayPauseState();
  }
}

class _VideoPlayPauseState extends State<VideoPlayPause> {
  VoidCallback listener;
  _VideoPlayPauseState() {
    listener = () {
      setState(() {});
    };
  }

  FadeAnimation imageFadeAnim =
  FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0));

  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
    controller.setVolume(1.0);
    controller.play();
  }

  @override
  void deactivate() {
    controller.setVolume(0.0);
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      GestureDetector(
        child: VideoPlayer(controller),
        onTap: () {
          if (!controller.value.initialized) {
            return;
          }
          if (controller.value.isPlaying) {
            imageFadeAnim =
                FadeAnimation(child: const Icon(Icons.pause, size: 100.0));
            controller.pause();
          } else {
            imageFadeAnim =
                FadeAnimation(child: const Icon(Icons.play_arrow, size: 100.0));
            controller.play();
          }
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      ),
      Center(child: imageFadeAnim),
      Center(
          child: controller.value.isBuffering
              ? const CircularProgressIndicator()
              : null),
    ];

    return Stack(
      fit: StackFit.passthrough,
      children: children,
    );
  }
}

class FadeAnimation extends StatefulWidget {
  FadeAnimation(
      {this.child, this.duration = const Duration(milliseconds: 500)});

  final Widget child;
  final Duration duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  void deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isAnimating
        ? Opacity(
      opacity: 1.0 - animationController.value,
      child: widget.child,
    )
        : Container();
  }
}

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

abstract class PlayerLifeCycle extends StatefulWidget {
  PlayerLifeCycle(this.dataSource, this.childBuilder);

  final VideoWidgetBuilder childBuilder;
  final String dataSource;
}

/// A widget connecting its life cycle to a [VideoPlayerController] using
/// a data source from the network.
class NetworkPlayerLifeCycle extends PlayerLifeCycle {
  NetworkPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);

  @override
  _NetworkPlayerLifeCycleState createState() => _NetworkPlayerLifeCycleState();
}

/// A widget connecting its life cycle to a [VideoPlayerController] using
/// an asset as data source
class AssetPlayerLifeCycle extends PlayerLifeCycle {
  AssetPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);

  @override
  _AssetPlayerLifeCycleState createState() => _AssetPlayerLifeCycleState();
}

abstract class _PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController controller;

  @override

  /// Subclasses should implement [createVideoPlayerController], which is used
  /// by this method.
  void initState() {
    super.initState();
    controller = createVideoPlayerController();
    controller.addListener(() {
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
    });
    controller.initialize();
    controller.setLooping(true);
    controller.play();
  }

  @override
  void deactivate() {
    super.deactivate();
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

/// A filler card to show the video in a list of scrolling contents.
Widget buildCard(String title) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.airline_seat_flat_angled),
          title: Text(title),
        ),
        ButtonTheme.bar(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {
                  /* ... */
                },
              ),
              FlatButton(
                child: const Text('SELL TICKETS'),
                onPressed: () {
                  /* ... */
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class VideoInListOfCards extends StatelessWidget {
  VideoInListOfCards(this.controller);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        buildCard("Item a"),
        buildCard("Item b"),
        buildCard("Item c"),
        buildCard("Item d"),
        buildCard("Item e"),
        buildCard("Item f"),
        buildCard("Item g"),
        Card(
            child: Column(children: <Widget>[
              Column(
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.cake),
                    title: Text("Video video"),
                  ),
                  Stack(
                      alignment: FractionalOffset.bottomRight +
                          const FractionalOffset(-0.1, -0.1),
                      children: <Widget>[
                        AspectRatioVideo(controller),
                        Image.asset('assets/flutter-mark-square-64.png'),
                      ]),
                ],
              ),
            ])),
        buildCard("Item h"),
        buildCard("Item i"),
        buildCard("Item j"),
        buildCard("Item k"),
        buildCard("Item l"),
      ],
    );
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

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
    };
    controller.addListener(listener);
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
    } else {
      return Container();
    }
  }
}

class VideoDemoPage extends StatefulWidget {
  static final String sName = "video_demo";

  @override
  _VideoDemoPageState createState() => new _VideoDemoPageState();
}

class _VideoDemoPageState extends State<VideoDemoPage> {
//  String source4 = 'http://new-mini-world.ufile.ucloud.cn/27-certify-video-721-test-998?UCloudPublicKey=1NMunmNq9U%2FcYhPqRA019BFz8Tw2VflW%2BEuEnJdTDZ6KWFPh3snwlA%3D%3D&Signature=zsKtleVEgwNYtbSIQCnT32MLmo4%3D';
  String source4 = 'http://file.jinxianyun.com/2018-06-12_16_58_22.mp4';
//  String source4 = 'http://img.ksbbs.com/asset/Mon_1703/05cacb4e02f9d9e.mp4';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    String source1 = 'http://new-mini-world.ufile.ucloud.cn/27-certify-video-721-test-998?UCloudPublicKey=1NMunmNq9U%2FcYhPqRA019BFz8Tw2VflW%2BEuEnJdTDZ6KWFPh3snwlA%3D%3D&Signature=zsKtleVEgwNYtbSIQCnT32MLmo4%3D';
    String source2 = 'rtmp://live.hkstv.hk.lxdns.com/live/hks';
    String source3 = 'rtmp://172.16.100.245/live1';
//    await ijkController.setNetworkDataSource(source4, autoPlay: true);
//    ijkController.setAssetDataSource(SMIcons.LOGIN_BG_MP4, autoPlay: true);
  }
  
  @override
  void dispose() {
    super.dispose();
//    ijkController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Video player example'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.cloud),
                  text: "cachevideo",
                ),
                Tab(
                  icon: Icon(Icons.cloud),
                  text: "ijk",
                ),
                Tab(
                  icon: Icon(Icons.cloud),
                  text: "Remote",
                ),
                Tab(icon: Icon(Icons.insert_drive_file), text: "Asset"),
                Tab(icon: Icon(Icons.list), text: "List example"),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SMCacheVideoWidget(
                      width: ScreenUtil.getInstance().screenWidth,
                      height: 500,
//                      mediaController: ijkController,
                      url: source4,
//                      doubleTapPlay: true,
                      placeImgUrl: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563879170471&di=c3c5109d8a12d11f449fb03840fa7082&imgtype=0&src=http%3A%2F%2Fimg3.doubanio.com%2Fview%2Fnote%2Flarge%2Fpublic%2Fp27390391.jpg',
                    ),
                    RaisedButton(
                      onPressed: () {
                        File tmpImgFile = new File('/data/user/0/com.example.fluttersmallworld/app_flutter/file/cache/826281028608891033.tmp');
                        print('文件是否存在:' + tmpImgFile.existsSync().toString());
                      },
                      child: Text('tmp，判断是否存在'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        File tmpImgFile = new File('/data/user/0/com.example.fluttersmallworld/app_flutter/file/cache/826281028608891033.mp4');
                        print('文件是否存在:' + tmpImgFile.existsSync().toString());
                      },
                      child: Text('mp4，判断是否存在'),
                    )

                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    RaisedButton(
                      onPressed: () {
                        File tmpImgFile = new File('/data/user/0/com.example.fluttersmallworld/app_flutter/file/cache/826281028608891033.tmp');
                        print('文件是否存在:' + tmpImgFile.existsSync().toString());
                      },
                      child: Text('tmp，判断是否存在'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        File tmpImgFile = new File('/data/user/0/com.example.fluttersmallworld/app_flutter/file/cache/826281028608891033.mp4');
                        print('文件是否存在:' + tmpImgFile.existsSync().toString());
                      },
                      child: Text('mp4，判断是否存在'),
                    )

                  ],
                ),
              ),
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
                        'http://new-mini-world.ufile.ucloud.cn/27-certify-video-721-test-998?UCloudPublicKey=1NMunmNq9U%2FcYhPqRA019BFz8Tw2VflW%2BEuEnJdTDZ6KWFPh3snwlA%3D%3D&Signature=zsKtleVEgwNYtbSIQCnT32MLmo4%3D',
                            (BuildContext context,
                            VideoPlayerController controller) =>
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
        ),
      ),
    );
  }


  Widget _buildImgHolder([IconData iconData, Function onTap]) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SMCacheImageWidget('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563879170471&di=c3c5109d8a12d11f449fb03840fa7082&imgtype=0&src=http%3A%2F%2Fimg3.doubanio.com%2Fview%2Fnote%2Flarge%2Fpublic%2Fp27390391.jpg'),
        iconData != null ? Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              iconSize: 30,
              color: Colors.black,
              icon: Icon(iconData),
              onPressed: onTap,
            ),
          ),
        ): SizedBox()
      ],
    );
  }

  Widget _buildPauseBtn(IconData iconData, Function onTap) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(30),
        ),
        child: IconButton(
          iconSize: 30,
          color: Colors.black,
          icon: Icon(iconData),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildProgressWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 60,
        child: RefreshProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
  }
}

