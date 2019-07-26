import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMCacheImageWidget extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  SMCacheImageWidget(this.url, {this.width, this.height, this.fit});

  @override
  _SMCacheImageWidgetState createState() => new _SMCacheImageWidgetState();
}

class _SMCacheImageWidgetState extends State<SMCacheImageWidget> {
  static String sName = "SMCacheImageWidget";
  File imgFile;
  CurrentShow currentShow = CurrentShow.Default;
  double downloadProgressValue = 1;

  @override
  void initState() {
    super.initState();
    if (widget.url != null) {
      init();
    }
  }

  init() async {
    if (widget.url.startsWith('http')) {
      // 网络图片 1.找本地是否有
      CacheFile cacheFile = CacheFileUtil.getCacheFile(widget.url);
      if (cacheFile != null) {
        // a.有本地显示
        LogUtil.i(sName, '找本地-有本地显示' + cacheFile.filePath);
        setLocalImgFile(cacheFile.filePath);
      } else {
        // b.无本地下载,等待下载
        LogUtil.i(sName, '找本地-无本地下载' + widget.url);
        CacheFile completeCacheFile = await CacheFileUtil.setCacheFile(CacheFileType.IMAGE, widget.url, onReceiveProgress: (int count, int total) {
          if (mounted) {
            setState(() {
              downloadProgressValue = count / total;
            });
          }
        });
        if (completeCacheFile != null) {
          LogUtil.i(sName, '下载完成' + widget.url);
          // c.下载完成替换
          setLocalImgFile(completeCacheFile.filePath);
        }
      }
    } else {
      //源为本地图片
      LogUtil.i(sName, '本地图片' + widget.url);
      setLocalImgFile(widget.url);
    }
  }

  setLocalImgFile(String path) async {
    File tmpImgFile = new File(path);
    bool isExists = await tmpImgFile.exists();
    if (!isExists) {
      throw new FileSystemException("localImgFile is not exist", path);
    } else {
      if (mounted) {
        this.setState(() {
          imgFile = tmpImgFile;
          currentShow = CurrentShow.Local;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentShow == CurrentShow.Local) {
      LogUtil.i(sName, 'Image.file:' + widget.url);
      return Image.file(imgFile,
          width: widget.width, height: widget.height, fit: widget.fit);
    } else if (currentShow == CurrentShow.Default) {
      LogUtil.i(sName, 'Image.asset:' + widget.url);
      return Container(
        color: SMColors.black,
        width: widget.width,
        height: widget.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(SMIcons.HOT_TIP, width: 100, fit: widget.fit),
            Container(color: SMColors.opacity75Cover, width: widget.width, height: widget.height),
            downloadProgressValue != 1 ? CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: SMColors.lightGolden,
                value: downloadProgressValue,
            ): SizedBox()
          ],
        ),
      );
    }
  }
}

enum CurrentShow { Default, Local }
