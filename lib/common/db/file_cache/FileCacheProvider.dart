import 'package:flutter_smallworld/common/db/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:sqflite/sqflite.dart';

class FileCacheProvider extends BaseProvider {
  final String TABLENAME = "file_cache";
  final String columnId = "_id";
  final String columnCacheType = "cacheType";
  final String columnCacheFileType = "cacheFileType";
  final String columnFileUrl = "fileUrl";
  final String columnFilePath = "filePath";
  final String columnCreateTime = "createTime";

  static FileCacheProvider fileCacheProvider;

  static FileCacheProvider getInstance() {
    if (fileCacheProvider == null) {
      fileCacheProvider = new FileCacheProvider();
    }
    return fileCacheProvider;
  }


  @override
  tableName() {
    return TABLENAME;
  }

  @override
  tableSqlString() {
    return tableBaseString(TABLENAME, columnId) +
      '''
      $columnCacheType text not null,
      $columnCacheFileType text not null,
      $columnFileUrl text not null,
      $columnFilePath text not null,
      $columnCreateTime text not null
      '''
    ;
  }

  Future<CacheFile> getCacheFileByFileUrl(String fileUrl) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> mapList = await db.query(TABLENAME, where: "$columnFileUrl = ?", whereArgs: [fileUrl]);
    if (mapList.length > 0) {
      return CacheFile.fromJson(mapList.first);
    }
    return null;
  }

  Future insert(CacheFile cacheFile) async {
    Database db = await getDatabase();
    CacheFile findCacheFile = await getCacheFileByFileUrl(cacheFile.fileUrl);
    if (findCacheFile != null) {
      await db.delete(TABLENAME, where: "$columnFileUrl = ?", whereArgs: [cacheFile.fileUrl]);
    }
    await db.insert(TABLENAME, cacheFile.toJson());
  }



}