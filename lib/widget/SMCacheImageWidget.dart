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
  static String TAG = "SMCacheImageWidget:";
  File imgFile;
  CurrentShow currentShow = CurrentShow.Default;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.url.startsWith('http')) {
      // 网络图片 1.找本地是否有
      CacheFile cacheFile = await CacheFileUtil.getCacheFile(widget.url);
      if (cacheFile != null) {
        // a.有本地显示
        print(TAG + '找本地-有本地显示' + cacheFile.filePath);
//        print(CacheFileUtil.appDirection);
        setLocalImgFile(CacheFileUtil.appDirection + cacheFile.filePath);
      } else {
        // b.无本地下载,并显示远程
        currentShow = CurrentShow.Remote;
        this.setState((){});
        print(TAG + '找本地-无本地下载' + widget.url);
        CacheFileUtil.setCacheFile(CacheFileType.IMAGE, widget.url);
      }
    } else {
      //源为本地图片
      print(TAG + '本地图片' + widget.url);
      setLocalImgFile(widget.url);
    }
  }
  
  setLocalImgFile(String path) async {
    File tmpImgFile = new File(path);
    bool isExists = await tmpImgFile.exists();
    if (!isExists) {
      throw new FileSystemException("localFile is not exist", path);
    } else {
      imgFile = tmpImgFile;
      currentShow = CurrentShow.Local;
      this.setState((){});
    }
  }
  

  @override
  Widget build(BuildContext context) {
    if (currentShow == CurrentShow.Remote) {
      print('Image.network:' + widget.url);
      return Image.network(widget.url, width: widget.width, height: widget.height, fit: widget.fit);
    } else if (currentShow == CurrentShow.Local){
      print('Image.file:' + widget.url);
      return Image.file(imgFile, width: widget.width, height: widget.height, fit: widget.fit);
    } else if (currentShow == CurrentShow.Default){
      return Image.asset(SMIcons.EARTH, width: widget.width, height: widget.height, fit: widget.fit);
    }
  }
}

enum CurrentShow {
  Default,
  Local,
  Remote
}
