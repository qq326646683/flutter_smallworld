// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskhallResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskhallResult _$TaskhallResultFromJson(Map<String, dynamic> json) {
  return TaskhallResult(
      progress: json['progress'] == null
          ? null
          : TaskhallProgress.fromJson(json['progress'] as Map<String, dynamic>),
      list: (json['list'] as List)
          ?.map((e) =>
              e == null ? null : Taskhall.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$TaskhallResultToJson(TaskhallResult instance) =>
    <String, dynamic>{'progress': instance.progress, 'list': instance.list};
