import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class SMCacheVideoWidget extends StatefulWidget {
  final double width;
  final double height;
  final IjkMediaController mediaController;
  final String url;
  final String placeImgUrl;

  // 配置
  final bool verticalGesture;
  final bool horizontalGesture;
  final bool showFullScreenButton;
  final bool showBottomBar;
  final bool doubleTapPlay;
  final bool loop;

  SMCacheVideoWidget({
    @required this.width,
    @required this.height,
    @required this.mediaController,
    @required this.url,
    @required this.placeImgUrl,
    this.verticalGesture = true,
    this.horizontalGesture = true,
    this.showFullScreenButton = true,
    this.showBottomBar = true,
    this.doubleTapPlay = false,
    this.loop = false,
  });

  @override
  _SMCacheVideoWidgetState createState() => _SMCacheVideoWidgetState();
}

class _SMCacheVideoWidgetState extends State<SMCacheVideoWidget> {
  static String sName = "_SMCacheVideoWidgetState";
  StreamSubscription<IjkStatus> ijkStatusSubscribe;

  @override
  void initState() {
    super.initState();
    ijkStatusSubscribe =  widget.mediaController.ijkStatusStream.listen((IjkStatus ijkStatus) async {
      LogUtil.i(sName, 'ijkStatus', ijkStatus);
      if (widget.loop && ijkStatus == IjkStatus.complete) {
        await widget.mediaController?.seekTo(0);
        await widget.mediaController?.play();
      }
    });
    init();

  }

  @override
  void dispose() {
    widget.mediaController.dispose();
    ijkStatusSubscribe.cancel();
    super.dispose();
  }

  init() {
    if (widget.url.startsWith('http')) {
      // 网络视频 1.找本地是否有
      CacheFile cacheFile = CacheFileUtil.getCacheFile(widget.url,
          cacheFileType: CacheFileType.VIDEO);
      if (cacheFile != null) {
        // a.有本地显示
        LogUtil.i(sName, '找本地视频-有本地显示' + cacheFile.filePath);
        setLocalVideoFile(cacheFile.filePath);
      } else {
        // b.无本地下载,并播放
        LogUtil.i(sName, '找本地视频-无本地下载' + widget.url);
        widget.mediaController.setNetworkDataSource(widget.url, autoPlay: true);
        CacheFileUtil.setCacheFile(CacheFileType.VIDEO, widget.url);
      }
    } else {
      //源为本地视频
      LogUtil.i(sName, '本地视频' + widget.url);
      setLocalVideoFile(widget.url);
    }
  }

  setLocalVideoFile(String path) async {
    File tmpImgFile = new File(path);
    bool isExists = await tmpImgFile.exists();
    if (!isExists) {
      throw new FileSystemException("localVideoFile is not exist", path);
    } else {
      if (mounted) {
        widget.mediaController.setFileDataSource(tmpImgFile, autoPlay: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: IjkPlayer(
        mediaController: widget.mediaController,
        controllerWidgetBuilder: (controller) =>
          DefaultIJKControllerWidget(
            controller: controller,
            verticalGesture: widget.verticalGesture,
            horizontalGesture: widget.horizontalGesture,
            showFullScreenButton: widget.showFullScreenButton,
            showBottomBar: widget.showBottomBar,
            doubleTapPlay: widget.doubleTapPlay,
          ),
        statusWidgetBuilder: buildStatusWidget,
      ),
    );
  }




  Widget buildStatusWidget(BuildContext context, IjkMediaController controller, IjkStatus status) {
    switch (status) {
      case IjkStatus.noDatasource:
      case IjkStatus.error:
        return SMCacheImageWidget(widget.placeImgUrl, width: widget.width, height: widget.height,);
      case IjkStatus.preparing:
        return _buildProgressWidget(context);
      case IjkStatus.pause:
        return _buildCenterIconButton(Icons.play_arrow, controller.play);
      case IjkStatus.complete:
        return _buildCenterIconButton(Icons.replay, () async {
          await controller?.seekTo(0);
          await controller?.play();
        });
      case IjkStatus.playing:
      case IjkStatus.prepared:
      default:
        return SizedBox();
    }
  }


  Widget _buildCenterIconButton(IconData iconData, Function onTap) {
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
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SMCacheImageWidget(widget.placeImgUrl, width: widget.width, height: widget.height,),
        Center(
          child: Container(
            width: 60,
            height: 60,
            child: RefreshProgressIndicator(
              backgroundColor: Colors.transparent,
              strokeWidth: 1,
              valueColor: AlwaysStoppedAnimation(SMColors.grayLineColor),
            ),
          ),
        ),
      ],
    );
  }
}

typedef Widget IJKControllerWidgetBuilder(IjkMediaController controller);
