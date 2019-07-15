// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_log_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetLogEntityList _$NetLogEntityListFromJson(Map<String, dynamic> json) {
  return NetLogEntityList(
      netLogEntityList: (json['netLogEntityList'] as List)
          ?.map((e) => e == null
              ? null
              : NetLogEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NetLogEntityListToJson(NetLogEntityList instance) =>
    <String, dynamic>{'netLogEntityList': instance.netLogEntityList};

NetLogEntity _$NetLogEntityFromJson(Map<String, dynamic> json) {
  return NetLogEntity(
      url: json['url'] as String,
      requestTime: json['requestTime'] == null
          ? null
          : DateTime.parse(json['requestTime'] as String),
      method: json['method'] as String,
      status: json['status'] as int,
      responseTime: json['responseTime'] == null
          ? null
          : DateTime.parse(json['responseTime'] as String),
      requestHeader: json['requestHeader'] as String,
      requestBody: json['requestBody'] as String,
      responseBody: json['responseBody'] as String,
      error: json['error'] as String,
      errorTime: json['errorTime'] == null
          ? null
          : DateTime.parse(json['errorTime'] as String))
    ..timeLine = json['timeLine'] as String;
}

Map<String, dynamic> _$NetLogEntityToJson(NetLogEntity instance) =>
    <String, dynamic>{
      'url': instance.url,
      'requestTime': instance.requestTime?.toIso8601String(),
      'method': instance.method,
      'status': instance.status,
      'timeLine': instance.timeLine,
      'requestHeader': instance.requestHeader,
      'requestBody': instance.requestBody,
      'responseTime': instance.responseTime?.toIso8601String(),
      'responseBody': instance.responseBody,
      'error': instance.error,
      'errorTime': instance.errorTime?.toIso8601String()
    };
