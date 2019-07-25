import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:video_player/video_player.dart';

class SMCacheVideoWidget extends StatefulWidget {
  final double width;
  final double height;
  final String url;
  final String placeImgUrl;

  // 配置
  final bool loop;
  final bool autoPlay;

  SMCacheVideoWidget({
    @required this.width,
    @required this.height,
    @required this.url,
    @required this.placeImgUrl,
    this.loop = false,
    this.autoPlay = false,
  });

  @override
  _SMCacheVideoWidgetState createState() => _SMCacheVideoWidgetState();
}

class _SMCacheVideoWidgetState extends State<SMCacheVideoWidget> {
  static String sName = "_SMCacheVideoWidgetState";
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  config() {
    if (widget.loop) _controller.setLooping(widget.loop);
    if (widget.autoPlay) _controller.play();
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
        CacheFileUtil.setCacheFile(CacheFileType.VIDEO, widget.url, onReceiveProgress: (int count, int total) {
//          LogUtil.i(sName, 'count:', count);
//
//          if (count / total > 0.5) {
//            if (!isPlaying) {
//              LogUtil.i(sName, 'play:');
//
//              setVideo(VideoType.file, CacheFileUtil.calculateCacheFilePath(widget.url, cacheFileType: CacheFileType.VIDEO));
//              isPlaying = true;
//            }
//          }

        });

      }
    } else if (widget.url.startsWith('static')) {
      //源为本地视频
      LogUtil.i(sName, 'asset视频' + widget.url);
      setVideo(VideoType.asset);
    } else {
      LogUtil.i(sName, '本地视频' + widget.url);
      setVideo(VideoType.file);
    }
  }
  bool isPlaying = false;

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
        print('heheh');
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
    return _controller != null && _controller.value.initialized ?
    Container(
      width: widget.width,
      height: widget.height,
      child: VideoPlayer(_controller),
    )
        :
    SMCacheImageWidget(
        widget.placeImgUrl, width: widget.width, height: widget.height);
  }
}

enum VideoType {
  asset,
  file,
  network
}

