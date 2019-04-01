// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CacheFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CacheFile _$CacheFileFromJson(Map<String, dynamic> json) {
  return CacheFile(
      _$enumDecodeNullable(_$CacheFileTypeEnumMap, json['cacheFileType']),
      json['fileUrl'] as String,
      _$enumDecodeNullable(_$CacheTypeEnumMap, json['cacheType']),
      json['filePath'] as String,
      json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String));
}

Map<String, dynamic> _$CacheFileToJson(CacheFile instance) => <String, dynamic>{
      'cacheType': _$CacheTypeEnumMap[instance.cacheType],
      'cacheFileType': _$CacheFileTypeEnumMap[instance.cacheFileType],
      'fileUrl': instance.fileUrl,
      'filePath': instance.filePath,
      'createTime': instance.createTime?.toIso8601String()
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$CacheFileTypeEnumMap = <CacheFileType, dynamic>{
  CacheFileType.VIDEO: 'VIDEO',
  CacheFileType.IMAGE: 'IMAGE'
};

const _$CacheTypeEnumMap = <CacheType, dynamic>{
  CacheType.CACHE: 'CACHE',
  CacheType.COMMON: 'COMMON'
};
