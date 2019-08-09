// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_item_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankItem _$RankItemFromJson(Map<String, dynamic> json) {
  return RankItem(
      json['is_new'] as int,
      json['rank_flag'] as int,
      json['ranking'] as int,
      json['rank_change'] as int,
      json['amount'] as int,
      json['user_id'] as String,
      json['nickname'] as String,
      json['avatar'] as String,
      json['vip'] as String);
}

Map<String, dynamic> _$RankItemToJson(RankItem instance) => <String, dynamic>{
      'is_new': instance.is_new,
      'rank_flag': instance.rank_flag,
      'ranking': instance.ranking,
      'rank_change': instance.rank_change,
      'amount': instance.amount,
      'user_id': instance.user_id,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'vip': instance.vip
    };
