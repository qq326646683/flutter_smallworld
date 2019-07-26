import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:video_player/video_player.dart';

Widget defaultProgressBuilder(VideoPlayerController controller) => SizedBox();

class SMCacheVideoWidget extends StatefulWidget {
  final double width;
  final double height;
  final String url;
  final String placeImgUrl;

  // 配置
  final bool loop;
  final bool autoPlay;
  final ProgressWidget progressWidget;
  final bool isClickPause;
  final bool showCover;

  SMCacheVideoWidget({
    @required this.width,
    @required this.height,

    @required this.url,
    @required this.placeImgUrl,
    this.loop = false,
    this.autoPlay = false,
    this.progressWidget = defaultProgressBuilder,
    this.isClickPause = false,
    this.showCover = true,

  });

  @override
  _SMCacheVideoWidgetState createState() => _SMCacheVideoWidgetState();
}

class _SMCacheVideoWidgetState extends State<SMCacheVideoWidget> {
  static String sName = "_SMCacheVideoWidgetState";
  VideoPlayerController _controller;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
    init();

  }

  config() {
    if (widget.loop) _controller.setLooping(widget.loop);
    if (widget.autoPlay) _controller.play();
    _controller.addListener(listener);

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.removeListener(listener);
    super.deactivate();
  }



  init() {
    // 网络
    LogUtil.i(sName, 'url::', widget.url);
    LogUtil.i(sName, 'imgurl::', widget.placeImgUrl);
    if (widget.url == null) return;
    if (widget.url.startsWith('http')) {
      // 网络视频 1.找本地是否有
      CacheFile cacheFile = CacheFileUtil.getCacheFile(widget.url,
          cacheFileType: CacheFileType.VIDEO);
      if (cacheFile != null) {
        // a.有本地显示
        LogUtil.i(sName, '找本地视频-有本地显示' + cacheFile.filePath);
        setVideo(VideoType.file, cacheFile.filePath);
      } else {
        // b.无本地下载,并播放net
        LogUtil.i(sName, '找本地视频-无本地下载, network视频' + widget.url);
        setVideo(VideoType.network);
        CacheFileUtil.setCacheFile(CacheFileType.VIDEO, widget.url, onReceiveProgress: (int count, int total) {});

      }
    } else if (widget.url.startsWith('static')) {
      // 源为asset视频
      LogUtil.i(sName, 'asset视频' + widget.url);
      setVideo(VideoType.asset);
    } else {
      // 源为本地视频
      LogUtil.i(sName, '本地视频' + widget.url);
      setVideo(VideoType.file);
    }
  }

  setVideo(VideoType videoType, [String filePath]) {
    if (!mounted) return;
    if (videoType == VideoType.asset) {
      _controller = VideoPlayerController.asset(widget.url);
    } else if (videoType == VideoType.network) {
      _controller = VideoPlayerController.network(widget.url);
    } else {
      File tmpImgFile = new File(filePath ?? widget.url);
      bool isExists = tmpImgFile.existsSync();
      if (!isExists) {
        throw new FileSystemException("localVideoFile is not exist", filePath ?? widget.url);
      } else {
        _controller = VideoPlayerController.file(tmpImgFile);
      }
    }
    config();
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null && _controller.value.initialized) {
      Widget body = Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      );

      if (widget.isClickPause) {
        body = GestureDetector(
          onTap: () {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              body,
              _controller.value.isPlaying ? SizedBox() : Icon(Icons.play_arrow, size: 100, color: SMColors.opacity60CoverWhite,),
            ],
          ),
        );
      }


      return Container(
        width: widget.width,
        height: widget.height,
        color: SMColors.black,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            body,
            widget.progressWidget.call(_controller),
            widget.showCover ? _buildCover() : SizedBox()
          ],
        ),
      );
    } else {
      return SMCacheImageWidget(widget.placeImgUrl, width: widget.width, height: widget.height);
    }
  }
  bool showCoverButton = true;

  Widget _buildCover() {
    return Stack(
      children: <Widget>[
        _buildBodyCover(),
        showCoverButton ? _buildBottomBar() : SizedBox(),
      ],
    );
  }

  Widget _buildBodyCover() {
    return GestureDetector(
      onTap: () {
        if (!mounted) return;
        setState(() {
          showCoverButton = !showCoverButton;
        });



      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Color(0x3366ee55),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: widget.width,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [SMColors.opacity30Cover, SMColors.opacity60Cover], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(icon: Icon(_controller.value.isPlaying ? Icons.pause :Icons.play_arrow, color: SMColors.white,), onPressed: () {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
              setState(() {});
            }),
            SizedBox(width: _Style.bottomBarChildPadding5,),
            Expanded(
              child: SMVideoProgressWidget(
                _controller,
                allowScrubbing: true,
                colors: VideoProgressColors(playedColor: Colors.pink, bufferedColor: SMColors.opacity60CoverWhite, backgroundColor: SMColors.opacity30CoverWhite),
                padding: EdgeInsets.all(0.0),
              ),
            ),
            SizedBox(width: _Style.bottomBarChildPadding10,),
            Text('${TimeUtil.formatDuration(_controller.value.position)}/${TimeUtil.formatDuration(_controller.value.duration)}', style: SMTxtStyle.minTextWhite,),
            SizedBox(width: _Style.bottomBarChildPadding5,),
            IconButton(icon: Icon(Icons.fullscreen, color: SMColors.white,), onPressed: () {

            }),
          ],
        ),
      ),
    );
  }
}

typedef ProgressWidget = Widget Function(VideoPlayerController controller);

enum VideoType {
  asset,
  file,
  network
}

class _Style {
  static double bottomBarChildPadding5 = ScreenUtil.getInstance().getWidth(3.0);
  static double bottomBarChildPadding10 = ScreenUtil.getInstance().getWidth(10.0);
}


