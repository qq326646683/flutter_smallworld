// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankListResult _$RankListResultFromJson(Map<String, dynamic> json) {
  return RankListResult(
      json['total'] as int,
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : RankItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RankListResultToJson(RankListResult instance) =>
    <String, dynamic>{'total': instance.total, 'list': instance.list};
