import 'package:json_annotation/json_annotation.dart';

part 'cachefile.g.dart';

@JsonSerializable()
class CacheFile {
  CacheType cacheType;
  CacheFileType cacheFileType;
  String fileUrl;
  String filePath;
  DateTime createTime;

  CacheFile(
    this.cacheFileType,
    this.fileUrl,
    this.cacheType,
    this.filePath,
    this.createTime,
  );

  factory CacheFile.fromJson(Map<String, dynamic> json) =>
      _$CacheFileFromJson(json);

  Map<String, dynamic> toJson() => _$CacheFileToJson(this);

  CacheFile.empty();
}

enum CacheType {
  CACHE,
  COMMON,
}

enum CacheFileType {
  VIDEO,
  IMAGE,
}
