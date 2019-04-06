import 'package:flutter_smallworld/common/db/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_smallworld/common/net/HttpManager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class CacheFileUtil {
  static String cacheDirection;
  static String commonDirection;
  static String appDirection;

  static setCacheFile(CacheFileType cacheFileType, String url,
      {CacheType cacheType = CacheType.CACHE,
      ProgressCallback onReceiveProgress,
      CancelToken cancelToken}) async {
    /// 文件名字
    String fileNameAndSuffix;
    switch (cacheFileType) {
      case CacheFileType.IMAGE:
        fileNameAndSuffix = UUIDUtil.uuid.v1() + '.png';
        break;
      case CacheFileType.VIDEO:
        fileNameAndSuffix = UUIDUtil.uuid.v1() + '.mp4';
        break;
    }

    // 文件保存路径
    if (appDirection == null) {
      await initDirection();
    }
    String savePath;
    switch (cacheType) {
      case CacheType.CACHE:
        savePath = cacheDirection + fileNameAndSuffix;
        break;
      case CacheType.COMMON:
        savePath = commonDirection + fileNameAndSuffix;
        break;
    }

    try {
      Response response = await HttpManager.dio.download(url, savePath,
          onReceiveProgress: onReceiveProgress, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        CacheFile cacheFile = new CacheFile(cacheFileType, url, cacheType, savePath, DateTime.now());


        //下载成功，存入数据库
        await FileCacheProvider.getInstance().insert(cacheFile);

        return cacheFile;
      }
    } catch (e) {
      print('CacheUtil失败');
      print(e);
    }
  }

  static Future<CacheFile> getCacheFile(String remoteUrl) async {
    CacheFile findCacheFile = await FileCacheProvider.getInstance().getCacheFileByFileUrl(remoteUrl);
    return findCacheFile;
  }

  static initDirection() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    appDirection = appDocDir.path;
    cacheDirection = appDirection + '/file/cache/';
    commonDirection = appDirection + '/file/common/';

    new Directory(cacheDirection).create(recursive: true);
    new Directory(commonDirection).create(recursive: true);
  }
}
